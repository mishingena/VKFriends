//
//  MGSSettingsViewController.m
//  VKFriends
//
//  Created by Gena on 07.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSSettingsViewController.h"
#import "MGSCacheLayer.h"
#import "UIViewController+MGS.h"

@interface MGSSettingsViewController ()

@property (nonatomic, weak) UIActivityIndicatorView *activityIndiactor;

@end

@implementation MGSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Настройки";
}

- (IBAction)clearCache:(UIButton *)sender {
    [self showActivityIndicator];
    __weak typeof (self) wSelf = self;
    [AppCacheLayer clean:^(BOOL contextDidSave, NSError * _Nonnull error) {
        __strong typeof (self) self = wSelf;
        [self hideActivityIndicator];
        [self showAlertControllerWithTitle:nil text:@"Кэш очищен"];
    }];
}

- (UIActivityIndicatorView *)activityIndiactor {
    if (!_activityIndiactor) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.hidden = YES;
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.center = self.tableView.center;
        [self.tableView addSubview:activityIndicator];
        _activityIndiactor = activityIndicator;
        
    }
    return _activityIndiactor;
}

- (void)showActivityIndicator {
    self.activityIndiactor.hidden = NO;
    [self.activityIndiactor startAnimating];
}

- (void)hideActivityIndicator {
    self.activityIndiactor.hidden = YES;
    [self.activityIndiactor stopAnimating];
}

@end
