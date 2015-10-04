//
//  MGSAuthorizationParamters.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, MGSVKScope) {
    MGSVKScopeFriends = 1 << 0,
    MGSVKScopePhotos = 1 << 1,
    MGSVKScopeWall = 1 << 2,
};

@interface MGSAuthorizationParameters : NSObject

- (instancetype)initWithApplicationID:(NSString *)appID
                                scope:(MGSVKScope)scope
                          redirectURl:(NSString *)redirectURL;

- (NSDictionary *)parametersDictionary;
- (NSString *)parametersString;

@end
