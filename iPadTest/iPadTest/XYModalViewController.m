//
//  XYModalViewController.m
//  iPadTest
//
//  Created by Xue Yang on 2017/7/5.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "XYModalViewController.h"

@interface XYModalViewController ()

@end

@implementation XYModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleStr ? _titleStr : @"测试";
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0 alpha:1];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemDidClicked)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (void)leftBarButtonItemDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"a");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0 alpha:1];
    return cell;
}
@end
