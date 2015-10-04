//
//  MGSServiceLayer.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSAuthorizationService;

@interface MGSServiceLayer : NSObject

@property (nonatomic, strong, readonly) MGSAuthorizationService *authorizationLoginService;

- (instancetype)initWithServerURL:(NSString *)serverURL applicationID:(NSString *)appID;

@end
