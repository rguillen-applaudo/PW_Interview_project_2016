//
//  RGDetailViewController.h
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGEventModel.h"

@interface RGDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *eventDetailBackgroundImage;
@property (strong, nonatomic) IBOutlet UITableView *eventDetailTableView;
@property (strong, nonatomic) RGEventModel *event;
@end
