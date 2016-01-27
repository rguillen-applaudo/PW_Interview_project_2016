//
//  EventItemDescriptionTableViewCell.m
//  PW_Interview_Project
//
//  Created by Ricardo Guillen on 1/26/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "RGEventItemDescriptionTableViewCell.h"

@implementation RGEventItemDescriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setFrame:(CGRect)frame {
    if (IS_IPAD) {
        CGRect newFrame = frame;
        
        if (CGRectGetWidth(newFrame) > 600) {
            CGFloat margin = (CGRectGetWidth(newFrame) - 600) / 2;
            newFrame.origin.x = margin;
            newFrame.size.width = 600;
        }
        [super setFrame:newFrame];
    }
    else{
        [super setFrame:frame];
    }
    
    
}

@end
