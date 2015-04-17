// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTAnnotations.h instead.

#import <CoreData/CoreData.h>

extern const struct AGTAnnotationsAttributes {
	 NSString *creationDate;
	 NSString *modificationDate;
	 NSString *text;
} AGTAnnotationsAttributes;

extern const struct AGTAnnotationsRelationships {
	 NSString *book;
	 NSString *location;
	 NSString *photo;
} AGTAnnotationsRelationships;

@class AGTBook;
@class AGTLocation;
@class AGTPhoto;

@interface AGTAnnotationsID : NSManagedObjectID {}
@end

@interface _AGTAnnotations : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTAnnotationsID* objectID;

@property (nonatomic, retain) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) AGTBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) AGTLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) AGTPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTAnnotations (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (AGTBook*)primitiveBook;
- (void)setPrimitiveBook:(AGTBook*)value;

- (AGTLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGTLocation*)value;

- (AGTPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(AGTPhoto*)value;

@end
