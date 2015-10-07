//
//  MGSAuthorizationTransportLayer.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSAuthorizationTransportLayer.h"
#import "MGSAuthorizationParameters.h"

@interface MGSAuthorizationTransportLayer ()

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) MGSAuthorizationParameters *parameters;
@property (nonatomic, strong, readwrite) NSURLRequest *urlRequest;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation MGSAuthorizationTransportLayer

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       parameters:(MGSAuthorizationParameters *)parameters {
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _path = path;
        _parameters = parameters;
    }
    return self;
}

- (NSURLRequest *)request {
    if (!_request) {
        _request = [self createRequest];
    }
    return _request;
}

- (NSURLRequest *)createRequest {
    NSString *parametersString = [self.parameters parametersString];
    NSString *requestString = [NSString stringWithFormat:@"%@/%@", self.serverURL, self.path];
    if (parametersString) {
        requestString = [NSString stringWithFormat:@"%@?%@", requestString, parametersString];
    }
    
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    return request;
}

@end