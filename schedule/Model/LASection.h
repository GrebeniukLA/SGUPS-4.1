//
//  LASection.h
//  schedule
//
//  Created by Leonid Grebenyuk on 06/10/14.
//  Copyright (c) 2014 stu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LASection : NSObject <NSCoding>


@property (strong, nonatomic) NSString *fileGroup;
@property (strong, nonatomic) NSString *nameGroup;
@property (strong, nonatomic) NSString *moreInfo;

@end
