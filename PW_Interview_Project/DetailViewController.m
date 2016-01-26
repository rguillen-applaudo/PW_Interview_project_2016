//
//  DetailViewController.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "DetailViewController.h"
#import "EventItemTimestampTableViewCell.h"
#import "EventItemTitleTableViewCell.h"
#import "EventItemDescriptionTableViewCell.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *eventItems;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavBarActions];
    [self configureDetailTableView];
    [self configureEventItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureTranslucentAppearance];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self restoreDefaultAppearance];
}

#pragma mark - Nav Appearance

- (void)restoreDefaultAppearance {
    //TODO: - RG - Resrore default NavBar appearance
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)configureTranslucentAppearance {
    //TODO: - RG - Set Translucent NavBar appearance
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.eventItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *eventItem = [self.eventItems objectAtIndex:indexPath.row];
    if ([[eventItem valueForKey:@"item"] isEqualToString:@"timestamp"]) {
        EventItemTimestampTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventItemTimeStampCell"];
        if (cell == nil) {
            cell = [[EventItemTimestampTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"EventItemTimeStampCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    else if ([[eventItem valueForKey:@"item"] isEqualToString:@"title"]){
        EventItemTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventItemTitleCell"];
        if (cell == nil) {
            cell = [[EventItemTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"EventItemTitleCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    else if ([[eventItem valueForKey:@"item"] isEqualToString:@"description"]){
        EventItemDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventItemDescriptionCell"];
        if (cell == nil) {
            cell = [[EventItemDescriptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:@"EventItemDescriptionCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    return nil;
}

#pragma mark - Nav Bar Actions

-(void)configureNavBarActions{
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
//                                                                   style:UIBarButtonItemStylePlain
//                                                                  target:self.navigationController
//                                                                  action:@selector(popViewControllerAnimated:)];
//    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self.navigationController
                                                                                 action:@selector(popViewControllerAnimated:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

#pragma mark - TableView Confirugation

-(void)configureDetailTableView{
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250.0f)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor whiteColor] colorWithAlphaComponent:0.0] CGColor], (id)[[[UIColor whiteColor] colorWithAlphaComponent:1.0] CGColor], nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    
    [self.eventDetailTableView setTableHeaderView:gradientView];
    [self.eventDetailTableView setBackgroundColor:[UIColor clearColor]];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"EventItemTimestampTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EventItemTimeStampCell"];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"EventItemTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EventItemTitleCell"];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"EventItemDescriptionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EventItemDescriptionCell"];
    self.eventDetailTableView.rowHeight = UITableViewAutomaticDimension;
    self.eventDetailTableView.estimatedRowHeight = 160.0;
}

#pragma mark - Configure Event Items

-(void)configureEventItems{
    self.eventItems = @[
                        @{
                            @"item" : @"timestamp",
                            @"text" : @"May 4, 2015 at 4:30pm"
                            },
                        @{
                            @"item" : @"title",
                            @"text" : @"DeathStar Ventilation Design Meeting"
                            },
                        @{
                            @"item" : @"description",
                            @"text" : @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                            }
                        ];
}

@end
