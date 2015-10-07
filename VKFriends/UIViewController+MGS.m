//
//  UIViewController+MGS.m
//  VKFriends
//
//  Created by Gena on 06.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "UIViewController+MGS.h"

@implementation UIViewController (AlertController)

- (void)showAlertControllerWithTitle:(NSString *)title text:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
