//
//  YJViewController.m
//  YJFontAlertView
//
//  Created by lyj on 07/12/2019.
//  Copyright (c) 2019 lyj. All rights reserved.
//

#import "YJViewController.h"
#import <YJFontAlertView/YJFontAlertView.h>


@interface YJViewController ()<YJFontAlertViewDelegate>

@end

@implementation YJViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
}

- (IBAction)fontSettingAction:(UIButton *)sender {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    YJFontAlertView *fontView = [YJFontAlertView fontAlertViewWithFrame:CGRectMake(0, screenSize.height, screenSize.width, 200)];
    fontView.delegate = self;
    fontView.settingType = YJFontSettingTypeMiddle;
    [fontView show];
}

- (void)YJFontAlertView:(YJFontAlertView *)fontView didSettingFontType:(YJFontSettingType)fontType{
    NSLog(@"字体设置类型：%li",fontType);
}
@end
