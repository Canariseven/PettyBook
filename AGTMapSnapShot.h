#import "_AGTMapSnapShot.h"
#import <MapKit/MapKit.h>
@interface AGTMapSnapShot : _AGTMapSnapShot {}

@property (nonatomic, strong) UIImage *image;
+(NSArray *)observableKeyNames;
+(instancetype) mapSnapshotForLocation:(AGTLocation*) location;
-(void) stopObserving;
@end
