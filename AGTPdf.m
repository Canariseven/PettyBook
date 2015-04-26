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
-(void)downLoadPDF{
    NSURL *url = [NSURL URLWithString:self.pdfURL];
    [services downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        self.pdfData = data;
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");
        
    }];
    
}

@end
