//
//  AppDelegate.h
//  MingDeEnglishSchool
//
//  Created by 刘宇航 on 16/4/5.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) UITabBarController *tabBar;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

