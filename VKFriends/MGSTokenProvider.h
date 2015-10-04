//
//  MGSTokenProvider.h
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSTokenProvider : NSObject

+ (NSString *)token;
+ (BOOL)isTokenValid;

@end
