#import "AGTPdf.h"
#import "services.h"
@interface AGTPdf ()

@end

@implementation AGTPdf

@synthesize pdfURL = _imageURL;
#pragma mark -Class Methods
+(instancetype) pdfWithPdfURL:(NSString *)pdfURL
                          context:(NSManagedObjectContext *)context{
    // Pasamos la imagen a un data
    NSData *data = [AGTPdf pdfWithURL:pdfURL];
    AGTPdf *pdf = [self insertInManagedObjectContext:context];

    return pdf;
}


+(NSData *)pdfWithURL:(NSString *)pdfURL{
    NSURL *url = [NSURL URLWithString:pdfURL];
    NSData * data = [self downLoadPhotoWithURL:url];
    return data;
}


#pragma mark - Download images
+(NSData *)downLoadPhotoWithURL:(NSURL *)url{
    //    services * download = [services sharedServices];
    __block NSData *dat;
    [services downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        dat = data;
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar el pdf Data");
        dat = nil;
    }];
    return dat;
}

@end
