//
//  MGSParserFabric.h
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSMappingFabric;
@protocol MGSParser;

@interface MGSParserFabric : NSObject

+ (id<MGSParser>)parserForFriends;

@end
