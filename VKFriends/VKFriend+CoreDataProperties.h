//
//  VKFriend+CoreDataProperties.h
//  VKFriends
//
//  Created by Gena on 07.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "VKFriend.h"

NS_ASSUME_NONNULL_BEGIN

@interface VKFriend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *photoURLString;
@property (nonatomic) int64_t id;
@property (nullable, nonatomic, retain) NSData *imageSmall;

@end

NS_ASSUME_NONNULL_END
