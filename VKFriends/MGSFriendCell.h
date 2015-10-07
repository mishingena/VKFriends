//
//  MGSFriendCell.h
//  VKFriends
//
//  Created by Gena on 07.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGSFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendImage;
@property (weak, nonatomic) IBOutlet UILabel *friendTextLabel;


@end

NS_ASSUME_NONNULL_END
