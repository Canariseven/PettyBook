// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTMapSnapShot.h instead.

@import CoreData;

extern const struct AGTMapSnapShotAttributes {
	__unsafe_unretained NSString *snapShotData;
} AGTMapSnapShotAttributes;

extern const struct AGTMapSnapShotRelationships {
	__unsafe_unretained NSString *location;
} AGTMapSnapShotRelationships;

@class AGTLocation;

@interface AGTMapSnapShotID : NSManagedObjectID {}
@end

@interface _AGTMapSnapShot : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTMapSnapShotID* objectID;

@property (nonatomic, strong) NSData* snapShotData;

//- (BOOL)validateSnapShotData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTMapSnapShot (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveSnapShotData;
- (void)setPrimitiveSnapShotData:(NSData*)value;

- (AGTLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGTLocation*)value;

@end
