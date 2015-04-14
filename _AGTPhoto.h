// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPhoto.h instead.

@import CoreData;

extern const struct AGTPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} AGTPhotoAttributes;

extern const struct AGTPhotoRelationships {
	__unsafe_unretained NSString *annotation;
	__unsafe_unretained NSString *book;
} AGTPhotoRelationships;

@class AGTAnnotations;
@class AGTBook;

@interface AGTPhotoID : NSManagedObjectID {}
@end

@interface _AGTPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTAnnotations *annotation;

//- (BOOL)validateAnnotation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (AGTAnnotations*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(AGTAnnotations*)value;

- (AGTBook*)primitiveBook;
- (void)setPrimitiveBook:(AGTBook*)value;

@end
