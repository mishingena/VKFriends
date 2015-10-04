//
//  MGSNetwork.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MGS_EXTERN extern __attribute__((visibility ("default")))

typedef void(^OnComplete)(id __nullable result, NSError * __nullable error);

@interface MGSNetwork : NSObject

@end

@interface MGSNetwork (Path)

MGS_EXTERN NSString * const __nonnull MGSServerURLPath;
MGS_EXTERN NSString * const __nonnull MGSAuthorizationServerURLPath;
MGS_EXTERN NSString * const __nonnull MGSAuthorizationPath;
MGS_EXTERN NSString * const __nonnull MGSAuthorizationRedirectURLPath;

@end

@interface MGSNetwork (Paramters)

+ (NSString * __nonnull)stringWithParametersFromDictionary:(NSDictionary * __nonnull)dict;

@end

@interface MGSNetwork (Erorrs)

MGS_EXTERN NSString * const __nonnull MGSUserDeniedRequestError;
MGS_EXTERN NSString * const __nonnull MGSDomainError;

@end

@interface MGSNetwork (HTTPMethod)

typedef NS_OPTIONS(NSUInteger, MGSHTTPMethod) {
    MGSHTTPMethodGet = 0,
    MGSHTTPMethodPost
};

@end
