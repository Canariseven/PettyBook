//
//  services.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 1/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import Foundation;
@import UIKit;

@interface services : NSObject

+(void) downloadDataWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data ,NSURLResponse * response, NSError *error))success failure:(void (^)(NSURLResponse *response, NSError *error))failure;

@end
