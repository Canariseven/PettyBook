#import "_AGTBook.h"

@interface AGTBook : _AGTBook {}
@property (nonatomic) BOOL isFavourite;
+(instancetype) bookWithDict:(NSDictionary *)dict
                     context:(NSManagedObjectContext *)context;
@end
