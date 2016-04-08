//
//  SSCoreDataHelper.m
//  OHCardToolApp
//
//  Created by caoli on 16/4/5.
//  Copyright © 2016年 QingjianWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCoreDataHelper.h"

@interface SSCoreDataHelper()
@property (nonatomic, strong) NSString  *sqliteFilePath;
@end
@implementation SSCoreDataHelper


+(SSCoreDataHelper*)defaultCoreDataHelper
{
    static SSCoreDataHelper* _defaultCoreDataHelper = nil;
    if (!_defaultCoreDataHelper) {
        _defaultCoreDataHelper = [[SSCoreDataHelper alloc] init];
    }
    return _defaultCoreDataHelper;
}

-(instancetype) initWithSQLiteFileName:(NSString*)filePath
{
    self = [super init];
    if (self) {
        _sqliteFilePath = filePath;
    }
    return self;
}

-(instancetype) init
{
    return [self initWithSQLiteFileName:@"coredatadefault.sqlite"];
}

-(NSManagedObjectModel*)managedObjectModel
{
    if (!_managedObjectModel) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        if (!_managedObjectModel) {
            NSLog(@"ManagedObjectModel was NULL");
        }
        else {
            NSLog(@"ManagedObjectModel was created successfully.");
        }
    }
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSError *error;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeUrl] options:nil error:&error]) {
            NSLog(@"error : %@, %@", error, [error userInfo]);
        }
        else {
            NSLog(@"PersistentStoreCoordinator was created successfully.");
        }
    }
    
    return _persistentStoreCoordinator;
}

-(NSManagedObjectContext*)managedObjectContext
{
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator) {
            
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            if (!_managedObjectContext) {
                NSLog(@"ManagedObjectContext was NULL.");
            }
            else {
                [_managedObjectContext setPersistentStoreCoordinator:coordinator];
            }
        }
        else
        {
            NSLog(@"ManagedObjectContext failed to create due to an empty coordinator.");
        }
    }
    return _managedObjectContext;
}

-(NSURL*)storeUrl
{
    if (!_storeUrl) {
        NSError *err;
        NSURL *url;
        if (!(url = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err])) {
            NSLog(@"Error: %@, %@", err, [err userInfo]);
        } else {
            _storeUrl = [url URLByAppendingPathComponent:self.sqliteFilePath];
        }
    }
    return _storeUrl;
}

@end
