//
//  SSSQLiteHelper.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSSQLiteHelper.h"


@interface SSSQLiteHelper(){
  
}
@end
@implementation SSSQLiteHelper

@synthesize databasePath = _databasePath;
@synthesize db = db;


-(NSString*)databasePath
{
    if (!_databasePath) {
        _databasePath = [[[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] URLByAppendingPathComponent:@"db.sqlite"] path];
    }
    return _databasePath;
}

-(void)setDatabasePath:(NSString *)databasePath
{
    _databasePath = databasePath;
}


-(void)open:(NSString*)dbPath
{
    if (sqlite3_open([self.databasePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"Failed to open db at %@", self.databasePath);
    }
    else {
        NSLog(@"Opened db successfully at %@", self.databasePath);
    }
}

-(void)close
{
    if (sqlite3_close(db) != SQLITE_OK) {
        NSLog(@"Failed to close db at %@", self.databasePath);
    }
    else{
        NSLog(@"Closed db successfully at %@", self.databasePath);
    }
}

//适合用来执行无返回行的sql
-(void)execSql:(NSString*)sql
{
    char *err;
    if (db && sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        [self close];
        NSLog(@"DB operation failure.");
    }
    else {
        NSLog(@"Insert successfully a row into table");
    }
}

@end
