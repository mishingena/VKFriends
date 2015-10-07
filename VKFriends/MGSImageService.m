//
//  MGSImageService.m
//  VKFriends
//
//  Created by Gena on 07.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSImageService.h"
#import <AFNetworking/AFNetworking.h>
#import "MGSCacheLayer.h"
#import "NSError+MGS.h"

@interface MGSImageService ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic) BOOL canceled;

@end

@implementation MGSImageService

- (instancetype)init {
    self = [super init];
    if (self) {
        _canceled = NO;
        _sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.vkFriendApp.MGSImageService"];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_sessionConfiguration];
        _sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
    }
    return self;
}

- (void)stopAll {
    self.canceled = YES;
}

- (void)canLoad:(BOOL)enabled {
    self.canceled = !enabled;
}

- (void)requestImageWithURL:(NSString *)imageURl
                     entity:(id)entity
              entityKeyPath:(NSString *)keyPath
                 onComplete:(OnComplete)onComplete {
    if (!self.canceled) {
        if (imageURl) {
            __weak typeof (self) wSelf = self;
            [self.sessionManager GET:imageURl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                __strong typeof (self) self = wSelf;
                
                if (!self.canceled) {
                    NSData *imageData = UIImageJPEGRepresentation(responseObject, 1.0);
                    [AppCacheLayer updateEntity:entity withObject:imageData entityKeyPath:keyPath completion:^(BOOL contextDidSave, NSError * _Nonnull error) {
                        if (onComplete && !self.canceled) {
                            onComplete(responseObject, error);
                        }
                    }];
                    
                }
                
                } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                    if (onComplete && !self.canceled) {
                        onComplete(nil, error);
                    }
                    
                }];
            
        } else {
            NSError *error = [NSError mgs_errorWithDescription:@"Empty image url string"];
            if (onComplete && !self.canceled) {
                onComplete(nil, error);
            }
        }
    }
    
}

@end
