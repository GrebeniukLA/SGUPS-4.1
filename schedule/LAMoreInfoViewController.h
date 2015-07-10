//
//  LAMoreInfoViewController.h
//  schedule
//
//  Created by Leonid Grebenyuk on 07/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LAMoreInfoViewController : UIViewController

@property (strong, nonatomic) NSString* moreInfo;
@property (strong, nonatomic) NSString* nameSection;
@property (weak, nonatomic) IBOutlet UITextView *moreInfoTextView;



@end
