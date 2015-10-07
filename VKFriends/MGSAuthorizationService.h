//
//  MGSAuthtorizationService.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

@class UIWebView, MGSAuthorizationTransportLayer;
@class MGSAuthorizationService;

@protocol MGSAuthorizationServiceDelegate <NSObject>

@optional

- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;

- (void)authorizationServiceDidStart:(MGSAuthorizationService *)service;
- (void)authorizationServiceDidComplete:(MGSAuthorizationService *)service;
- (void)authorizationServiceDidCancel:(MGSAuthorizationService *)service;
- (void)authorizationService:(MGSAuthorizationService *)service didFailWithError:(NSError *)error;

@end

@interface MGSAuthorizationService : NSObject

@property (nonatomic, weak) id<MGSAuthorizationServiceDelegate> delegate;

- (instancetype)initWithLoginTransportLayer:(MGSAuthorizationTransportLayer *)loginTransportLayer
                       logoutTransportLayer:(MGSAuthorizationTransportLayer *)logoutTransportLayer;

- (void)authorizeInWebView:(UIWebView *)webView withCompletion:(OnComplete)block;
- (void)logoutInWebView:(UIWebView *)webView withCompletion:(OnComplete)block;
- (void)cancel;

@end
