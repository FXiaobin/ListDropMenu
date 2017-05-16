//
//  DropDownView.h
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDownMenuConfig;

@interface DropDownView : UIView

///顶部的几个按钮
@property  (nonatomic,strong) NSMutableArray *topButtonItems;
///对应顶部按钮的自定义视图数组
@property  (nonatomic,strong) NSArray *itemViews;

-(instancetype)initWithFrame:(CGRect)frame config:(DropDownMenuConfig *)config;

///点击按钮回调
@property  (nonatomic,copy) void (^dropDownMenuBtnActionBlock) (DropDownView *UIView, UIButton *sender, BOOL isOpen);
///点击cell row:点击的是第几行 tag: 第几个按钮
@property  (nonatomic,copy) void (^didSelectedItemBlock) (DropDownView *UIView, NSString *title, NSInteger row, NSInteger tag);


@end
