//
//  MGSEntityFabric.h
//  VKFriends
//
//  Created by Gena on 06.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSEntityFabric : NSObject

+ (NSString *)entityNameForFriendsClass;

@end

@interface MGSEntityFabric (SortParameters)

+ (NSString *)entitySortParametersForFriendsClass;

@end
