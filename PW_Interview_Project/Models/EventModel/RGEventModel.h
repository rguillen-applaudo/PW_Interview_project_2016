//
//  EventModel.h
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RGEventModel : JSONModel
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventTimestamp;
@property (strong, nonatomic) NSString<Optional> *eventImage;
@property (strong, nonatomic) NSDate<Optional> *eventPhone;
@property (strong, nonatomic) NSDate *eventDate;
@property (strong, nonatomic) NSString *eventLocationLine1;
@property (strong, nonatomic) NSString<Optional> *eventLocationLine2;

-(NSString *)formattedTimestamp;
-(NSString *)truncatedDescription;

@end
