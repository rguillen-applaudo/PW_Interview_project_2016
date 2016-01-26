//
//  DetailViewController.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor greenColor]];
    self.title = @"Detail view";
    [self configureDetailTableView];
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
}

- (void)configureTranslucentAppearance {

}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - TableView Confirugation

-(void)configureDetailTableView{
    [self.eventDetailTableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250.0f)]];
    [self.eventDetailTableView setBackgroundColor:[UIColor clearColor]];
}

@end
