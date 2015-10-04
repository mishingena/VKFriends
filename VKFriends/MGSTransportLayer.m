//
//  MGSTransportLayer.m
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSTransportLayer.h"
#import "MGSGroupOperation.h"

@interface MGSTransportLayer ()

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic) MGSHTTPMethod httpMethod;
@property (nonatomic, strong) MGSParser *parser;

@end

@implementation MGSTransportLayer

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       httpMethod:(MGSHTTPMethod)httpMethod
                           parser:(MGSParser *)parser {
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _path = path;
        _httpMethod = httpMethod;
        _parser = parser;
    }
    return self;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (NSOperation *)sendRequestWithParams:(nullable NSDictionary *)params onComplete:(OnComplete)onComplete {
    
    NSOperation *httpOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    NSOperation *parseOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    [parseOperation addDependency:httpOperation];
    NSArray *operations = @[httpOperation, parseOperation];
    
    MGSGroupOperation *groupOperation = [[MGSGroupOperation alloc] initWithOperations:operations queue:self.queue];
    [self.queue addOperation:groupOperation];
    
    return groupOperation;
}

@end
