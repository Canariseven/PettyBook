#import "AGTAnnotations.h"
#import "AGTLocation.h"
@import CoreLocation;
@interface AGTAnnotations ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
+(NSArray *)observableKeyNames;
// Private interface goes here.

@end

@implementation AGTAnnotations
@synthesize locationManager=_locationManager;

-(BOOL)hasLocation{
    return (nil != self.location);
}

+(NSArray *)observableKeyNames{
    return @[AGTAnnotationsAttributes.creationDate,AGTAnnotationsAttributes.text,@"photo.imageData",@"location.latitude",@"location.longitude",@"location.address"];
}
+(instancetype) annotationWithBook:(AGTBook *)book
                           context:(NSManagedObjectContext *)context{
    AGTAnnotations * an = [self insertInManagedObjectContext:context];
    an.book = book;
    an.creationDate = [NSDate date];
    an.modificationDate = [NSDate date];
    return an;
}

#pragma mark - LifeCycle NSManagedObject
-(void)awakeFromInsert{
    [super awakeFromInsert];
    [self setupKVO];

    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ( ((status == kCLAuthorizationStatusAuthorizedWhenInUse) || (status == kCLAuthorizationStatusNotDetermined))
        && [CLLocationManager locationServicesEnabled]) {
        
        // Tenemos acceso a localización
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        // No me interesan datos pasado mucho tiempo, asi que si no
        // recibimos posición en menos de 5 segundos, paramos al
        // locationManager
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
}
-(void)awakeFromFetch{
    [super awakeFromFetch];
    [self setupKVO];
}
-(void)willTurnIntoFault{
    [super willTurnIntoFault];
    [self tearDownKVO];
}

#pragma mark - KVO
-(void) setupKVO{
    
    NSArray * keys = [AGTAnnotations observableKeyNames];
    for (NSString *key in keys) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }

}

-(void) tearDownKVO{
    NSArray * keys = [AGTAnnotations observableKeyNames];
    for (NSString *key in keys) {
        [self removeObserver:self
                  forKeyPath:key];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    self.modificationDate = [NSDate date];
}





#pragma mark - CLLocationManagerDelegate
-(void) locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    // paramos el location manager, que consume mucha bateria
    [self zapLocationManager];
    if (self.location == nil) {
        // Pillamos la última
        CLLocation *loc = [locations lastObject];
        
        // Creamos una AGTLocation
        self.location = [AGTLocation locationWithCLLocation:loc
                                                    forAnnotation:self];
    }else{
        // Hay un bug desde iOS 4 que hace que a veces un location mana
        // siga mandando mensajes después de habersele dicho que pare.
        // No está claro que esté del todo resuelto, así que nos precavemos
        // con este if.
        NSLog(@"No deberíamos llegar aquí jamás");
    }
}



#pragma mark - Utils
-(void)zapLocationManager{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}




@end
