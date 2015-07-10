//
//  LAMainNewsTableViewCell.h
//  schedule
//
//  Created by Leonid Grebenyuk on 29/09/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAMoreInfoButto.h"

@interface LAMainNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fonImage;
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailImage;

@property (weak, nonatomic) IBOutlet LAMoreInfoButto *detailButton;

@end
