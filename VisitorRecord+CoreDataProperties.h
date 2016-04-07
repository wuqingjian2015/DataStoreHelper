//
//  VisitorRecord+CoreDataProperties.h
//  
//
//  Created by caoli on 16/4/4.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VisitorRecord.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisitorRecord (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *record_id;
@property (nullable, nonatomic, retain) NSString *record_name;
@property (nullable, nonatomic, retain) NSDate *created_time;
@property (nullable, nonatomic, retain) NSDate *modified_time;
@property (nullable, nonatomic, retain) NSString *record_text;
@property (nullable, nonatomic, retain) NSString *pickedImageFile;

-(SSVisitorRecord*)toSSVisitorRecord;
@end

NS_ASSUME_NONNULL_END
