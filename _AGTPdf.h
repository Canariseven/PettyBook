// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPdf.h instead.

#import <CoreData/CoreData.h>

extern const struct AGTPdfAttributes {
	 NSString *pdfData;
} AGTPdfAttributes;

extern const struct AGTPdfRelationships {
	 NSString *book;
} AGTPdfRelationships;

@class AGTBook;

@interface AGTPdfID : NSManagedObjectID {}
@end

@interface _AGTPdf : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTPdfID* objectID;

@property (nonatomic, retain) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) AGTBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (AGTBook*)primitiveBook;
- (void)setPrimitiveBook:(AGTBook*)value;

@end
