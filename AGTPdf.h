#import "_AGTPdf.h"

@interface AGTPdf : _AGTPdf {}
@property (nonatomic, strong) NSString *pdfURL;
+(instancetype) pdfWithURL:(NSString *)pdfURL
                   context:(NSManagedObjectContext *)context;
@end
