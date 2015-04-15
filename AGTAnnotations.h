#import "_AGTAnnotations.h"

@interface AGTAnnotations : _AGTAnnotations {}
+(instancetype) annotationWithText:(NSString *)text
                           context:(NSManagedObjectContext *)context;
@end
