//
//  MGSGroupOperation.h
//  VKFriends
//
//  Created by Gena on 04.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSGroupOperation : NSOperation

- (instancetype)initWithOperations:(NSArray *)operations queue:(NSOperationQueue *)queue;

@end
