#import "_AGTPdf.h"

@interface AGTPdf : _AGTPdf {}
@property (nonatomic, copy) NSString *pdfURL;
+(instancetype) pdfWithPdfURL:(NSString *)pdfURL
                        context:(NSManagedObjectContext *)context;
@end
