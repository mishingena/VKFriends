//
//  MGSCacheLayer.m
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSCacheLayer.h"
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/MagicalRecord+ShorthandMethods.h>
#import <MagicalRecord/MagicalRecordShorthandMethodAliases.h>
#import <CoreData/CoreData.h>
#import "VKFriend.h"

NSString * const MGSNotificationCacheCleared = @"MGSNotificationCacheCleared";

@interface MGSCacheLayer ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation MGSCacheLayer

- (instancetype)initWithDefaultContext {
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model"];
        _context = [NSManagedObjectContext MR_defaultContext];
    }
    return self;
}

- (NSManagedObjectContext *)context {
    return _context;
}

- (void)clean:(void(^)(BOOL contextDidSave, NSError *error))completion {
    NSArray *allEntities = [NSManagedObjectModel MR_defaultManagedObjectModel].entities;
    
    [allEntities enumerateObjectsUsingBlock:^(NSEntityDescription *entityDescription, NSUInteger idx, BOOL *stop) {
        [NSClassFromString([entityDescription managedObjectClassName]) MR_truncateAll];
    }];
    
    [self save:^(BOOL contextDidSave, NSError *error) {
        completion(contextDidSave, error);
        [[NSNotificationCenter defaultCenter] postNotificationName:MGSNotificationCacheCleared object:nil];
    }];
}

- (void)save:(void(^)(BOOL contextDidSave, NSError *error))completion {
    [self.context MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        completion(contextDidSave, error);
    }];
}

- (void)fetchAllEntityForName:(NSString *)entityName withCompletion:(void(^)(id result))completion {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    Class ClassToFetch = NSClassFromString([entityDescription managedObjectClassName]);
    id fetchedObjects = [ClassToFetch MR_findAllInContext:self.context];
    completion(fetchedObjects);
}

- (void)fetchAllEntityForName:(NSString *)entityName
              sortParameterts:(NSString *)sortParameterts
               withCompletion:(void (^)(id))completion {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    Class ClassToFetch = NSClassFromString([entityDescription managedObjectClassName]);
    id fetchedObjects = [ClassToFetch MR_findAllSortedBy:sortParameterts ascending:YES inContext:self.context];
    completion(fetchedObjects);
    
}

- (void)updateEntity:(id)entity
          withObject:(id)object
       entityKeyPath:(NSString *)keyPath
          completion:(void(^)(BOOL contextDidSave, NSError *error))completion {
    [entity setValue:object forKey:keyPath];
    [self save:^(BOOL contextDidSave, NSError * _Nonnull error) {
        completion(contextDidSave, error);
    }];
}

@end
