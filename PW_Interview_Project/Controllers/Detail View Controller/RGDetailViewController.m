//
//  RGDetailViewController.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "RGDetailViewController.h"
#import "RGEventItemTimestampTableViewCell.h"
#import "RGEventItemTitleTableViewCell.h"
#import "RGEventItemDescriptionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "UINavigationBar+Awesome.h"
#define NAVBAR_CHANGE_POINT 50

@interface RGDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *eventItems;
@property (nonatomic, assign) float originalYPosition;
@property (nonatomic, strong) UIView *partialBackgroundView;
@end

@implementation RGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavBarActions];
    [self configureDetailTableView];
    [self configureEventItems];
    self.originalYPosition = self.eventDetailBackgroundImage.frame.origin.y;
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
    [self.navigationController.navigationBar lt_reset];
}

- (void)configureTranslucentAppearance {
    [self scrollViewDidScroll:self.eventDetailTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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
    if ([[eventItem valueForKey:@"item"] isEqualToString:@"eventTimestamp"]) {
        RGEventItemTimestampTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RGEventItemTimeStampCell"];
        if (cell == nil) {
            cell = [[RGEventItemTimestampTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"RGEventItemTimeStampCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    else if ([[eventItem valueForKey:@"item"] isEqualToString:@"eventTitle"]){
        RGEventItemTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RGEventItemTitleCell"];
        if (cell == nil) {
            cell = [[RGEventItemTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"RGEventItemTitleCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    else if ([[eventItem valueForKey:@"item"] isEqualToString:@"eventDescription"]){
        RGEventItemDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RGEventItemDescriptionCell"];
        if (cell == nil) {
            cell = [[RGEventItemDescriptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:@"RGEventItemDescriptionCell"];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.cellTextLabel.text = [eventItem valueForKey:@"text"];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Nav Bar Actions

-(void)configureNavBarActions{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(shareEvent:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - TableView Confirugation

-(void)configureDetailTableView{
    
    [self.eventDetailTableView setBackgroundColor:[UIColor clearColor]];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"RGEventItemTimestampTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RGEventItemTimeStampCell"];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"RGEventItemTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RGEventItemTitleCell"];
    [self.eventDetailTableView registerNib:[UINib nibWithNibName:@"RGEventItemDescriptionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RGEventItemDescriptionCell"];
    self.eventDetailTableView.rowHeight = UITableViewAutomaticDimension;
    self.eventDetailTableView.estimatedRowHeight = 160.0;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.eventDetailTableView.frame.size.width, 250.0f)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor whiteColor] colorWithAlphaComponent:0.0] CGColor], (id)[[[UIColor whiteColor] colorWithAlphaComponent:1.0] CGColor], nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    
    [self.eventDetailTableView setTableHeaderView:gradientView];
    
    // Create the UIView that will become the tableView backgroundView
    UIView *tableViewBackground = [[UIView alloc] initWithFrame:self.eventDetailTableView.frame];
    tableViewBackground.backgroundColor = [UIColor clearColor];
    
    // Create the opaque backgroundView and set the frame so that it starts below the headerView
    self.partialBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 250.0f, self.view.bounds.size.width, self.view.bounds.size.height - 250.0f)];
    self.partialBackgroundView.backgroundColor = [UIColor whiteColor];
    
    // Add the partial background to the main background view and apply it to the tableView
    [tableViewBackground addSubview:self.partialBackgroundView];
    self.eventDetailTableView.backgroundView = tableViewBackground;
}

#pragma mark - Configure Event Items

-(void)configureEventItems{
    [self.eventDetailBackgroundImage sd_setImageWithURL:[NSURL URLWithString:self.event.eventImage]
                            placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.eventItems = @[
                        @{
                            @"item" : @"eventTimestamp",
                            @"text" : self.event.formattedTimestamp
                            },
                        @{
                            @"item" : @"eventTitle",
                            @"text" : self.event.eventTitle
                            },
                        @{
                            @"item" : @"eventDescription",
                            @"text" : self.event.eventDescription
                            }
                        ];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Nav bar changes
    CATransition *fadeTextAnimation = [CATransition animation];
    fadeTextAnimation.duration = 0.5;
    fadeTextAnimation.type = kCATransitionFade;
    
    [self.navigationController.navigationBar.layer addAnimation:fadeTextAnimation forKey:@"fadeText"];
    
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.title = @"DeathStar Ventilation Design Meeting";
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
        self.title = @"";
    }
    
    // Header Image Changes
    if (offsetY > 0)
    {
        CGRect currentFrame = self.eventDetailBackgroundImage.frame;
        CGRect newFrame = CGRectMake(currentFrame.origin.x, self.originalYPosition - (offsetY / 2), currentFrame.size.width, 250);
        self.eventDetailBackgroundImage.frame = newFrame;
        
        
        CGRect currentFramePartialBG = self.partialBackgroundView.frame;
        CGRect newFramePartialBG = CGRectMake(currentFramePartialBG.origin.x, self.originalYPosition + 250 - offsetY, currentFramePartialBG.size.width, currentFramePartialBG.size.height);
        self.partialBackgroundView.frame = newFramePartialBG;
    }
    else
    {
        CGRect currentFrame = self.eventDetailBackgroundImage.frame;
        CGRect newFrame = CGRectMake(currentFrame.origin.x, 0, currentFrame.size.width, 250 - offsetY);
        self.eventDetailBackgroundImage.frame = newFrame;
        
        CGRect currentFramePartialBG = self.partialBackgroundView.frame;
        CGRect newFramePartialBG = CGRectMake(currentFramePartialBG.origin.x, self.originalYPosition + 250 - offsetY, currentFramePartialBG.size.width, currentFramePartialBG.size.height);
        self.partialBackgroundView.frame = newFramePartialBG;
    }
    
}

#pragma mark - Sharing

-(void)shareEvent:(id)sender{
    [self shareText:self.event.eventTitle andImage:self.eventDetailBackgroundImage.image andUrl:nil];
}

- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    if (IS_IPAD) {
        activityController.popoverPresentationController.sourceView = self.eventDetailTableView;
    }
    [self presentViewController:activityController animated:YES completion:nil];
}

@end
