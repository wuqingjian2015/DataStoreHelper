//
//  SSVisitorRecord+serializer.m
//  OHCardToolApp
//
//  Created by caoli on 16/3/31.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecord+serializer.h"

@implementation SSVisitorRecord (serializer)

#pragma operation on file using NSCoding
-(instancetype) initWithFile:(NSString *)storedFile
{
    
    self = [super init];
    if (self) {
        self = [self unarchiveRecordFromFile:storedFile];
    }
    return self;
}

#pragma mark implementation
-(SSVisitorRecord*)unarchiveRecordFromFile:(NSString*)aFile
{
    SSVisitorRecord *record = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmp = NSTemporaryDirectory();
    NSString *testpath = [tmp stringByAppendingPathComponent:@"test"];
    NSString *file = [testpath stringByAppendingPathComponent:aFile];
    
    if ([fileManager fileExistsAtPath:file] == NO) {
        NSLog(@"Not exist file %@", file);
    }
    else {
        NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:file];
        record = [self unarchiveRecordFromData:data];
    }
    return record;
}

-(void)saveToFile:(NSString *)storedFile
{
    NSLog(@"saveToFile");
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (NO == [fileManager fileExistsAtPath:storedFile]) {
        [fileManager createFileAtPath:storedFile contents:[self archiveRecord] attributes:nil];
    }
    else
    {
        [[self archiveRecord] writeToFile:storedFile atomically:YES];
    }
}

#pragma archive/unarchive objects working with NSData
-(SSVisitorRecord*)unarchiveRecordFromData:(NSData*)data
{
    //NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:file];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    SSVisitorRecord *record = [unarchiver decodeObjectForKey:@"VisitorRecord"];
    [unarchiver finishDecoding];
    return record;
}
-(NSData*)archiveRecord
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"VisitorRecord"];
    [archiver finishEncoding];
    return data;
}

#pragma conform to NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"init with coder.");
    self = [super init];
    if (self) {
        self.recordName = [aDecoder decodeObjectForKey:krecordName];
        self.createdTime   = [aDecoder decodeObjectForKey:kcreatedTime];
        self.modifiedTime = [aDecoder decodeObjectForKey:kmodifiedTime];
        self.text = [aDecoder decodeObjectForKey:ktext];
        self.pickedImageFile = [aDecoder decodeObjectForKey:kpickedImageFile];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"encode with coder");
    [aCoder encodeObject:self.recordName forKey:krecordName];
    [aCoder encodeObject:self.createdTime forKey:kcreatedTime];
    [aCoder encodeObject:self.modifiedTime forKey:kmodifiedTime];
    [aCoder encodeObject:self.text forKey:ktext];
    [aCoder encodeObject:self.pickedImageFile forKey:kpickedImageFile];
}

@end
