#import "_AGTTags.h"
#define NAME_TAG_FAVOURITES @"Favorite"
@interface AGTTags : _AGTTags {}
+(NSArray *)observableKeyNames;
+(instancetype)tagWithTag:(NSString *)tag book:(AGTBook *)book context:(NSManagedObjectContext *)context;
+(void)searchTagFavourite:(NSManagedObjectContext *)context andInserBook:(AGTBook *)book actionDelete:(BOOL)delete;
-(NSComparisonResult)compare:(AGTTags *)other;
@end
