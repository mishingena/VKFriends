//
//  MGSTransportLayer.h
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@protocol MGSParser;

NS_ASSUME_NONNULL_BEGIN

@interface MGSTransportLayer : NSObject

@property (nonatomic, strong) NSOperationQueue *queue;

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       httpMethod:(MGSHTTPMethod)httpMethod
                           parser:(id<MGSParser>)parser
                needAuthorization:(BOOL)needAuth
                  cacheEntityName:(NSString *)entityName;

- (void)setSortParameters:(NSString *)parameters;

- (NSOperation *)sendRequestWithParams:(nullable NSDictionary *)params onComplete:(OnComplete)aOnComplete;

@end

NS_ASSUME_NONNULL_END