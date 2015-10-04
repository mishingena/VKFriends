//
//  MGSCredentialsStorage.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSAuthorizationCredentials;

@interface MGSCredentialsStorage : NSObject

+ (void)saveCredentials:(MGSAuthorizationCredentials *)credentials;
+ (MGSAuthorizationCredentials *)loadCredentials;
+ (void)resetCredentials;

@end
