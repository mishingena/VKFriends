//
//  MGSServiceLayer.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSServiceLayer.h"
#import "MGSNetwork.h"
#import "MGSAuthorizationTransportLayer.h"
#import "MGSAuthorizationService.h"
#import "MGSAuthorizationParameters.h"

@interface MGSServiceLayer ()

@property (nonatomic, strong, readwrite) MGSAuthorizationService *authorizationLoginService;
@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *appID;

@end

@implementation MGSServiceLayer

- (instancetype)initWithServerURL:(NSString *)serverURL applicationID:(NSString *)appID {
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _appID = appID;
    }
    return self;
}

- (MGSAuthorizationService *)authorizationLoginService {
    if (!_authorizationLoginService) {
        MGSAuthorizationParameters *parameters = [[MGSAuthorizationParameters alloc] initWithApplicationID:self.appID scope:MGSVKScopeFriends redirectURl:MGSAuthorizationRedirectURLPath];
        
        MGSAuthorizationTransportLayer *transportLayer = [[MGSAuthorizationTransportLayer alloc] initWithServerURL:MGSAuthorizationServerURLPath path:MGSAuthorizationPath parameters:parameters];
        
        _authorizationLoginService = [[MGSAuthorizationService alloc] initWithTransportLayer:transportLayer];
    }
    return _authorizationLoginService;
}

@end
