// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTTags.h instead.

@import CoreData;

extern const struct AGTTagsAttributes {
	__unsafe_unretained NSString *tags;
} AGTTagsAttributes;

extern const struct AGTTagsRelationships {
	__unsafe_unretained NSString *books;
} AGTTagsRelationships;

@class AGTBook;

@interface AGTTagsID : NSManagedObjectID {}
@end

@interface _AGTTags : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTTagsID* objectID;

@property (nonatomic, strong) NSString* tags;

//- (BOOL)validateTags:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _AGTTags (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(AGTBook*)value_;
- (void)removeBooksObject:(AGTBook*)value_;

@end

@interface _AGTTags (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTags;
- (void)setPrimitiveTags:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
