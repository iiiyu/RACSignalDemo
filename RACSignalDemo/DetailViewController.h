//
//  DetailViewController.h
//  RACSignalDemo
//
//  Created by Xiao ChenYu on 12/26/14.
//  Copyright (c) 2014 sumi-sumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

