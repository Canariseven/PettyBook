#import "_AGTPdf.h"

@interface AGTPdf : _AGTPdf {}
@property (nonatomic, strong) NSString *pdfURL;
+(NSArray *)observableKeyNames;
+(instancetype) pdfWithURL:(NSString *)pdfURL
                   context:(NSManagedObjectContext *)context;
-(void)downLoadPDF;
@end
