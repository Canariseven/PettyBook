#import "_AGTBook.h"
#define SAVE_LAST_BOOK @"save_last_book"
@interface AGTBook : _AGTBook {}
@property (nonatomic) BOOL isFavourite;
+(instancetype) bookWithDict:(NSDictionary *)dict
                     context:(NSManagedObjectContext *)context;
@end
