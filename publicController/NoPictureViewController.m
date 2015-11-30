//
//  NoPictureViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-6-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "NoPictureViewController.h"

@interface NoPictureViewController ()

@end

@implementation NoPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无权限";
    self.navigationItem.leftBarButtonItem = nil;
    [self setNavRightBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavRightBtn{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的显示区域
    [rightButton setFrame: CGRectMake(0, 0, 40, 30)];
    //设置按钮的前景显示图
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"questionAreaHomeRightBg"] forState:UIControlStateNormal];
    //监听点击事件
    [rightButton addTarget:self action:@selector(RightDown) forControlEvents:UIControlEventTouchDown];
    //加载导航栏中
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
}
-(void) RightDown
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
