//
//  MGSCredentialsStorage.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSCredentialsStorage.h"
#import "MGSAuthorizationCredentials.h"

static NSString * const MGSAuthorizationCredentialsKey = @"MGSAuthorizationCredentialsKey";
static NSString * const MGSVKAccessTokenKey = @"MGSVKAccessTokenKey";
static NSString * const MGSVKUserIDKey = @"MGSVKUserIDKey";
static NSString * const MGSVKTokenExpireDateKey = @"MGSVKTokenExpireDateKey";

@implementation MGSCredentialsStorage

/**
 имитирую сохранение данных пользователя в некоторое хранилище
 userDefaults для таких случаев лучше не использовать
 вместо него лучше сохранять куда то типа sskeychain
 */

+ (void)saveCredentials:(MGSAuthorizationCredentials *)credentials {
    [[NSUserDefaults standardUserDefaults] setObject:credentials.token forKey:MGSVKAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:credentials.userID forKey:MGSVKUserIDKey];
    [[NSUserDefaults standardUserDefaults] setObject:credentials.tokenExpireDate forKey:MGSVKTokenExpireDateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (MGSAuthorizationCredentials *)loadCredentials {
    MGSAuthorizationCredentials *authCredentials = [MGSAuthorizationCredentials new];
    authCredentials.token = [[NSUserDefaults standardUserDefaults] objectForKey:MGSVKAccessTokenKey];
    authCredentials.userID = [[NSUserDefaults standardUserDefaults] objectForKey:MGSVKUserIDKey];
    authCredentials.tokenExpireDate = [[NSUserDefaults standardUserDefaults] objectForKey:MGSVKTokenExpireDateKey];
    return authCredentials;
}

+ (void)resetCredentials {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MGSVKAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MGSVKUserIDKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MGSVKTokenExpireDateKey];
}

@end
