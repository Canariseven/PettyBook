#import "AGTLocation.h"
#import "AGTAnnotations.h"
#import "AGTMapSnapShot.h"
#import <CoreLocation/CoreLocation.h>
@import AddressBookUI;
@interface AGTLocation ()

// Private interface goes here.

@end

@implementation AGTLocation

-(void)willTurnIntoFault{
    [super willTurnIntoFault];
   
}

+(instancetype) locationWithCLLocation:(CLLocation*)location forAnnotation:(AGTAnnotations *) annotation{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001",
                             location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001",
                              location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error;
    NSArray *results = [annotation.managedObjectContext executeFetchRequest:req
                                                                error:&error];
    
    NSAssert(results, @"¡Error al buscar una AGTLocation!");
    
    if ([results count]) {
        
        // Aprovechamos lo encontrado
        AGTLocation *found = [results lastObject];
        [found addAnnotationsObject:annotation];
        return found;
        
    }else{
        // Creamos uno de cero
        AGTLocation *loc = [self insertInManagedObjectContext:annotation.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addAnnotationsObject:annotation];
        
        // Dirección
        CLGeocoder *coder = [[CLGeocoder alloc]init];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        if (error) {
                            NSLog(@"Error while obtaining address!\n%@", error);
                        }else{
                            loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                            
                        }
                    }];
        
        // Snapshot
        loc.mapSnapShot = [AGTMapSnapShot mapSnapshotForLocation:loc];
        
        return loc;
        
    }

}
#pragma mark - MKAnnotation
-(NSString*) title{
    return @"I wrote a note here!";
}

-(NSString *) subtitle{
    NSArray *lines = [self.address componentsSeparatedByString:@"\n"];
    NSMutableString *concat = [@"" mutableCopy];
    for (NSString *line in lines) {
        [concat appendFormat:@"%@ ", line];
    }
    
    return concat;
}

-(CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.latitudeValue, self.longitudeValue);
    return coord;
}

-(void)prepareForDeletion{
    [super prepareForDeletion];
    if (self.mapSnapShot) {
        [self.mapSnapShot stopObserving];
    }
}



@end
