//
//  SSVisitorRecordCollection+archiver.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/3.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//
#import "SSVisitorRecordCollection.h"
#import "SSVisitorRecordCollection+archiver.h"


@implementation SSVisitorRecordCollection (archiver)



-(void)saveToArchive
{
    NSLog(@"saveToArchive");
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.dictOfVisitorRecord forKey:archiveKey];
    [archiver finishEncoding];
    
    [data writeToURL:[self archivePath] atomically:YES];
}


-(void)loadFromArchive
{
    NSLog(@"LoadFromArchive");
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfURL:[self archivePath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.dictOfVisitorRecord = [unarchiver decodeObjectForKey:archiveKey];
    [unarchiver finishDecoding];
}


@end
