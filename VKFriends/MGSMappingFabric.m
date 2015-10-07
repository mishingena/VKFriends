//
//  MGSMappingFabric.m
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSMappingFabric.h"
#import <EasyMapping/EasyMapping.h>

@implementation MGSMappingFabric

+ (EKManagedObjectMapping *)mappingForFriends {
    return [EKManagedObjectMapping mappingForEntityName:@"VKFriend" withBlock:^(EKManagedObjectMapping *mapping) {
        [mapping mapPropertiesFromDictionary:@{
                                               @"first_name": @"firstName",
                                               @"last_name": @"lastName",
                                               @"photo_50": @"photoURLString",
                                               @"user_id": @"id"
                                               }];
        [mapping setPrimaryKey:@"id"];
    }];
}

@end
