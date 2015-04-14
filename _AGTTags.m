// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTTags.m instead.

#import "_AGTTags.h"

const struct AGTTagsAttributes AGTTagsAttributes = {
	.tags = @"tags",
};

const struct AGTTagsRelationships AGTTagsRelationships = {
	.books = @"books",
};

@implementation AGTTagsID
@end

@implementation _AGTTags

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tags" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tags";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tags" inManagedObjectContext:moc_];
}

- (AGTTagsID*)objectID {
	return (AGTTagsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic tags;

@dynamic books;

- (NSMutableSet*)booksSet {
	[self willAccessValueForKey:@"books"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"books"];

	[self didAccessValueForKey:@"books"];
	return result;
}

@end

