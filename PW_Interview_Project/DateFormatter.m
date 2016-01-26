//
//  DateFormatter.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

-(NSString *)formattedStringForTimeStamp:(NSString *)timestamp{
    NSDateFormatter *dateFormatterGMT = [[NSDateFormatter alloc] init];
    //                                2015-06-26T04:06:43.598Z
    [dateFormatterGMT setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    NSDateFormatter *dateFormatterHuman = [[NSDateFormatter alloc] init];
    [dateFormatterHuman setDateFormat:@"MMM dd',' YYYY 'at' hh:mma"];
    [dateFormatterHuman setAMSymbol:@"am"];
    [dateFormatterHuman setPMSymbol:@"pm"];
    
    NSDate *dateFrom = [dateFormatterGMT dateFromString:timestamp];
    NSString *formattedDateStringFrom = [dateFormatterHuman stringFromDate:dateFrom];
    NSString *returnString = [NSString stringWithFormat:@"%@", formattedDateStringFrom];
    return returnString;
}

@end
