//
//  MGSTokenProvider.m
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSTokenProvider.h"
#import "MGSAuthorizationCredentials.h"
#import "MGSCredentialsStorage.h"

@implementation MGSTokenProvider

+ (NSString *)token {
    MGSAuthorizationCredentials *authCredentials = [MGSCredentialsStorage loadCredentials];
    return authCredentials.token;
}

+ (BOOL)isTokenValid {
    NSDate *currentDate = [NSDate date];
    MGSAuthorizationCredentials *authCredentials = [MGSCredentialsStorage loadCredentials];
    //if currentDate later than tokenExpireDate
    if ([currentDate compare:authCredentials.tokenExpireDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}

@end
