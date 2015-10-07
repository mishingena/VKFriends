//
//  MGSImageService.h
//  VKFriends
//
//  Created by Gena on 07.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface MGSImageService : NSObject

- (void)requestImageWithURL:(NSString *)imageURl
                     entity:(id)entity
              entityKeyPath:(NSString *)keyPath
                 onComplete:(OnComplete)onComplete;

@end

NS_ASSUME_NONNULL_END
