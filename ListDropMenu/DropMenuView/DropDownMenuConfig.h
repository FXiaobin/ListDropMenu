//
//  DropDownMenuConfig.h
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DropDownMenuConfig : NSObject

///默认的显示文字
@property (nonatomic,strong) NSArray *titles;

///标题颜色
@property  (nonatomic,strong) UIColor *titleNormalColor;
@property  (nonatomic,strong) UIColor *titleSelectedColor;
@property  (nonatomic,strong) UIFont *titleFont;
///图片
@property  (nonatomic,strong) NSString *imageNormalName;
@property  (nonatomic,strong) NSString *imageSelectedName;
///是否有间距线
@property (nonatomic) BOOL isShowVerLine;
///是否有底部线
@property (nonatomic) BOOL isShowBottomLine;

@end
