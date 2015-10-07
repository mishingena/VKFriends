//
//  AppDelegate.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "AppDelegate.h"
#import "MGSServiceLayer.h"
#import "MGSNetwork.h"

//#import <MagicalRecord/MagicalRecord.h>
#import "MGSCacheLayer.h"
#import <AFNetworking/AFNetworking.h>
//#import "VKFriend.h"
//#import <CoreData/CoreData.h>

NSString * const ApplicationID = @"5089959";

@interface AppDelegate ()

@property (nonatomic, strong, readwrite) MGSServiceLayer *serviceLayer;
@property (nonatomic, strong, readwrite) MGSCacheLayer *cacheLayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.serviceLayer = [[MGSServiceLayer alloc] initWithServerURL:MGSServerURLPath applicationID:ApplicationID];

//    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model"];
    
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    self.cacheLayer = [[MGSCacheLayer alloc] initWithDefaultContext];
    
    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
//    }];
//    
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
//    VKFriend *friend = [VKFriend MR_createEntity];
//    [self.cacheLayer.context MR_saveToPersistentStoreAndWait];
//    
//    [self.cacheLayer.context MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
//        
//    }];
    
    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        VKFriend *localFriend = [friend MR_inContext:localContext];
//        localFriend.firstName = @"John";
//        localFriend.lastName = @"Appleseed";
//    }];
    
//    VKFriend *friend = [VKFriend MR_createEntityInContext:self.cacheLayer.context];
//    VKFriend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"VKFriend" inManagedObjectContext:self.cacheLayer.context];
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        VKFriend *localFriend = [friend MR_inContext:self.cacheLayer.context];
//        localFriend.firstName = @"John";
//        localFriend.lastName = @"Appleseed";
//    }];
    
//    NSArray *friends = [VKFriend MR_findAllInContext:self.cacheLayer.context];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
