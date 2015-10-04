//
//  MGSAuthorizationTransportLayer.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSAuthorizationParameters;

@interface MGSAuthorizationTransportLayer : NSObject

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       parameters:(MGSAuthorizationParameters *)parameters;

- (NSURLRequest *)request;

@end
