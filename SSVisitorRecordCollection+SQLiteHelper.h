//
//  SSVisitorRecordCollection+SQLiteHelper.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecordCollection.h"

@interface SSVisitorRecordCollection (SQLiteHelper)

-(instancetype)initWithSQLite;
-(void)saveToSQLiteDB;
-(void)loadFromSQLiteDB;
-(void)insertVisitorRecord:(SSVisitorRecord*)record;
@end
