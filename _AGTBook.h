// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTBook.h instead.

#import <CoreData/CoreData.h>

extern const struct AGTBookAttributes {
	 NSString *authors;
	 NSString *title;
} AGTBookAttributes;

extern const struct AGTBookRelationships {
	 NSString *annotations;
	 NSString *pdf;
	 NSString *photo;
	 NSString *tags;
} AGTBookRelationships;

@class AGTAnnotations;
@class AGTPdf;
@class AGTPhoto;
@class AGTTags;

@interface AGTBookID : NSManagedObjectID {}
@end

@interface _AGTBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTBookID* objectID;

@property (nonatomic, retain) NSString* authors;

//- (BOOL)validateAuthors:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, retain) AGTPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) AGTPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _AGTBook (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(AGTAnnotations*)value_;
- (void)removeAnnotationsObject:(AGTAnnotations*)value_;

@end

@interface _AGTBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(AGTTags*)value_;
- (void)removeTagsObject:(AGTTags*)value_;

@end

@interface _AGTBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (AGTPdf*)primitivePdf;
- (void)setPrimitivePdf:(AGTPdf*)value;

- (AGTPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(AGTPhoto*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
