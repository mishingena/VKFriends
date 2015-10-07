//
//  MGSServiceLayer.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSAuthorizationService, MGSService;

@interface MGSServiceLayer : NSObject

@property (nonatomic, strong, readonly) MGSAuthorizationService *authorizationService;
@property (nonatomic, strong, readonly) MGSService *friendsListService;

- (instancetype)initWithServerURL:(NSString *)serverURL applicationID:(NSString *)appID;

@end
