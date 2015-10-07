//
//  MGSFriendsViewController.m
//  VKFriends
//
//  Created by Gena on 06.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSFriendsViewController.h"
#import "MGSServiceLayer.h"
#import "MGSAuthorizationService.h"
#import "MGSService.h"
#import "VKFriend.h"
#import "UIViewController+MGS.h"
#import "MGSCacheLayer.h"
#import "MGSImageService.h"
#import "MGSFriendCell.h"

@interface MGSFriendsViewController ()

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndiactor;

@end

@implementation MGSFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Друзья";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выйти"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(logoutPressed:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Настройки"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(settingsPressed:)];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self
                            action:@selector(loadData)
                  forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cacheCleared) name:MGSNotificationCacheCleared object:nil];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.tableView reloadData];
}

- (void)cacheCleared {
    self.friends = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData {
    NSDictionary *params = @{
                             @"fields": @"photo_100",
                             };
    [self showActivityIndicator];
    __weak typeof (self) wSelf = self;
    [AppServiceLayer.friendsListService requestWithParameters:params onComplete:^(id  _Nullable result, NSError * _Nullable error) {
        __strong typeof (self) self = wSelf;
        self.friends = result;
    
        [self hideActivityIndicator];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        
        if (error) {
            [self showAlertControllerWithTitle:nil text:error.localizedDescription];
        }
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

- (void)logoutPressed:(id)sender {
    UIWebView *webView = [UIWebView new];
    
    __weak typeof (self) wSelf = self;
    [AppServiceLayer.authorizationService logoutInWebView:webView withCompletion:^(id  _Nullable result, NSError * _Nullable error) {
        __strong typeof (self) self = wSelf;
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)settingsPressed:(id)sender {
    [self performSegueWithIdentifier:@"showSettings" sender:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSFriendCell *friendCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    VKFriend *friend = self.friends[indexPath.row];
    
    friendCell.friendTextLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
    friendCell.friendImage.layer.cornerRadius = friendCell.friendImage.frame.size.width / 2;
    friendCell.friendImage.layer.masksToBounds = YES;
    
    if (friend.imageSmall) {
        UIImage *image = [UIImage imageWithData:friend.imageSmall];
        friendCell.friendImage.image = image;
    } else {
        friendCell.friendImage.image = [UIImage imageNamed:@"vk_no_image"];
        [AppServiceLayer.imageService requestImageWithURL:friend.photoURLString
                                                   entity:friend
                                            entityKeyPath:@"imageSmall"
                                               onComplete:^(id  _Nullable result, NSError * _Nullable error) {
                                                   [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                               }];
    }
    
    return friendCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
