#import "AGTPhoto.h"
#import "Utils.h"
#import "services.h"
@interface AGTPhoto ()

// Private interface goes here.

@end

@implementation AGTPhoto
@synthesize imageURL = _imageURL;

#pragma mark - Properties
+(NSArray *)observableKeyNames{
    return @[AGTPhotoAttributes.imageData];
}
-(void)setImage:(UIImage *)image{
    // sincronizar con imageData
    self.imageData =  UIImageJPEGRepresentation(image, 0.9);
}
-(UIImage *)image{
    return  [UIImage imageWithData:self.imageData];
}

#pragma mark -Class Methods
+(instancetype) photoWithImageURL:(NSString *)imageURL
                          context:(NSManagedObjectContext *)context{
    // Pasamos la imagen a un data
//    UIImage *image = [AGTPhoto imageWithURL:imageURL];
//    NSData *dataImage = UIImageJPEGRepresentation(image, 0.8);
    AGTPhoto *photo = [self insertInManagedObjectContext:context];
//    photo.imageData = dataImage;
    
    NSManagedObjectContext * privateContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.persistentStoreCoordinator = context.persistentStoreCoordinator;
    [privateContext performBlock:^{
        NSURL *url = [NSURL URLWithString:imageURL];
        [AGTPhoto downLoadPhotoWithURL:url statusOperationWith:^(NSData *data) {
            photo.imageData = data;
        } failure:^(NSError *error) {
            photo.imageData = nil;
        }];
        
    }];
    
   
 
    
    return photo;
}

#pragma mark - Download images
+(void)downLoadPhotoWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data))success failure:(void (^)(NSError *error))failure{


    [services downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        success(data);
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");
        failure(error);
    }];

}

@end
