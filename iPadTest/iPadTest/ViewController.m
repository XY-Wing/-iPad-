//
//  ViewController.m
//  iPadTest
//
//  Created by Xue Yang on 2017/7/5.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "XYModalViewController.h"
#import "XYContentViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UIView *dock;
@property(nonatomic,strong)UIView *bottomMenu;
@property(nonatomic,strong)NSMutableArray <UIView *>*itemArr;
@property(nonatomic,assign)NSInteger selectedindex;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *vcArr;
@end

@implementation ViewController
- (NSMutableArray<UIViewController *> *)vcArr
{
    if (!_vcArr) {
        NSArray *arr = @[@1,@2,@3,@4,@5,@6,@7];
        _vcArr = [NSMutableArray arrayWithArray:arr];
    }
    return _vcArr;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:35/255.0 green:35/255.0 blue:35/255.0 alpha:1];
    
    UIView *dock = [[UIView alloc] init];
    dock.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:dock];
    _dock = dock;
    [dock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        if (self.view.frame.size.height > self.view.frame.size.width) {
            make.width.equalTo(@70);
        } else {
            make.width.equalTo(@270);
        }
        
    }];
    
    
    UIView *bottomMenu = [[UIView alloc] init];
    bottomMenu.backgroundColor = [UIColor purpleColor];
    [dock addSubview:bottomMenu];
    _bottomMenu = bottomMenu;
    [bottomMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(dock);
        if (self.view.frame.size.height > self.view.frame.size.width) {
            make.height.equalTo(@(70 * 3));
        } else {
            make.height.equalTo(@70);
        }
    }];
    
    NSMutableArray *itemArr = @[].mutableCopy;
    _itemArr = itemArr;
    for (int i = 0; i < 3; i ++) {
        UIView  *item = [[UIView alloc] init];
        item.tag = i;
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomMenuItemDidClicked:)]];
        item.backgroundColor = [UIColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0 alpha:1];
        [bottomMenu addSubview:item];
        [itemArr addObject:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
           if (self.view.frame.size.height > self.view.frame.size.width) {
               make.left.right.equalTo(bottomMenu);
               make.height.equalTo(bottomMenu.mas_width);
               if (i == 0) {
                   make.top.equalTo(bottomMenu);
               } else {
                   UIView *preItem = itemArr[i - 1];
                   make.top.equalTo(preItem.mas_bottom);
               }
               
            } else {
                CGFloat ratio = 1.0/3;
                make.width.equalTo(bottomMenu.mas_width).multipliedBy(ratio);
                make.top.bottom.equalTo(bottomMenu);
                if (i == 0) {
                    make.left.equalTo(bottomMenu);
                } else {
                    UIView *preItem = itemArr[i - 1];
                    make.left.equalTo(preItem.mas_right);
                }
            }
        }];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = [NSString stringWithFormat:@"%d",i];
        lab.userInteractionEnabled = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        [item addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(item);
        }];
    }
    
    UIView *tabbarV = [[UIView alloc] init];
    tabbarV.backgroundColor = [UIColor blueColor];
    [dock addSubview:tabbarV];
    [tabbarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(dock);
        make.bottom.equalTo(bottomMenu.mas_top);
        make.height.equalTo(@(70 * 7));
    }];
    
    NSMutableArray <UIView *>*itemArr2 = @[].mutableCopy;
    for (int i = 0; i < 7; i ++) {
        UIView  *item = [[UIView alloc] init];
        item.tag = i;
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabbarVItemDidClicked:)]];
        item.backgroundColor = [UIColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0 alpha:1];
        [tabbarV addSubview:item];
        [itemArr2 addObject:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tabbarV);
            make.height.equalTo(tabbarV.mas_height).multipliedBy(1.0/7);
            if (i == 0) {
                make.top.equalTo(tabbarV);
            } else {
                UIView *preItem = itemArr2[i - 1];
                make.top.equalTo(preItem.mas_bottom);
            }
        }];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = [NSString stringWithFormat:@"%d",i];
        lab.userInteractionEnabled = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        [item addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(item);
        }];
    }
    
    UIView *avatarV = [[UIView alloc] init];
    avatarV.backgroundColor = [UIColor blueColor];
    [dock addSubview:avatarV];
    [avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(dock);
        make.top.equalTo(@50);
        make.left.equalTo(@5);
        make.right.equalTo(@(-5));
        make.height.equalTo(avatarV.mas_width);
    }];
    
    [self addChildVC:0];
    [self addChildVCsView:0];
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [_dock mas_updateConstraints:^(MASConstraintMaker *make) {
        if (size.height > size.width) {
            make.width.equalTo(@70);
        } else {
            make.width.equalTo(@270);
        }
        
    }];
    
    [_bottomMenu mas_updateConstraints:^(MASConstraintMaker *make) {
        if (size.height > size.width) {
            make.height.equalTo(@(70 * 3));
        } else {
            make.height.equalTo(@70);
        }
    }];
    
    for (int i = 0; i < _itemArr.count; i ++) {
        UIView *item = _itemArr[i];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (size.height > size.width) {
                make.left.right.equalTo(_bottomMenu);
                make.height.equalTo(_bottomMenu.mas_width);
                if (i == 0) {
                    make.top.equalTo(_bottomMenu);
                } else {
                    UIView *preItem = _itemArr[i - 1];
                    make.top.equalTo(preItem.mas_bottom);
                }
                
            } else {
                CGFloat ratio = 1.0/_itemArr.count;
                make.width.equalTo(_bottomMenu.mas_width).multipliedBy(ratio);
                make.top.bottom.equalTo(_bottomMenu);
                if (i == 0) {
                    make.left.equalTo(_bottomMenu);
                } else {
                    UIView *preItem = _itemArr[i - 1];
                    make.left.equalTo(preItem.mas_right);
                }
            }
        }];
        
    }
}
- (void)bottomMenuItemDidClicked:(UITapGestureRecognizer *)tap
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[XYModalViewController alloc] init]];
    
    switch (tap.view.tag) {
        case 0:
        {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
        }
            break;
        case 1:
        {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
        }
            break;
        case 2:
        {
            nav.modalPresentationStyle = UIModalPresentationPageSheet;
        }
            break;
            
        default:
            break;
    }
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)tabbarVItemDidClicked:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == _selectedindex) return;
    
    [self addChildVC:tap.view.tag];
    [self addChildVCsView:tap.view.tag];
