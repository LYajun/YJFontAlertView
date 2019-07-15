//
//  YJFontAlertView.m
//  Pods-YJFontAlertView_Example
//
//  Created by 刘亚军 on 2019/7/13.
//

#import "YJFontAlertView.h"
#import <Masonry/Masonry.h>
#import <YJExtensions/YJExtensions.h>


#define YJFontScreenWidth [UIScreen mainScreen].bounds.size.width
#define YJFontImgLeftSpace 68
#define YJFontSliderLeftSpace 56
#define YJFontTitleWidth 40
#define YJFontTitleLeftSpace -18


NSBundle *YJFontAlertViewBundle(void){
    return [NSBundle yj_bundleWithCustomClass:NSClassFromString(@"YJFontAlertView") bundleName:@"YJFontAlertView"];
}


@interface YJFontAlertView ()
@property (nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIImageView *settingLeftImg;
@property(nonatomic,strong) UIImageView *settingRightImg;
@property(nonatomic,strong) UISlider *settingSlider;
@property(nonatomic,strong) UITapGestureRecognizer *tapGesture;

@property(nonatomic,strong) UILabel *settingLab;
@property(nonatomic,strong) UIImageView *settingBgImg;
@end
@implementation YJFontAlertView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.left.bottom.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        UIView *botSpaceView = [UIView new];
        botSpaceView.backgroundColor = [UIColor yj_colorWithHex:0xE6E6E6];
        [self addSubview:botSpaceView];
        [botSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.left.equalTo(self);
            make.bottom.equalTo(self.closeBtn.mas_top);
            make.height.mas_equalTo(6);
        }];
        
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(14);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.settingBgImg];
        [self.settingBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.left.equalTo(self).offset(YJFontImgLeftSpace);
            make.height.equalTo(self.settingBgImg.mas_width).multipliedBy(0.038);
            make.bottom.equalTo(botSpaceView.mas_top).offset(-35);
        }];
        [self addSubview:self.settingSlider];
        [self.settingSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.settingBgImg).offset(1);
            make.left.equalTo(self).offset(YJFontSliderLeftSpace);
            make.height.mas_equalTo(20);
        }];
        
        [self addSubview:self.settingLeftImg];
        [self.settingLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.settingBgImg);
            make.right.equalTo(self.settingBgImg.mas_left).offset(-15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self addSubview:self.settingRightImg];
        [self.settingRightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.height.equalTo(self.settingLeftImg);
            make.left.equalTo(self.settingBgImg.mas_right).offset(15);
        }];
        
        [self addSubview:self.settingLab];
        [self.settingLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.settingSlider.mas_top).offset(-6);
            make.width.mas_equalTo(YJFontTitleWidth);
            make.left.equalTo(self.settingBgImg).offset(YJFontTitleLeftSpace);
        }];
        self.settingLab.text = @"小";
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        [self.settingSlider addGestureRecognizer:self.tapGesture];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self.maskView addGestureRecognizer:tap];
    }
    return self;
}

+ (YJFontAlertView *)fontAlertViewWithFrame:(CGRect)frame{
    YJFontAlertView *fontView = [[YJFontAlertView alloc] initWithFrame:frame];
    
    return fontView;
}

- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in rootWindow.subviews) {
        if ([view isKindOfClass:[YJFontAlertView class]]) {
            [(YJFontAlertView *)view hide];
        }
    }
    [rootWindow addSubview:self.maskView];
    [rootWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.transform = CGAffineTransformMakeTranslation(0, - self.frame.size.height);
    }];
}
- (void)hide{
    [UIView animateWithDuration:0.2 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 0;
    } completion:^(BOOL isFinished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)slideValueChangedAction{
    CGFloat sliderValue = self.settingSlider.value;
    YJFontSettingType settingType = YJFontSettingTypeSmall;
    if (sliderValue < 0.17) {
    }else if (sliderValue < 0.5){
        settingType = YJFontSettingTypeMiddle;
    }else if (sliderValue < 0.83){
        settingType = YJFontSettingTypeBig;
    }else{
        settingType = YJFontSettingTypeSuperBig;
    }
    
    if (self.settingType != settingType && self.delegate && [self.delegate respondsToSelector:@selector(YJFontAlertView:didSettingFontType:)]) {
        [self.delegate YJFontAlertView:self didSettingFontType:settingType];
    }
    
    self.settingType = settingType;
}
- (void)sliderTouchDown:(UISlider *)slider{
    self.tapGesture.enabled = NO;
}
- (void)sliderTouchUp:(UISlider *)slider{
    self.tapGesture.enabled = YES;
    [self slideValueChangedAction];
}
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.settingSlider];
    CGFloat value = (self.settingSlider.maximumValue - self.settingSlider.minimumValue) * (touchPoint.x / self.settingSlider.frame.size.width);
    [self.settingSlider setValue:value animated:YES];
    [self slideValueChangedAction];
}
- (void)setSettingType:(YJFontSettingType)settingType{
    _settingType = settingType;
    CGFloat rate = 0;
    switch (settingType) {
        case YJFontSettingTypeSmall:
            rate = 0;
            self.settingLab.text = @"小";
            break;
        case YJFontSettingTypeMiddle:
            rate = 0.33;
             self.settingLab.text = @"中";
            break;
        case YJFontSettingTypeBig:
            rate = 0.66;
             self.settingLab.text = @"大";
            break;
        case YJFontSettingTypeSuperBig:
            rate = 1.0;
             self.settingLab.text = @"特大";
            break;
    }
    self.settingSlider.value = rate;
    [self.settingLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.settingBgImg).offset(YJFontTitleLeftSpace + rate * (YJFontScreenWidth - YJFontImgLeftSpace*2));
    }];
}

#pragma mark - Getter
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor yj_colorWithHex:0x000000 alpha:0.3];
    }
    return _maskView;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor yj_colorWithHex:0x252525] forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = [UIColor whiteColor];
    }
    return _closeBtn;
}

- (UIImageView *)settingLeftImg{
    if (!_settingLeftImg) {
        _settingLeftImg = [[UIImageView alloc] initWithImage:[UIImage yj_imageNamed:@"yj_fontsetting_decrease" atBundle:YJFontAlertViewBundle()]];
    }
    return _settingLeftImg;
}
- (UIImageView *)settingRightImg{
    if (!_settingRightImg) {
        _settingRightImg = [[UIImageView alloc] initWithImage:[UIImage yj_imageNamed:@"yj_fontsetting_increase" atBundle:YJFontAlertViewBundle()]];
    }
    return _settingRightImg;
}
- (UIImageView *)settingBgImg{
    if (!_settingBgImg) {
        _settingBgImg = [[UIImageView alloc] initWithImage:[UIImage yj_imageNamed:@"yj_fontsetting_line" atBundle:YJFontAlertViewBundle()]];
    }
    return _settingBgImg;
}
- (UILabel *)settingLab{
    if (!_settingLab) {
        _settingLab = [UILabel new];
        _settingLab.textAlignment = NSTextAlignmentCenter;
         _settingLab.font = [UIFont systemFontOfSize:14];
        _settingLab.textColor = [UIColor yj_colorWithHex:0x989898];
    }
    return _settingLab;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"字体设置";
        _titleLab.textColor = [UIColor yj_colorWithHex:0x252525];
        _titleLab.font = [UIFont systemFontOfSize:18];
    }
    return _titleLab;
}
- (UISlider *)settingSlider{
    if (!_settingSlider) {
        _settingSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        [_settingSlider setThumbImage:[UIImage yj_imageNamed:@"yj_fontsetting_slider" atBundle:YJFontAlertViewBundle()] forState:UIControlStateNormal];
        _settingSlider.minimumTrackTintColor = [UIColor clearColor];
        _settingSlider.maximumTrackTintColor = [UIColor clearColor];
        [_settingSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_settingSlider addTarget:self action:@selector(sliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingSlider;
}
@end
