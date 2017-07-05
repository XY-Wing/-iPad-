//
//  XYContentViewController.m
//  iPadTest
//
//  Created by Xue Yang on 2017/7/5.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "XYContentViewController.h"

@interface XYContentViewController ()

@end

@implementation XYContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleStr ? _titleStr : @"呵呵";
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0 alpha:1];
    NSLog(@"😄");
}

@end
