//
//  NSError+MGS.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "NSError+MGS.h"
#import "MGSNetwork.h"

static NSInteger const MGSDefaultErrorCode = 123;

@implementation NSError (MGS)

+ (instancetype)mgs_errorWithCode:(NSInteger)code description:(NSString *)description {
    return [NSError errorWithDomain:MGSDomainError
                               code:code
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

+ (instancetype)mgs_errorWithDescription:(NSString *)description {
    return [NSError errorWithDomain:MGSDomainError
                               code:MGSDefaultErrorCode
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
