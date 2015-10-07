//
//  MGSTransportLayer.m
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSTransportLayer.h"
#import "MGSGroupOperation.h"
#import "MGSHTTPOperation.h"
#import "MGSParser.h"
#import "NSError+MGS.h"
#import "MGSCacheLayer.h"

@interface MGSTransportLayer ()

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic) MGSHTTPMethod httpMethod;
@property (nonatomic, strong) id<MGSParser> parser;
@property (nonatomic) BOOL needAuth;
@property (nonatomic, strong) NSString *cacheEntityName;
@property (nonatomic, strong) NSString *sortParams;

@end

@implementation MGSTransportLayer

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       httpMethod:(MGSHTTPMethod)httpMethod
                           parser:(id<MGSParser>)parser
                needAuthorization:(BOOL)needAuth
                  cacheEntityName:(NSString *)entityName {
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _path = path;
        _httpMethod = httpMethod;
        _parser = parser;
        _needAuth = needAuth;
        _cacheEntityName = entityName;
    }
    return self;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)setSortParameters:(NSString *)parameters {
    self.sortParams = parameters;
}

- (void)parseData:(id)aData onComplete:(OnComplete)onComplete {
    [self.parser parseFromData:aData
                    onComplete:^(id  __nullable parsedResult, NSError * __nullable error) {
                        [self saveResult:parsedResult onComplete:onComplete];
                    }];
}

- (void)saveResult:(id _Nullable)result onComplete:(OnComplete)onComplete {
    [AppCacheLayer save:^(BOOL contextDidSave, NSError *error) {
        [self fetchFromCache:onComplete];
    }];
}

- (void)fetchFromCache:(OnComplete)onComplete {
    [AppCacheLayer fetchAllEntityForName:self.cacheEntityName sortParameterts:self.sortParams withCompletion:^(id result) {
        if (onComplete) {
            onComplete(result, nil);
        }
    }];
}

- (NSOperation *)httpOperationWithParams:(nullable NSDictionary *)params onComplete:(OnComplete)onComplete {
    return [[MGSHTTPOperation alloc] initWithServerURL:self.serverURL
                                                  path:self.path
                                            parameters:params
                                            httpMethod:self.httpMethod
                                     needAuthorization:self.needAuth
                                            onComplete:^(id  _Nullable result, NSError * _Nullable error) {

                                                [self parseData:result onComplete:onComplete];
                                            }];
}

- (NSOperation *)sendRequestWithParams:(nullable NSDictionary *)params onComplete:(OnComplete)onComplete {
    
    __block NSOperation *httpOperation;
    
    //проверяем есть ли подключение к интернету
    __weak typeof (self) wSelf = self;
    [MGSNetwork isReachable:^(BOOL reachable) {
        __strong typeof (self) self = wSelf;
        
        if (reachable) {
            httpOperation = [self httpOperationWithParams:params onComplete:onComplete];
            [self.queue addOperation:httpOperation];

        } else {
            NSError *error = [NSError mgs_errorWithDescription:@"No internet connection"];
            if (self.cacheEntityName) {
                [AppCacheLayer fetchAllEntityForName:self.cacheEntityName sortParameterts:self.sortParams withCompletion:^(id result) {
                    if (onComplete) {
                        onComplete(result, error);
                    }
                }];
            }
        }
    }];
    
    return httpOperation;
}

@end
