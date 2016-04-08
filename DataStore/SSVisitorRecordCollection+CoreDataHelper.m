//
//  SSVisitorRecordCollection+CoreDataHelper.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/5.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSCoreDataHelper.h"
#import "VisitorRecord+CoreDataProperties.h"
#import "SSVisitorRecordCollection+CoreDataHelper.h"

@implementation SSVisitorRecordCollection (CoreDataHelper)


-(instancetype)initWithAllRecord
{
    self = [super init];
    if (self) {
        [self getAllRecord];
    }
    return self;
}

-(void)addRecord:(SSVisitorRecord*)record
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
    VisitorRecord *newRecord = (VisitorRecord*) [NSEntityDescription insertNewObjectForEntityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    newRecord.record_id = record.recordId;
    newRecord.record_name = record.recordName;
    newRecord.created_time = record.createdTime;
    newRecord.modified_time = record.modifiedTime;
    newRecord.record_text = record.text;
    newRecord.pickedImageFile = record.pickedImageFile;
    
    NSError *err;
    if ([helper.managedObjectContext save:&err]) {
        NSLog(@"Add a record successfully");
    } else {
        NSLog(@"Error: %@, %@", err, [err userInfo]);
    }
    
}
-(void)removeRecord:(SSVisitorRecord*)record
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_name == %@", record.recordName];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *err;
    NSMutableArray *array = [[helper.managedObjectContext executeFetchRequest:request error:&err] mutableCopy];
    if (!array) {
        NSLog(@"Error %@,%@", err, [err userInfo]);
        NSLog(@"No item was removed.");
        return;
    } else {
        NSLog(@"Total %li items were fetched.", [array count]);
        for (VisitorRecord* record in array) {
            [helper.managedObjectContext deleteObject:record];
        }
        if([helper.managedObjectContext save:&err]){
            NSLog(@"All fetched items were removed successfully.");
        } else {
            NSLog(@"All fetched items were NOT removed successfully.");
        }
    }
}
-(void)modifiedRecord:(SSVisitorRecord*)record withText:(NSString*)atext
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_id == %@", record.recordId];
    [request setPredicate:predicate];
    
    NSError *err;
    NSMutableArray *result = [[helper.managedObjectContext executeFetchRequest:request error:&err] mutableCopy];
    if (!result) {
        NSLog(@"Error %@, %@", err, [err userInfo]);
        NSLog(@"Nothing was changed.");
        return ;
    } else {
        NSLog(@"Total %li items are fetched successfully.Returned the first match item.", [result count]);
        for (VisitorRecord *item in result) {
            item.record_text = atext;
            item.modified_time = [NSDate date];
        }
        
        if([helper.managedObjectContext save:&err]){
            NSLog(@"Records was updated successfully.");
        } else {
            NSLog(@"Error %@,%@", err, [err userInfo]);
        }
    }
}
-(SSVisitorRecord*)getRecordById:(NSUInteger)index
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rid==%lu", index];
    [request setPredicate:predicate];

    NSError *err;
    NSArray *result = [helper.managedObjectContext executeFetchRequest:request error:&err];
    if (!result) {
        NSLog(@"Error %@, %@", err, [err userInfo]);
        return nil;
    } else {
        NSLog(@"Total %li items are fetched successfully.Returned the first match item.", [result count]);
        return [[result objectAtIndex:0] toSSVisitorRecord];
    }
}

-(SSVisitorRecord*)getRecordByKeyName:(NSString*)key
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_id ==%@", key];
    [request setPredicate:predicate];
    
    NSError *err;
    NSArray *result = [helper.managedObjectContext executeFetchRequest:request error:&err];
    if (!result) {
        NSLog(@"Error %@, %@", err, [err userInfo]);
        return nil;
    } else {
        NSLog(@"Total %li items are fetched successfully.Returned the first match item.", [result count]);
        return [[result objectAtIndex:0] toSSVisitorRecord];
    }
}

-(void)getAllRecord
{
    SSCoreDataHelper *helper = [SSCoreDataHelper defaultCoreDataHelper];
   
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription* record = [NSEntityDescription entityForName:@"VisitorRecord" inManagedObjectContext:helper.managedObjectContext];
    [request setEntity:record];
    NSError *err;
    NSMutableArray *result = [[helper.managedObjectContext executeFetchRequest:request error:&err] mutableCopy];
    if (!result) {
        NSLog(@"Error : %@, %@", err, [err userInfo]);
    } else {
        NSLog(@"Total %li items are fetched successfully.", [result count]);
        [self.dictOfVisitorRecord removeAllObjects];
        for (VisitorRecord* item in result) {
            SSVisitorRecord *temp = [item toSSVisitorRecord];
            self.dictOfVisitorRecord[temp.recordId] = temp;
        }
    }
}

@end
