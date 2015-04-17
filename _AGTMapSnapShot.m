// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTMapSnapShot.m instead.

#import "_AGTMapSnapShot.h"

const struct AGTMapSnapShotAttributes AGTMapSnapShotAttributes = {
	.snapShotData = @"snapShotData",
};

const struct AGTMapSnapShotRelationships AGTMapSnapShotRelationships = {
	.location = @"location",
};

@implementation AGTMapSnapShotID
@end

@implementation _AGTMapSnapShot

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MapSnapShot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MapSnapShot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MapSnapShot" inManagedObjectContext:moc_];
}

- (AGTMapSnapShotID*)objectID {
	return (AGTMapSnapShotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic snapShotData;

@dynamic location;

@end

