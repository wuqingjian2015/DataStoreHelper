//
//  SSVisitorRecordCollection.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSVisitorRecord+serializer.h"


static NSString *visitorRecordCollectionPath = @"visitorRecord.collection";
@interface SSVisitorRecordCollection : NSObject //<NSCoding>



@property (strong, nonatomic) NSMutableDictionary *dictOfVisitorRecord;
@property (nonatomic, strong) NSURL *archivePath;



-(instancetype) init;


-(void)ShowAll; 

@end

#import "SSVisitorRecordCollection+CoreDataHelper.h"