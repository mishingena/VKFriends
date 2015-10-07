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
#import "MGSService.h"
#import "MGSTransportLayer.h"
#import "MGSParserFabric.h"
#import "MGSEntityFabric.h"

@interface MGSServiceLayer ()

@property (nonatomic, strong, readwrite) MGSAuthorizationService *authorizationLoginService;
@property (nonatomic, strong, readwrite) MGSAuthorizationService *authorizationLogoutService;

@property (nonatomic, strong, readwrite) MGSAuthorizationService *authorizationService;
@property (nonatomic, strong, readwrite) MGSService *friendsListService;

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

- (MGSAuthorizationService *)authorizationService {
    if (!_authorizationService) {
        MGSAuthorizationParameters *loginParameters = [[MGSAuthorizationParameters alloc] initWithApplicationID:self.appID scope:MGSVKScopeFriends redirectURl:MGSAuthorizationRedirectURLPath];
        
        MGSAuthorizationTransportLayer *loginTransportLayer = [[MGSAuthorizationTransportLayer alloc] initWithServerURL:MGSAuthorizationServerURLPath path:MGSAuthorizationLoginMethodPath parameters:loginParameters];
        
        MGSAuthorizationTransportLayer *logoutTransportLayer = [[MGSAuthorizationTransportLayer alloc] initWithServerURL:self.serverURL path:MGSAuthorizationLogoutMethodPath parameters:nil];
        
        _authorizationService = [[MGSAuthorizationService alloc] initWithLoginTransportLayer:loginTransportLayer logoutTransportLayer:logoutTransportLayer];
    }
    return _authorizationService;
}

//- (MGSAuthorizationService *)authorizationLoginService {
//    if (!_authorizationLoginService) {
//        MGSAuthorizationParameters *parameters = [[MGSAuthorizationParameters alloc] initWithApplicationID:self.appID scope:MGSVKScopeFriends redirectURl:MGSAuthorizationRedirectURLPath];
//        
//        MGSAuthorizationTransportLayer *transportLayer = [[MGSAuthorizationTransportLayer alloc] initWithServerURL:MGSAuthorizationServerURLPath path:MGSAuthorizationLoginMethodPath parameters:parameters];
//        
//        _authorizationLoginService = [[MGSAuthorizationService alloc] initWithTransportLayer:transportLayer];
//    }
//    return _authorizationLoginService;
//}
//
//- (MGSAuthorizationService *)authorizationLogoutService {
//    if (!_authorizationLogoutService) {
//        
//        MGSAuthorizationTransportLayer *transportLayer = [[MGSAuthorizationTransportLayer alloc] initWithServerURL:self.serverURL path:MGSAuthorizationLogoutMethodPath parameters:nil];
//        
//        _authorizationLogoutService = [[MGSAuthorizationService alloc] initWithTransportLayer:transportLayer];
//    }
//    return _authorizationLogoutService;
//}

- (MGSService *)friendsListService {
    if (!_friendsListService) {
        MGSTransportLayer *transportLayer = [[MGSTransportLayer alloc] initWithServerURL:self.serverURL
                                                                                    path:MGSFriendsMethodPath
                                                                              httpMethod:MGSHTTPMethodGet
                                                                                  parser:[MGSParserFabric parserForFriends]
                                                                       needAuthorization:YES
                                                                         cacheEntityName:[MGSEntityFabric entityNameForFriendsClass]];
        [transportLayer setSortParameters:[MGSEntityFabric entitySortParametersForFriendsClass]];
        _friendsListService = [[MGSService alloc] initWithTransportLayer:transportLayer];
    }
    return _friendsListService;
}

@end
