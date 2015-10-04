//
//  MGSAuthtorizationService.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSAuthorizationService.h"
#import "MGSAuthorizationTransportLayer.h"
#import "NSError+MGS.h"
#import "NSString+MGS.h"
#import "MGSAuthorizationCredentials.h"
#import "MGSCredentialsStorage.h"

@import UIKit;

@interface MGSAuthorizationService () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MGSAuthorizationTransportLayer *tranportLayer;
@property (nonatomic, copy) OnComplete completionBlock;

@end

@implementation MGSAuthorizationService

- (instancetype)initWithTransportLayer:(MGSAuthorizationTransportLayer *)transportLayer {
    self = [super init];
    if (self) {
        _tranportLayer = transportLayer;
    }
    return self;
}

- (void)authorizeInWebView:(UIWebView *)webView withCompletion:(OnComplete)block {
    self.webView = webView;
    self.completionBlock = [block copy];
    webView.delegate = self;
    [webView loadRequest:[self.tranportLayer request]];
    
    if ([self.delegate respondsToSelector:@selector(authorizationServiceDidStart:)]) {
        [self.delegate authorizationServiceDidStart:self];
    }
}

- (void)cancel {
    [self.webView stopLoading];
    
    if (self.completionBlock) {
        NSError *error = [NSError mgs_errorWithDescription:@"Authorization cancelled"];
        self.completionBlock(nil, error);
    }
    
    if ([self.delegate respondsToSelector:@selector(authorizationServiceDidCancel:)]) {
        [self.delegate authorizationServiceDidCancel:self];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    
    // Пользователь нажал Отмена в веб-форме
    if ([[url absoluteString] isEqualToString:MGSUserDeniedRequestError]) {
        NSError *error = [NSError mgs_errorWithDescription:@"User denied your request"];
        [self sendError:error];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *webViewRequestString = [[[webView request] URL] absoluteString];
    
    // Если есть токен сохраняем его
    if ([webViewRequestString rangeOfString:@"access_token"].location != NSNotFound) {
        
        
        NSString *accessToken = [NSString stringBetweenString:@"access_token="
                                                    andString:@"&"
                                                  innerString:webViewRequestString];
        
        // Получаем id пользователя, пригодится нам позднее
        NSArray *userArray = [webViewRequestString componentsSeparatedByString:@"&user_id="];
        NSString *userID = [userArray lastObject];
        
        NSString *expiresIn = [NSString stringBetweenString:@"expires_in"
                                                  andString:@"&"
                                                innerString:webViewRequestString];
        double tokenExpires = expiresIn.doubleValue;
        
        if (!userID) {
            NSError *error = [NSError mgs_errorWithDescription:@"No user id"];
            [self sendError:error];
        }
        
        if (!accessToken) {
            NSError *error = [NSError mgs_errorWithDescription:@"No access token"];
            [self sendError:error];
        }
        
        NSDate *expireDate = [NSDate dateWithTimeIntervalSinceNow:tokenExpires];
        
        MGSAuthorizationCredentials *authCredentials = [MGSAuthorizationCredentials new];
        authCredentials.token = accessToken;
        authCredentials.userID = userID;
        authCredentials.tokenExpireDate = expireDate;
        
        [MGSCredentialsStorage saveCredentials:authCredentials];
        
        if (self.completionBlock) {
            self.completionBlock(nil, nil);
        }
        
        if ([self.delegate respondsToSelector:@selector(authorizationServiceDidComplete:)]) {
            [self.delegate authorizationServiceDidComplete:self];
        }
        
    } else if ([webViewRequestString rangeOfString:@"error"].location != NSNotFound) {
        NSError *error = [NSError mgs_errorWithCode:12 description:@"Unknown error"];
        [self sendError:error];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self sendError:error];
}

- (void)sendError:(NSError *)error {
    if (self.completionBlock) {
        self.completionBlock(nil, error);
    }
    
    if ([self.delegate respondsToSelector:@selector(authorizationService:didFailWithError:)]) {
        [self.delegate authorizationService:self didFailWithError:error];
    }
}

@end
