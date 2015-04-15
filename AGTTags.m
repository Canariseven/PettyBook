#import "AGTTags.h"

@interface AGTTags ()

// Private interface goes here.

@end

@implementation AGTTags

+(instancetype)tagWithTag:(NSString *)tag context:(NSManagedObjectContext *)context{
    AGTTags *t = [self insertInManagedObjectContext:context];
    t.tags = tag;
    return t;
}



@end
