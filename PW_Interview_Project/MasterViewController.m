//
//  MasterViewController.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "MasterViewController.h"
#import "EventCollectionViewCell.h"
#import "DetailViewController.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"
#import "EventModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MasterViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *eventsCollectionView;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NetworkManager *networkManager;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PHUN APP";
    [self.eventsCollectionView registerNib:[UINib nibWithNibName:@"EventCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EventCollectionViewCell"];
    [self.eventsCollectionView setBackgroundColor:[UIColor clearColor]];
    self.networkManager = [[NetworkManager alloc] startNetworkManager];
    [self requestEventsFromAPI];
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
    EventModel *event = [self.eventsArray objectAtIndex:indexPath.row];
    NSLog(@"event %@", event);
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
    
    [cell.backgroundImage sd_setImageWithURL:[NSURL URLWithString:event.imageSTR]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
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
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

#pragma mark - Request Events from API

-(void)requestEventsFromAPI{
    if (self.networkManager.networkManagerConnected) {
        NSLog(@"Connected");
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.networkManager requestDataFromURL:@"https://raw.githubusercontent.com/phunware/services-interview-resources/master/feed.json" success:^(id responseObject){
            NSLog(@"funciona");
            NSArray *jsonArray = [NSArray arrayWithArray:responseObject];
            self.eventsArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (id item in jsonArray) {
                NSError* err = nil;
                EventModel* event = [[EventModel alloc] initWithDictionary:item error:&err];
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
        //TODO: - RG - Show alert
    }
    
}

@end

