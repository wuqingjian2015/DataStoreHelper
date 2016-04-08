//
//  SSVisitorRecord+serializer.h
//  OHCardToolApp
//
//  实现NSCoding 以支持归档／解档的操作
//
//  Created by caoli on 16/3/31.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import "SSVisitorRecord.h"

@interface SSVisitorRecord (serializer) <NSCoding>

#pragma conform to NSCoding
-(instancetype) initWithCoder:(NSCoder*)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

#pragma operation on file using NSCoding
-(instancetype) initWithFile:(NSString*)storedFile;
-(void)saveToFile:(NSString*)storedFile;
@end
