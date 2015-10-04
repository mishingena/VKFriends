//
//  MGSTransportLayer.h
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@class MGSParser;

@interface MGSTransportLayer : NSObject

@property (nonatomic, strong) NSOperationQueue *queue;

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       httpMethod:(MGSHTTPMethod)httpMethod
                           parser:(MGSParser *)parser;

- (NSOperation *)sendRequestWithParams:(nullable NSDictionary *)params onComplete:(OnComplete)aOnComplete;

@end
