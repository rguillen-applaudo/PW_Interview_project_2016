//
//  EventCollectionViewCell.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "EventCollectionViewCell.h"

@implementation EventCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor], (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.6] CGColor], nil];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
}

@end
