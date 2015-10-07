//
//  MGSEasyMappingParser.h
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSParser.h"

@class EKObjectMapping, EKManagedObjectMapping;

typedef NS_OPTIONS(NSUInteger, MGSEasyMappingParserObjectType) {
    MGSEasyMappingParserObjectTypePlain = 0,
    MGSEasyMappingParserObjectTypeArray = 1 << 0,
};

NS_ASSUME_NONNULL_BEGIN

@interface MGSEasyMappingParser : NSObject <MGSParser>

@property (strong, nonatomic) NSOperationQueue *queue;

- (instancetype)initWithKeyPath:(nullable NSString *)keyPath
                        mapping:(EKManagedObjectMapping *)aMapping
                     objectType:(MGSEasyMappingParserObjectType)objectType
                        context:(NSManagedObjectContext *)context;
;

@end

NS_ASSUME_NONNULL_END
