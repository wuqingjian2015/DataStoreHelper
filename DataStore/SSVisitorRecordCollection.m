//
//  SSVisitorRecordCollection.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecordCollection.h"


@implementation SSVisitorRecordCollection

-(instancetype) init
{
    self = [super init];
    if (self) {
        _dictOfVisitorRecord = nil;
        _archivePath = nil;
    }
    return self;
}

-(NSMutableDictionary*)dictOfVisitorRecord
{
    if (!_dictOfVisitorRecord) {
        _dictOfVisitorRecord = [[NSMutableDictionary alloc] init];
    }
    return _dictOfVisitorRecord;
}


-(NSURL*)archivePath
{
    if (!_archivePath) {
        _archivePath = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] URLByAppendingPathComponent:visitorRecordCollectionPath];
    }
    return _archivePath;
}

-(void)ShowAll
{
    for (SSVisitorRecord* record in self.dictOfVisitorRecord.allValues) {
        NSLog(@"Record: %@", record);
    }
}

@end
