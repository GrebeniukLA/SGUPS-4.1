//
//  LAWebViewViewController.h
//  schedule
//
//  Created by Leonid Grebenyuk on 02/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LAWebViewViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic,strong) NSURL *webLink;
@end
