//
//  MGSNetwork.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSNetwork.h"
#import <AFNetworking/AFNetworking.h>

@implementation MGSNetwork

+ (void)isReachable:(void (^)(BOOL))completion {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            if (completion) {
                completion(NO);
            }
        } else {
            if (completion) {
                completion(YES);
            }
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end

@implementation MGSNetwork (Path)

NSString * const MGSAuthorizationServerURLPath = @"https://oauth.vk.com";
NSString * const MGSServerURLPath = @"https://api.vk.com";
NSString * const MGSAuthorizationRedirectURLPath = @"http://oauth.vk.com/blank.html";
NSString * const MGSAuthorizationLoginMethodPath = @"authorize";
NSString * const MGSAuthorizationLogoutMethodPath = @"oauth/logout";
NSString * const MGSFriendsMethodPath = @"method/friends.get";

@end


@implementation MGSNetwork (Paramters)

+ (NSString *)stringWithParametersFromDictionary:(NSDictionary *)dict {
    NSMutableArray *paramsArray = [NSMutableArray new];
    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        NSString *value = dict[key];
        NSString *parameter = [NSString stringWithFormat:@"%@=%@", key, value];
        [paramsArray addObject:parameter];
    }
    return [[paramsArray valueForKey:@"description"] componentsJoinedByString:@"&"];
}

@end

@implementation MGSNetwork (Erorrs)

NSString * const MGSUserDeniedRequestError = @"http://api.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request";
NSString * const MGSDomainError = @"com.vk.ErrorDomain";

@end

@implementation MGSNetwork (Cache)

+ (void)clearCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end