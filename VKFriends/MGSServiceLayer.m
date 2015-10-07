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
#import "MGSImageService.h"

@interface MGSServiceLayer ()

@property (nonatomic, strong, readwrite) MGSAuthorizationService *authorizationService;
@property (nonatomic, strong, readwrite) MGSService *friendsListService;
@property (nonatomic, strong, readwrite) MGSImageService *imageService;

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

- (MGSImageService *)imageService {
    if (!_imageService) {
        _imageService = [[MGSImageService alloc] init];
    }
    return _imageService;
}

@end
