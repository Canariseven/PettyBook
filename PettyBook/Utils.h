//
//  Utils.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+(NSURL *)urlOfCacheWithNameFile:(NSString *)name;
+(id)saveOnCacheWithURL:(NSURL *)url data:(NSData *)data andName:(NSString *)name;
+(NSData *)dataOfCacheDirectoryWithNameFile:(NSString *)name;
@end
