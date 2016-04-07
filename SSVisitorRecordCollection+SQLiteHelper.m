//
//  SSVisitorRecordCollection+SQLiteHelper.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//
#import <SQLite3.h>
#import "SSVisitorRecordCollection+SQLiteHelper.h"
#import "SSSQLiteHelper.h"

@implementation SSVisitorRecordCollection (SQLiteHelper)

-(instancetype)initWithSQLite
{
    self = [super init];
    if (self) {
        [self createTableForVisitorRecordIfNeeded];
    }
    return self;
}

-(void)createTableForVisitorRecordIfNeeded
{
        NSString *createTableQuery = @"CREATE TABLE IF NOT EXISTS VISITORRECORD (RECORD_ID text PRIMARY KEY, RECORD_NAME text, CREATED_TIME double, MODIFIED_TIME double, RECORD_TEXT text, PICKEDIMAGEFILE TEXT);";
    
    SSSQLiteHelper *helper = [[SSSQLiteHelper alloc] init];
    [helper open:[self database_path]];
    [helper execSql:createTableQuery];
    [helper close];
}

-(void)insertVisitorRecord:(SSVisitorRecord*)record
{
    NSString *insertSql = [NSString stringWithFormat:@"Insert into VISITORRECORD (RECORD_ID,RECORD_NAME,CREATED_TIME, MODIFIED_TIME, RECORD_TEXT, PICKEDIMAGEFILE) VALUES ('%@','%@',%f,%f,'%@','%@');", record.recordId, record.recordName, record.createdTime.timeIntervalSince1970, record.modifiedTime.timeIntervalSince1970, record.text, record.pickedImageFile];
    [self ExeSql:insertSql];
}

-(void) queryVisitorRecord:(SSVisitorRecord*)record
{

}
-(void)queryAllVisitorRecord
{
    NSString *selectSql = @"SELECT * FROM VISITORRECORD;";
    SSSQLiteHelper *helper = [[SSSQLiteHelper alloc] init];
    [helper open:[self database_path]];
    sqlite3_stmt *stmt;
    int result = 0;
    if(sqlite3_prepare_v2(helper.db, [selectSql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        while ((result = sqlite3_step(stmt)) ==  SQLITE_ROW) {
            NSString *record_id = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)];
            NSString *record_name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)];
            double created_time = sqlite3_column_double(stmt, 2);
            double modified_time = sqlite3_column_double(stmt, 3);
            NSString *record_text = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 4)];
            NSString *pickedImageFile = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 5)];
            SSVisitorRecord* record = [[SSVisitorRecord alloc] init];
            record.recordId = record_id;
            record.recordName = record_name;
            record.createdTime = [NSDate dateWithTimeIntervalSince1970:created_time];
            record.modifiedTime = [NSDate dateWithTimeIntervalSince1970:modified_time];
            record.text = record_text;
            record.pickedImageFile = pickedImageFile;
            
            self.dictOfVisitorRecord[record.recordId] = record;
        }
        
        if (result == SQLITE_ERROR) {
            NSString *errmsg = [NSString stringWithUTF8String:(char*)sqlite3_errmsg(helper.db)];
            NSLog(@"%@", errmsg);
        }
        
        sqlite3_finalize(stmt);
    }
    else
    {
        NSString *errmsg = [NSString stringWithUTF8String:(char*)sqlite3_errmsg(helper.db)];
        NSLog(@"DB operation failed with error code %@", errmsg);
    }
    
    [helper close];
}

-(void) ExeSql:(NSString*)sql
{
    SSSQLiteHelper *helper = [[SSSQLiteHelper alloc] init];
    [helper open:[self database_path]];
    [helper execSql:sql];
    [helper close];
}
-(void)saveToSQLiteDB
{
    
    for (SSVisitorRecord *record in self.dictOfVisitorRecord.allValues) {
        [self insertVisitorRecord:record];
    }
}

-(void)loadFromSQLiteDB
{
    [self.dictOfVisitorRecord removeAllObjects];
    [self queryAllVisitorRecord];
    [self ShowAll];
}

-(NSString*)database_path
{
    NSURL *pathUrl = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] URLByAppendingPathComponent:@"visitorRecordCollection.sqlite"];
    return [pathUrl path];
}
@end
