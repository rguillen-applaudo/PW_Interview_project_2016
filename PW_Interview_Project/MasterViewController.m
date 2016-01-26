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

@interface MasterViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *eventsCollectionView;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"PHUN APP";
    [self.eventsCollectionView registerNib:[UINib nibWithNibName:@"EventCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EventCollectionViewCell"];
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
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 200);
}

#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

@end
