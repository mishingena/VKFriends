//
//  MGSHTTPOperation.h
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@interface MGSHTTPOperation : NSOperation

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       parameters:(NSDictionary *)parameters
                       httpMethod:(MGSHTTPMethod)httpMethod
                needAuthorization:(BOOL)needAuth
                       onComplete:(OnComplete)onComplete;

@end
