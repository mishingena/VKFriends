//
//  MGSService.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@class MGSTransportLayer, MGSService;

@protocol MGSServiceDelegate <NSObject>

- (void)service:(MGSService *)aService didFailRequestWithError:(NSError *)error;
- (void)service:(MGSService *)aService didCompleteRequestWithData:(id)data;

@end

@interface MGSService : NSObject

@property (weak, nonatomic) id<MGSServiceDelegate> delegate;
@property (nonatomic, strong) NSOperationQueue *queue;

- (instancetype)initWithTransportLayer:(MGSTransportLayer *)transportLayer;

- (NSOperation * _Nonnull)requestWithParameters:(nullable NSDictionary *)aParameters onComplete:(nullable OnComplete)aOnComplete;

@end
