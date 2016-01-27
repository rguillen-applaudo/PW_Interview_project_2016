//
//  RGEventCollectionViewCell.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "RGEventCollectionViewCell.h"

@implementation RGEventCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self.gradientLayer removeFromSuperlayer];
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientView.bounds;
    self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor], (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.6] CGColor], nil];
    self.gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.gradientView.layer insertSublayer:self.gradientLayer atIndex:0];
}

@end
