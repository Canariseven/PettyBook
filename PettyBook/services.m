//
//  services.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 1/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "services.h"

@implementation services
//+(id)sharedServices{
//    static services *sharedMyServices = nil;
//    @synchronized(self){
//        if (sharedMyServices == nil) {
//            sharedMyServices = [[self alloc]init];
//        }
//    }
//    return sharedMyServices;
//}

+(void) downloadDataWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data ,NSURLResponse * response, NSError *error))success failure:(void (^)(NSURLResponse *response, NSError *error))failure{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept"    : @"application/json"};
    // Inicialización de la sesión
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    // Tarea de gestión de datos
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode == 200) {
            if (!error) {
                if (data != nil) {
                    success(data,response,error);
                }else{
                    NSLog(@"Fallo Data");
                    failure(response,error);
                }
            }else{
                failure(response,error);
            }
        }else{
            [self showAlertWithError:error];
            failure(response,error);
        }
        
    }];
    [dataTask resume];
}

+(void)showAlertWithError:(NSError *)error{
    if (error.code == -1002) {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"No Internet"
//                                                        message:@"Por favor revise su conexión de internet" delegate:self cancelButtonTitle:@"OK!"
//                                              otherButtonTitles: nil];
//        [alert show];
    }
}

@end
