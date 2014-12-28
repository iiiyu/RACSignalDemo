//
//  UISearchController+RAC.h
//  RACSignalDemo
//
//  Created by Xiao ChenYu on 12/28/14.
//  Copyright (c) 2014 sumi-sumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface UISearchController (RAC)

- (RACSignal *)rac_textSignal;

- (RACSignal *)rac_isActiveSignal;

@end
