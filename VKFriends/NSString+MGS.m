//
//  NSString+MGS.m
//  VKFriends
//
//  Created by Gena on 03.10.15.
//  Copyright © 2015 Gena. All rights reserved.
//

#import "NSString+MGS.h"

@implementation NSString (MGS)

+ (NSString *)stringBetweenString:(NSString *)start
                        andString:(NSString *)end
                      innerString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString *result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}

@end
