#import "AGTPdf.h"
#import "services.h"
@interface AGTPdf ()

@end

@implementation AGTPdf

@synthesize pdfURL = _imageURL;

#pragma mark -Class Methods
+(NSArray *)observableKeyNames{
    return @[AGTPdfAttributes.pdfData];
}
-(NSData *)pdfData{
    
    __block NSData *dataPDF;
    NSURL *url = [NSURL URLWithString:self.pdfURL];
    
    [AGTPdf downLoadPDFWithURL:url statusOperationWith:^(NSData *data) {
        dataPDF = data;
    } failure:^(NSError *error) {
        dataPDF = nil;
    }];

    return dataPDF;
    
}

#pragma mark - Download images
+(instancetype) pdfWithURL:(NSString *)pdfURL
                          context:(NSManagedObjectContext *)context{
    // Pasamos la imagen a un data
    AGTPdf *pdf = [self insertInManagedObjectContext:context];
    
    pdf.pdfURL = pdfURL;
    pdf.pdfData = nil;
    return pdf;
}


#pragma mark - Download images
+(void)downLoadPDFWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data))success failure:(void (^)(NSError *error))failure{
    
    [services downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        success(data);
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");
        failure(error);
    }];
    
}

@end
