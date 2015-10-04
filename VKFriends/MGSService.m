//
//  MGSService.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSService.h"
#import "MGSTransportLayer.h"

@interface MGSService ()

@property (nonatomic, strong) MGSTransportLayer *transportLayer;

@end

@implementation MGSService

- (instancetype)initWithTransportLayer:(MGSTransportLayer *)transportLayer {
    self = [super init];
    if (self) {
        _transportLayer = transportLayer;
    }
    return self;
}

- (NSOperation *)requestWithParameters:(NSDictionary *)aParameters onComplete:(OnComplete)aOnComplete {
    NSOperation *operation = [self.transportLayer sendRequestWithParams:aParameters onComplete:^(id __nullable result, NSError * __nullable error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (aOnComplete) {
                aOnComplete(result, error);
            }
            
            if (error) {
                if ([self.delegate respondsToSelector:@selector(service:didFailRequestWithError:)]) {
                    [self.delegate service:self didFailRequestWithError:error];
                }
                
            } else {
                if ([self.delegate respondsToSelector:@selector(service:didCompleteRequestWithData:)]) {
                    [self.delegate service:self didCompleteRequestWithData:result];
                }
            }
        }];
    }];
    
    return operation;
}

@end
