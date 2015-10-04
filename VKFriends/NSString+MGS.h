//
//  NSString+MGS.h
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MGS)

+ (NSString *)stringBetweenString:(NSString *)start
                        andString:(NSString *)end
                      innerString:(NSString *)string;


@end
