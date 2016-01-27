//
//  EventModel.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "RGEventModel.h"
#import "RGDateFormatter.h"

@implementation RGEventModel


// keyMapper is a method implemented by JSONModel to map JSON Keys to Model properties
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descriptionSTR",
                                                       @"title": @"titleSTR",
                                                       @"timestamp": @"timestampSTR",
                                                       @"image": @"imageSTR",
                                                       @"phone": @"phoneSTR",
                                                       @"date": @"dateSTR",
                                                       @"locationline1": @"locationline1STR",
                                                       @"locationline2": @"locationline2STR",
                                                       }];
}

// formattedTimestamp this is a getter method to retun a human readable string from timestamp property using RGDateFormatter Class methods
-(NSString *)formattedTimestamp{
    NSString *stringFromDate = [[RGDateFormatter alloc] formattedStringForTimeStamp:self.timestampSTR];
    return stringFromDate;
}

// truncatedDescription returns a short description of the event to use on the main events list (grid)
// This method evaluates is the string for description is grather than 100 charactes
// if the string length is grather than 100 it truncates the string to return a shorter description
-(NSString *)truncatedDescription{
    NSRange stringRange = {0,100};
    NSString *myString = self.descriptionSTR;
    if (myString.length > 100) {
        NSString *shortString = [myString substringWithRange:stringRange];
        return shortString;
    }
    else{
        return myString;
    }
    
}

@end
