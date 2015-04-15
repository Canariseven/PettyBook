#import "_AGTBook.h"

@interface AGTBook : _AGTBook {}
+(instancetype) bookWithDict:(NSDictionary *)dict
                     context:(NSManagedObjectContext *)context;
@end
