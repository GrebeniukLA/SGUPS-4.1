//
//  LAMainNewsTableViewCell.m
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import "LAMainNewsTableViewCell.h"

@implementation LAMainNewsTableViewCell


- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.fonImage.frame = CGRectMake( 0, 0, 320, 100 );
    self.fonImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.picImage.frame = CGRectMake( 10, 10, 50, 50 );
    self.picImage.contentMode = UIViewContentModeScaleAspectFit;
}

@end
