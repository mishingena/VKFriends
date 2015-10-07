//
//  MGSParserFabric.m
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSParserFabric.h"
#import "MGSEasyMappingParser.h"
#import "MGSMappingFabric.h"
#import "MGSCacheLayer.h"


@implementation MGSParserFabric

+ (id<MGSParser>)parserForFriends {
    return [[MGSEasyMappingParser alloc] initWithKeyPath:@"response"
                                                 mapping:[MGSMappingFabric mappingForFriends]
                                              objectType:MGSEasyMappingParserObjectTypeArray
                                                 context:AppCacheLayer.context];
}

@end
