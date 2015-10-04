//
//  MGSAuthorizationParamters.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSAuthorizationParameters.h"
#import "MGSNetwork.h"

@interface MGSAuthorizationParameters ()

@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *redirectURL;
@property (nonatomic) MGSVKScope scope;
@property (nonatomic, strong) NSDictionary *parametersDictionary;

@end

@implementation MGSAuthorizationParameters

- (instancetype)initWithApplicationID:(NSString *)appID
                                scope:(MGSVKScope)scope
                          redirectURl:(NSString *)redirectURL {
    self = [super init];
    if (self) {
        _appID = appID;
        _redirectURL = redirectURL;
        _scope = scope;
    }
    return self;
}

- (NSDictionary *)makeDictionary {
    NSString *scopeValues = [NSString new];
    
    //другие случаи пока не рассматриваю
    if (self.scope & MGSVKScopeFriends) {
        scopeValues = @"friends";
    }
    return @{
             @"client_id" : self.appID,
             @"scope": scopeValues,
             @"redirect_uri": self.redirectURL,
             @"display": @"touch",
             @"response_type": @"token"
             };
    
}

- (NSDictionary *)parametersDictionary {
    if (!_parametersDictionary) {
        _parametersDictionary = [self makeDictionary];
    }
    return _parametersDictionary;
}

- (NSString *)parametersString {
    return [MGSNetwork stringWithParametersFromDictionary:self.parametersDictionary];
}

@end
