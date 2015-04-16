#import "_AGTTags.h"
#define NAME_TAG_FAVOURITES @"00FAVORITOS"
@interface AGTTags : _AGTTags {}
+(instancetype)tagWithTag:(NSString *)tag book:(AGTBook *)book context:(NSManagedObjectContext *)context;
+(void)searchTagFavourite:(NSManagedObjectContext *)context andInserBook:(AGTBook *)book actionDelete:(BOOL)delete;
@end
