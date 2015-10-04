//
//  NSError+MGS.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger const MGSDefaultErrorCode;

@interface NSError (MGS)

+ (instancetype)mgs_errorWithCode:(NSInteger)code description:(NSString *)description;
+ (instancetype)mgs_errorWithDescription:(NSString *)description;

@end
