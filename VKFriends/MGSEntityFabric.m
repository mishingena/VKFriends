//
//  MGSEntityFabric.m
//  VKFriends
//
//  Created by Gena on 06.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSEntityFabric.h"

@implementation MGSEntityFabric

+ (NSString *)entityNameForFriendsClass {
    return @"VKFriend";
}

@end

@implementation MGSEntityFabric (SortParameters)

+ (NSString *)entitySortParametersForFriendsClass {
    return @"lastName,firstName";
}

@end