//    switch (tap.view.tag) {
//        case 0:
//        {
//            
//            
//        }
//            break;
//        case 1:
//        {
//            
//        }
//            break;
//        case 2:
//        {
//            
//        }
//            break;
//        case 3:
//        {
//            
//        }
//            break;
//        case 4:
//        {
//            
//        }
//            break;
//        case 5:
//        {
//            
//        }
//            break;
//        case 6:
//        {
//            
//        }
//            break;
//        case 7:
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
}
- (void)addChildVC:(NSInteger)tag
{
    if ([[self.vcArr objectAtIndex:tag] isKindOfClass:[UIViewController class]]) return;
    XYContentViewController *contentVC = [[XYContentViewController alloc] init];
    contentVC.titleStr = [NSString stringWithFormat:@"这是第%zd个VC",tag];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contentVC];
    [self addChildViewController:nav];
    [self.vcArr replaceObjectAtIndex:tag withObject:nav];
    
}
- (void)addChildVCsView:(NSInteger)tag{
    [self.vcArr[_selectedindex].view removeFromSuperview];
    UIViewController *vc = self.vcArr[tag];
    [self.view addSubview:vc.view];
    _selectedindex = tag;
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.top.equalTo(@20);
        make.left.equalTo(_dock.mas_right);
    }];
}
@end
