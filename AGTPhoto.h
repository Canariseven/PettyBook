#import "_AGTPhoto.h"
@import UIKit;
@interface AGTPhoto : _AGTPhoto {}
@property (nonatomic,strong) UIImage *image;
@property (nonatomic, copy) NSString *imageURL;
// Custom logic goes here.
+(NSArray *)observableKeyNames;
+(instancetype) photoWithImageURL:(NSString *)imageURL
                          context:(NSManagedObjectContext *)context;
@end
