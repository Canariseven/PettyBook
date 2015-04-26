// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPdf.m instead.

#import "_AGTPdf.h"

const struct AGTPdfAttributes AGTPdfAttributes = {
	.pdfData = @"pdfData",
};

const struct AGTPdfRelationships AGTPdfRelationships = {
	.book = @"book",
};

@implementation AGTPdfID
@end

@implementation _AGTPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (AGTPdfID*)objectID {
	return (AGTPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic book;

@end

