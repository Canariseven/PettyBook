//
//  Utils.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 4/4/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSURL *)urlOfCacheWithNameFile:(NSString *)name{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *urlAbsolute = [urls lastObject];
    urlAbsolute = [urlAbsolute URLByAppendingPathComponent:name];
    return urlAbsolute;
    
}

+(BOOL)saveOnCacheWithData:(NSData *)data andName:(NSString *)name{
    
    NSURL *urlCache = [self urlOfCacheWithNameFile:name];
    BOOL rc = [data writeToURL:urlCache atomically:NO];
    if (rc == NO) {
        NSLog(@"Fallo al cargar las imagenes");
        return NO;
    }else{
        return YES;
    }
}

+(NSData *)dataOfCacheDirectoryWithNameFile:(NSString *)name{
    NSURL * urlCache = [self urlOfCacheWithNameFile:name];
    NSData * data = [NSData dataWithContentsOfURL:urlCache];
    return data;
}
@end
