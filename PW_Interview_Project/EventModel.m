//
//  EventModel.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel
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
@end
