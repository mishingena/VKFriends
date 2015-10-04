//
//  MGSGroupOperation.m
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSGroupOperation.h"

@interface MGSGroupOperation ()

@property (nonatomic, strong) NSArray *operations;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (assign) BOOL isCancelled;

@end

@implementation MGSGroupOperation

- (instancetype)initWithOperations:(NSArray *)operations queue:(NSOperationQueue *)queue {
    self = [super init];
    if (self) {
        _operations = operations;
        _queue = queue;
    }
    return self;
}

- (void)main {
    
    if (!self.isCancelled) {
        for (NSOperation *operation in self.operations) {
            [self.queue addOperation:operation];
        }
    }
}

- (void)cancel {
    self.isCancelled = YES;
    
    for (NSOperation *operation in self.operations) {
        [operation cancel];
    }
}

@end
