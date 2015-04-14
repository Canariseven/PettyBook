// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPhoto.m instead.

#import "_AGTPhoto.h"

const struct AGTPhotoAttributes AGTPhotoAttributes = {
	.imageData = @"imageData",
};

const struct AGTPhotoRelationships AGTPhotoRelationships = {
	.annotation = @"annotation",
	.book = @"book",
};

@implementation AGTPhotoID
@end

@implementation _AGTPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (AGTPhotoID*)objectID {
	return (AGTPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic annotation;

@dynamic book;

@end

