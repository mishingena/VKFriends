//
//  MGSNetwork.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSNetwork.h"

@implementation MGSNetwork

@end

@implementation MGSNetwork (Path)

NSString * const MGSAuthorizationServerURLPath = @"https://oauth.vk.com";
NSString * const MGSServerURLPath = @"http://api.vk.com";
NSString * const MGSAuthorizationPath = @"authorize";
NSString * const MGSAuthorizationRedirectURLPath = @"http://oauth.vk.com/blank.html";

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