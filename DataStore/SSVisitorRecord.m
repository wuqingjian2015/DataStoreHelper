//
//  SSVisitorRecord.m
//  OHCardToolApp
//
//  Created by caoli on 16/3/29.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecord.h"



@implementation SSVisitorRecord

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.createdTime = [NSDate date];
        self.modifiedTime = [NSDate date];
    }
    return self;
}

-(NSString*) recordId
{
    if (!_recordId) {
        _recordId = [NSString stringWithFormat:@"%@_%f", _recordName, [[self createdTime] timeIntervalSince1970]];
    }
    return _recordId; 
}

-(NSDate*) createdTime
{
    if (!_createdTime) {
        _createdTime = [NSDate date];
    }
    return _createdTime;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"record id :%@ \r\n record name :%@ \r\n record_text:%@\r\n created time: %@\r\n modified time:%@\r\n picked image file:%@\r\n", self.recordId, self.recordName, self.text, self.createdTime, self.modifiedTime, self.pickedImageFile];
}

@end
