//
//  MasterViewController.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "RGMasterViewController.h"
#import "constants.h"
#import "RGEventCollectionViewCell.h"
#import "RGDetailViewController.h"
#import "RGNetworkManager.h"
#import "MBProgressHUD.h"
#import "RGEventModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RGMasterViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *eventsCollectionView;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) RGNetworkManager *networkManager;
@end

@implementation RGMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PHUN APP";
    [self.eventsCollectionView registerNib:[UINib nibWithNibName:@"RGEventCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"RGEventCollectionViewCell"];
    [self.eventsCollectionView setBackgroundColor:[UIColor clearColor]];
    self.networkManager = [[RGNetworkManager alloc] startNetworkManager];
    [self requestEventsFromAPI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.eventsCollectionView performBatchUpdates:nil completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.eventsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RGEventModel *event = [self.eventsArray objectAtIndex:indexPath.row];
    NSLog(@"event %@", event);
    RGEventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RGEventCollectionViewCell" forIndexPath:indexPath];
    
    [cell.backgroundImage sd_setImageWithURL:[NSURL URLWithString:event.imageSTR]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.timestampLabel.text = event.formattedTimestamp;
    cell.titleLabel.text = event.titleSTR;
    cell.descriptionLabel.text = event.truncatedDescription;
    cell.subtitleLabel.text = event.locationline1STR;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPAD) {
        float itemWidth = self.view.bounds.size.width/2;
        return CGSizeMake(itemWidth, 250);
    }
    return CGSizeMake(self.view.bounds.size.width, 250);
}

#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RGEventModel *event = [self.eventsArray objectAtIndex:indexPath.row];
    RGDetailViewController *detailViewController = [[RGDetailViewController alloc] initWithNibName:@"RGDetailViewController" bundle:[NSBundle mainBundle]];
    detailViewController.event = event;
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

#pragma mark - Request Events from API

-(void)requestEventsFromAPI{
    if (self.networkManager.networkManagerConnected) {
        NSLog(@"Connected");
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.networkManager requestDataFromURL:API_URL success:^(id responseObject){
            NSLog(@"funciona");
            NSArray *jsonArray = [NSArray arrayWithArray:responseObject];
            self.eventsArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (id item in jsonArray) {
                NSError* err = nil;
                RGEventModel* event = [[RGEventModel alloc] initWithDictionary:item error:&err];
                NSLog(@"ERROR %@", err.localizedDescription);
                [self.eventsArray addObject:event];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.eventsCollectionView reloadData];
            });
        } error:^(NSError *error){
            NSLog(@"no funciona");
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                });
            });
        }];
    }
    else{
        NSLog(@"NOT CONNECTED");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network connection" message:@"Network not available" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
        [alert show];
    }
    
}

#pragma mark - AlertView Delegate

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        [self requestEventsFromAPI];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.eventsCollectionView performBatchUpdates:^(){
        NSArray *visbleCellPaths = [self.eventsCollectionView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in visbleCellPaths) {
            RGEventCollectionViewCell *cell = (RGEventCollectionViewCell *)[self.eventsCollectionView cellForItemAtIndexPath:indexPath];
            [cell setNeedsDisplay];
        }
    } completion:^(BOOL completed){
        //
    }];
}

@end

