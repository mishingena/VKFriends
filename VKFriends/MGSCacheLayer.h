//
//  MGSCacheLayer.h
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MGSNotificationCacheCleared;

@interface MGSCacheLayer : NSObject

- (instancetype)initWithDefaultContext;

- (NSManagedObjectContext *)context;

- (void)clean:(void(^)(BOOL contextDidSave, NSError *error))completion;
- (void)save:(void(^)(BOOL contextDidSave, NSError *error))completion;
- (void)fetchAllEntityForName:(NSString *)entityName withCompletion:(void(^)(id __nullable result))completion;
- (void)fetchAllEntityForName:(NSString *)entityName sortParameterts:(NSString * __nonnull)sortParameterts withCompletion:(void(^)(id __nullable result))completion;

- (void)updateEntity:(id)entity
          withObject:(id)object
       entityKeyPath:(NSString *)keyPath
          completion:(void(^)(BOOL contextDidSave, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END