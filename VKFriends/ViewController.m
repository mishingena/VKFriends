//
//  ViewController.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "ViewController.h"
#import "MGSServiceLayer.h"
#import "MGSAuthorizationService.h"

@interface ViewController () <MGSAuthorizationServiceDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.bounds;
    frame.origin.y = 20.0;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    AppServiceLayer.authorizationLoginService.delegate = self;
    [AppServiceLayer.authorizationLoginService authorizeInWebView:self.webView withCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        if (!error) {
            
        }
    }];
//    [UIApplication sharedApplication]
}

- (void)authorizationService:(MGSAuthorizationService *)service didFailWithError:(NSError *)error {
    
}

- (void)authorizationServiceDidComplete:(MGSAuthorizationService *)service {
    
}

- (void)authorizationServiceDidCancel:(MGSAuthorizationService *)service {
    
}

- (void)authorizationServiceDidStart:(MGSAuthorizationService *)service {
    
}

@end
