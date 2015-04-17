// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTLocation.h instead.

#import <CoreData/CoreData.h>

extern const struct AGTLocationAttributes {
	 NSString *address;
	 NSString *latitude;
	 NSString *longitude;
} AGTLocationAttributes;

extern const struct AGTLocationRelationships {
	 NSString *annotations;
	 NSString *mapSnapShot;
} AGTLocationRelationships;

@class AGTAnnotations;
@class AGTMapSnapShot;

@interface AGTLocationID : NSManagedObjectID {}
@end

@interface _AGTLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTLocationID* objectID;

@property (nonatomic, retain) NSString* address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, retain) AGTMapSnapShot *mapSnapShot;

//- (BOOL)validateMapSnapShot:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTLocation (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(AGTAnnotations*)value_;
- (void)removeAnnotationsObject:(AGTAnnotations*)value_;

@end

@interface _AGTLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (AGTMapSnapShot*)primitiveMapSnapShot;
- (void)setPrimitiveMapSnapShot:(AGTMapSnapShot*)value;

@end
