//
//  MGSAuthorizationCredentials.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSAuthorizationCredentials : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSDate *tokenExpireDate;

@end
