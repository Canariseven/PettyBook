#import "_AGTLocation.h"
@import MapKit;
@import  CoreLocation;
@class AGTAnnotations;

@interface AGTLocation : _AGTLocation<MKAnnotation>{}
// Custom logic goes here.
+(instancetype) locationWithCLLocation:(CLLocation*)location forAnnotation:(AGTAnnotations *) annotation;
@end
