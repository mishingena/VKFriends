//
//  MGSHTTPOperation.m
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSHTTPOperation.h"
#import "MGSTokenProvider.h"
#import "MGSCredentialsStorage.h"
#import "MGSAuthorizationCredentials.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface MGSHTTPOperation ()

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *path;
@property (nonatomic) MGSHTTPMethod httpMethod;
@property (nonatomic, copy) OnComplete onComplete;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic) BOOL needAuth;

@end

@implementation MGSHTTPOperation

- (instancetype)initWithServerURL:(NSString *)serverURL
                             path:(NSString *)path
                       parameters:(NSDictionary *)parameters
                       httpMethod:(MGSHTTPMethod)httpMethod
                needAuthorization:(BOOL)needAuth
                       onComplete:(OnComplete)onComplete {
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _path = path;
        _parameters = parameters;
        _onComplete = onComplete;
        _httpMethod = httpMethod;
        _needAuth = needAuth;
    }
    return self;
}

- (void)start {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.serverURL, self.path];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    if (self.needAuth) {
        NSMutableDictionary *params = [self.parameters mutableCopy];
        [params setValue:[MGSTokenProvider token] forKey:@"access_token"];
        [params setValue:[MGSCredentialsStorage loadCredentials].userID forKey:@"user_id"];
        self.parameters = [params copy];
    }
    
    [self sendRequestWithManager:manager];
}

- (void)sendRequestWithManager:(AFHTTPSessionManager *)manager {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.serverURL, self.path];
    
    __weak typeof (self) wSelf = self;
    if (self.httpMethod == MGSHTTPMethodGet) {
        [manager GET:urlString parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];

            __strong typeof (self) self = wSelf;
            if (self.onComplete) {
                self.onComplete(data, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            __strong typeof (self) self = wSelf;
            if (self.onComplete) {
                self.onComplete(nil, error);
            }
            NSLog(@"Failture : %@", error);
        }];
    }
    
    if (self.httpMethod == MGSHTTPMethodPost) {
        [manager POST:urlString parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            __strong typeof (self) self = wSelf;
            if (self.onComplete) {
                self.onComplete(responseObject, nil);
            }
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            __strong typeof (self) self = wSelf;
            if (self.onComplete) {
                self.onComplete(nil, error);
            }
            NSLog(@"Failture : %@", error);
        }];
    }
}

@end
