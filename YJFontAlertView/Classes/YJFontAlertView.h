//
//  YJFontAlertView.h
//  Pods-YJFontAlertView_Example
//
//  Created by 刘亚军 on 2019/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define YJFontSettingType_UserDefault_key @"YJFontSettingType_UserDefault_key"

typedef NS_ENUM(NSInteger,YJFontSettingType){
    YJFontSettingTypeSmall,
    YJFontSettingTypeMiddle,
    YJFontSettingTypeBig,
    YJFontSettingTypeSuperBig
};

@class YJFontAlertView;
@protocol YJFontAlertViewDelegate <NSObject>

@optional
- (void)YJFontAlertView:(YJFontAlertView *)fontView didSettingFontType:(YJFontSettingType)fontType;
@end
@interface YJFontAlertView : UIView

@property (nonatomic,assign) id<YJFontAlertViewDelegate> delegate;

/** 字体设置 */
@property (nonatomic,assign) YJFontSettingType settingType;

+ (YJFontAlertView *)fontAlertViewWithFrame:(CGRect)frame;

- (void)show;
@end

NS_ASSUME_NONNULL_END
