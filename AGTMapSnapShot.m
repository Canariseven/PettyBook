#import "AGTMapSnapShot.h"
#import "AGTLocation.h"
#import "AGTAnnotations.h"
@interface AGTMapSnapShot ()

// Private interface goes here.

@end

@implementation AGTMapSnapShot

+(NSArray *)observableKeyNames{
    return @[AGTAnnotationsRelationships.location,AGTLocationRelationships.mapSnapShot,AGTMapSnapShotAttributes.snapShotData];
}
-(UIImage *) image{
    
    return [UIImage imageWithData:self.snapShotData];
}

-(void) setImage:(UIImage *)image{
    self.snapShotData = UIImageJPEGRepresentation(image, 0.9);
}

+(instancetype) mapSnapshotForLocation:(AGTLocation*) location{
    
    AGTMapSnapShot *snap = [AGTMapSnapShot insertInManagedObjectContext:location.managedObjectContext];
    
    snap.location = location;
    return snap;
}

#pragma mark - Init
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    // empezamos a observar location. cuando cambia, recalculamos el
    // snapshot
    [self startObserving];
    
    
}

-(void) awakeFromFetch{
    [super awakeFromFetch];
    
    // empezamos a observar location. cuando cambia, recalculamos el
    // snapshot
    [self startObserving];
}

-(void) willTurnIntoFault{
    [super willTurnIntoFault];

    
}

#pragma mark -  KVO
-(void) startObserving{
    [self addObserver:self
           forKeyPath:@"location"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

-(void) stopObserving{
    if (self.observationInfo) {
        self.image = nil;
        [self removeObserver:self
                  forKeyPath:@"location"];
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    
    // Creamos el snapshot
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.location.latitudeValue, self.location.longitudeValue);
    
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    options.region = MKCoordinateRegionMakeWithDistance(center, 300, 300);
    options.mapType = MKMapTypeHybrid;
    options.size = CGSizeMake(150, 150);
    
    MKMapSnapshotter *shotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    [shotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        
        if (!error) {
            
            self.image = snapshot.image;
            
        }else{
            // Mi existencia no tiene sentido...
            [self setPrimitiveLocation:nil];
            [self.managedObjectContext deleteObject:self];
        }
        
    }];
    
}

@end
