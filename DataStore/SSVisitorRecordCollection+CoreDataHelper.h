//
//  SSVisitorRecordCollection+CoreDataHelper.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/5.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecordCollection.h"

@interface SSVisitorRecordCollection (CoreDataHelper)

-(void)addRecord:(SSVisitorRecord*)record;
-(void)removeRecord:(SSVisitorRecord*)record;
-(void)modifiedRecord:(SSVisitorRecord*)record withText:(NSString*)atext;
-(SSVisitorRecord*)getRecordById:(NSUInteger)index;
-(SSVisitorRecord*)getRecordByKeyName:(NSString*)key;
-(void)getAllRecord;

-(instancetype)initWithAllRecord;
@end
