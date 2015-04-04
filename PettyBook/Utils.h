//
//  Utils.h
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//


@import Foundation;
@interface Utils : NSObject
+(NSURL *)urlOfCacheWithNameFile:(NSString *)name;
+(BOOL)saveOnCacheWithData:(NSData *)data andName:(NSString *)name;
+(NSData *)dataOfCacheDirectoryWithNameFile:(NSString *)name;
@end