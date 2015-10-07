//
//  AppDelegate.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGSServiceLayer, MGSCacheLayer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, readonly) MGSServiceLayer *serviceLayer;
@property (nonatomic, strong, readonly) MGSCacheLayer *cacheLayer;

@property (strong, nonatomic) UIWindow *window;


@end

