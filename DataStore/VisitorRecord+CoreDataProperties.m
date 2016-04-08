//
//  VisitorRecord+CoreDataProperties.m
//  
//
//  Created by caoli on 16/4/4.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VisitorRecord+CoreDataProperties.h"

@implementation VisitorRecord (CoreDataProperties)

@dynamic record_id;
@dynamic record_name;
@dynamic created_time;
@dynamic modified_time;
@dynamic record_text;
@dynamic pickedImageFile;

-(SSVisitorRecord*)toSSVisitorRecord
{
    SSVisitorRecord* temp = [[SSVisitorRecord alloc] init];
    temp.recordId = self.record_id;
    temp.recordName = self.record_name;
    temp.createdTime = self.created_time;
    temp.modifiedTime = self.modified_time;
    temp.text = self.record_text;
    temp.pickedImageFile = self.pickedImageFile;
    return temp;
}
@end
