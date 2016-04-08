//
//  SSVisitorRecord.h
//  OHCardToolApp
//
//  This class SSVisitorRecord introduce the properties to record.
//
//  Created by caoli on 16/3/29.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define krecordName @"krecordName"
#define kcreatedTime @"kcreatedTime"
#define kmodifiedTime @"kmodifiedTime"
#define ktext          @"text"
#define kpickedImageFile @"kpickedImageFile"

@interface SSVisitorRecord : NSObject 

@property (strong, nonatomic) NSString *recordId;
@property (strong, nonatomic) NSString *recordName;
@property (strong, nonatomic) NSDate *createdTime;
@property (strong, nonatomic) NSDate *modifiedTime;
@property (strong, nonatomic) NSString *text; //The recorded text content.
@property (strong, nonatomic) NSString *pickedImageFile; //The picked image file recorded together


-(instancetype) init;
@end
