//
//  ViewController.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSLoginViewController.h"
#import "MGSServiceLayer.h"
#import "MGSAuthorizationService.h"
#import "MGSTokenProvider.h"
#import "NSError+MGS.h"

//static float const NavigationBarHeight = 20.0;

@interface MGSLoginViewController () <MGSAuthorizationServiceDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndiactor;

@end

@implementation MGSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppServiceLayer.authorizationService.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    __weak typeof (self) wSelf = self;
    [MGSNetwork isReachable:^(BOOL reachable) {
        __strong typeof (self) self = wSelf;
        if (reachable) {
            [self tryLogin];
        } else {
            NSError *error = [NSError mgs_errorWithDescription:@"Отсутствует подключение к интенету"];
            [self showAlertControolerWithError:error];
        }
    }];
}

- (void)tryLogin {
    __weak typeof (self) wSelf = self;
    [AppServiceLayer.authorizationService authorizeInWebView:self.webView withCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        __strong typeof (self) self = wSelf;
        if (error) {
            [self showAlertControolerWithError:error];
        } else {
            [self performSegueWithIdentifier:@"showMain" sender:nil];
        }
    }];
}

- (UIActivityIndicatorView *)activityIndiactor {
    if (!_activityIndiactor) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.hidden = YES;
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.center = self.view.center;
        [self.view addSubview:activityIndicator];
        _activityIndiactor = activityIndicator;
        
    }
    return _activityIndiactor;
}

- (void)showAlertControolerWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof (self) wSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"Обновить" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof (self) self = wSelf;
        [self tryLogin];
    }]];
    
    if ([MGSTokenProvider token]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Исп. оффлайн" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof (self) self = wSelf;
            [self performSegueWithIdentifier:@"showMain" sender:nil];
        }]];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showActivityIndicator {
    self.activityIndiactor.hidden = NO;
    [self.activityIndiactor startAnimating];
}

- (void)hideActivityIndicator {
    self.activityIndiactor.hidden = YES;
    [self.activityIndiactor stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideActivityIndicator];
}

@end
