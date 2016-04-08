//
//  SSVisitorRecordCollection+archiver.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecordCollection.h"

static NSString *archiveKey = @"visitorRecordCollectionKey";
@interface SSVisitorRecordCollection (archiver)
-(void)saveToArchive;
-(void)loadFromArchive;
@end
