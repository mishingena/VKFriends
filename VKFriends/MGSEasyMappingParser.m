//
//  MGSEasyMappingParser.m
//  VKFriends
//
//  Created by Gena on 05.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "MGSEasyMappingParser.h"
#import <EasyMapping/EasyMapping.h>
#import "NSError+MGS.h"

@interface MGSEasyMappingParser ()

@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic, strong) EKManagedObjectMapping *mapping;
@property (nonatomic) MGSEasyMappingParserObjectType objectType;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation MGSEasyMappingParser

- (instancetype)initWithKeyPath:(NSString *)keyPath
                        mapping:(EKManagedObjectMapping *)aMapping
                     objectType:(MGSEasyMappingParserObjectType)objectType
                        context:(NSManagedObjectContext *)context {
    _keyPath = keyPath;
    _mapping = aMapping;
    _objectType = objectType;
    _context = context;
    
    return self;
}

- (NSOperation *)parseFromData:(NSData *)aData onComplete:(OnComplete)aOnComplete {
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        id result;
        NSError *error;
        
        id jsonData = [self jsonDataFromData:aData error:&error];
        
        if (error) {
            error = [NSError mgs_errorWithDescription:error.localizedDescription];
        } else {
            if (jsonData) {
                if (self.objectType == MGSEasyMappingParserObjectTypeArray) {
                    result = [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:jsonData withMapping:self.mapping inManagedObjectContext:self.context];
                    
                } else {
                    result = [EKManagedObjectMapper objectFromExternalRepresentation:jsonData withMapping:self.mapping inManagedObjectContext:self.context];
                    
                }
                
            } else {
                error = [NSError mgs_errorWithDescription:@"Couldn't find data to parse"];
            }
        }
        aOnComplete(result, error);
    }];
    
    [self.queue addOperation:operation];
    
    return operation;
}

- (id)jsonDataFromData:(NSData *)aData error:(NSError **)error {
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:error];
    
    if (self.keyPath.length > 0) {
        return [data valueForKeyPath:self.keyPath];
    }
    return data;
}

- (NSOperationQueue * __nonnull)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

@end
