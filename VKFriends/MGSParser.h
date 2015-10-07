//
//  MGSParser.h
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@protocol MGSParser <NSObject>

@property (strong, nonatomic) NSOperationQueue *queue;

- (NSOperation *)parseFromData:(NSData *)aData onComplete:(OnComplete)aOnComplete;

@end
