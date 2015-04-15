#import "AGTAnnotations.h"

@interface AGTAnnotations ()
+(NSArray *)observableKeyNames;
// Private interface goes here.

@end

@implementation AGTAnnotations
+(NSArray *)observableKeyNames{
    return @[AGTAnnotationsAttributes.creationDate,AGTAnnotationsAttributes.text,@"photo.imageData",@"location.latitude",@"location.longitude",@"location.address"];
}
+(instancetype) annotationWithText:(NSString *)text
                           context:(NSManagedObjectContext *)context{
    AGTAnnotations * an = [self insertInManagedObjectContext:context];
    an.creationDate = [NSDate date];
    an.modificationDate = [NSDate date];
    return an;
}

#pragma mark - LifeCycle NSManagedObject
-(void)awakeFromInsert{
    [super awakeFromInsert];
    [self setupKVO];
}
-(void)awakeFromFetch{
    [super awakeFromFetch];
    [self setupKVO];
}
-(void)willTurnIntoFault{
    [super willTurnIntoFault];
    [self tearDownKVO];
}

#pragma mark - KVO
-(void) setupKVO{
    
    NSArray * keys = [AGTAnnotations observableKeyNames];
    for (NSString *key in keys) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }

}

-(void) tearDownKVO{
    NSArray * keys = [AGTAnnotations observableKeyNames];
    for (NSString *key in keys) {
        [self removeObserver:self
                  forKeyPath:key];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    self.modificationDate = [NSDate date];
    
}

@end
