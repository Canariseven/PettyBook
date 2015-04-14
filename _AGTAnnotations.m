// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTAnnotations.m instead.

#import "_AGTAnnotations.h"

const struct AGTAnnotationsAttributes AGTAnnotationsAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.text = @"text",
};

const struct AGTAnnotationsRelationships AGTAnnotationsRelationships = {
	.book = @"book",
	.location = @"location",
	.photo = @"photo",
};

@implementation AGTAnnotationsID
@end

@implementation _AGTAnnotations

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotations" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotations";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotations" inManagedObjectContext:moc_];
}

- (AGTAnnotationsID*)objectID {
	return (AGTAnnotationsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic text;

@dynamic book;

@dynamic location;

@dynamic photo;

@end

