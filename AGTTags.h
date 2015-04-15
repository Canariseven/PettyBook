#import "_AGTTags.h"

@interface AGTTags : _AGTTags {}
+(instancetype)tagWithTag:(NSString *)tag book:(AGTBook *)book context:(NSManagedObjectContext *)context;
@end
