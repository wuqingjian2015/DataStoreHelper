//
//  SSCoreDataHelper.h
//  OHCardToolApp
//
//  Created by caoli on 16/4/5.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import <coredata/coredata.h>
#import <Foundation/Foundation.h>

@interface SSCoreDataHelper : NSObject


@property (nonatomic, strong) NSManagedObjectModel  *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSURL *storeUrl;

+(SSCoreDataHelper*)defaultCoreDataHelper;

@end
