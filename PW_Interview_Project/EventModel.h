//
//  EventModel.h
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EventModel : JSONModel
@property (strong, nonatomic) NSString *descriptionSTR;
@property (strong, nonatomic) NSString *titleSTR;
@property (strong, nonatomic) NSString *timestampSTR;
@property (strong, nonatomic) NSString<Optional> *imageSTR;
@property (strong, nonatomic) NSDate<Optional> *phoneSTR;
@property (strong, nonatomic) NSDate *dateSTR;
@property (strong, nonatomic) NSString *locationline1STR;
@property (strong, nonatomic) NSString<Optional> *locationline2STR;

-(NSString *)formattedTimestamp;
-(NSString *)truncatedDescription;

@end
