//
//  SSSQLiteHelper.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/Foundation.h>

@interface SSSQLiteHelper : NSObject
@property (strong, nonatomic) NSString *databasePath;
@property (assign, nonatomic) sqlite3 *db;

-(void)open:(NSString*)dbPath;
-(void)close;
-(void)execSql:(NSString*)sql;

@end
