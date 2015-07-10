//
//  UIView+UITableViewCell.m
//  English School
//
//  Created by Leonid Grebenyuk on 11/06/14.
//  Copyright (c) 2014 lada. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell*) superCell {
    
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)self.superview;
    }
    
    return [self.superview superCell];
}

@end
