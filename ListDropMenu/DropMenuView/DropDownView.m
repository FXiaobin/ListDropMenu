//
//  DropDownView.m
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "DropDownView.h"
#import "DropDownMenuConfig.h"
#import "SigleTableListView.h"
#import "SigleCollectionItemView.h"
#import <UIButton+SSEdgeInsets.h>

#define DorpDownMenuButton_Tag  439883409
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight  [UIScreen mainScreen].bounds.size.height

@interface DropDownView ()

@property (nonatomic,strong) DropDownMenuConfig *menuConfig;
///是否为展开状态
@property  (nonatomic) BOOL isOpen;

@property  (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIView *selectedListView;

///黑色底层
@property  (nonatomic,strong) UIView *coverBgView;

@end

@implementation DropDownView

-(UIView *)coverBgView{
    if (_coverBgView == nil) {
        _coverBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 0.0)];
        _coverBgView.backgroundColor = [UIColor blackColor];
        _coverBgView.alpha = 0.0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCoverBgViewTap:)];
        [_coverBgView addGestureRecognizer:tap];
    }
    return _coverBgView;
}

-(NSMutableArray *)topButtonItems{
    if (_topButtonItems == nil) {
        _topButtonItems = [NSMutableArray array];
    }
    return _topButtonItems;
}

-(instancetype)initWithFrame:(CGRect)frame config:(DropDownMenuConfig *)config{
    if (self = [super initWithFrame:frame]) {
        self.menuConfig = config;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    NSInteger count = self.menuConfig.titles.count;
    
    if (count <= 0) {
        NSLog(@"标题不能为空");
        return;
    }
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (kWidth/count), 0, kWidth/count, self.frame.size.height)];
        btn.tag = DorpDownMenuButton_Tag + i;
        [btn setTitle:self.menuConfig.titles[i] forState:UIControlStateNormal];
        
        UIColor *normalColor = self.menuConfig.titleNormalColor ? self.menuConfig.titleNormalColor : [UIColor blackColor];
        UIColor *selectedColor = self.menuConfig.titleSelectedColor ? self.menuConfig.titleSelectedColor : [UIColor orangeColor];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(dropDownMenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.menuConfig.titleFont) {
            btn.titleLabel.font = self.menuConfig.titleFont;
        }
        
        if (self.menuConfig.imageNormalName) {
            [btn setImage:[UIImage imageNamed:self.menuConfig.imageNormalName] forState:UIControlStateNormal];
        }
        if (self.menuConfig.imageSelectedName) {
            [btn setImage:[UIImage imageNamed:self.menuConfig.imageSelectedName] forState:UIControlStateSelected];
        }
        [btn setImagePositionWithType:SSImagePositionTypeRight spacing:2.0];
        [self addSubview:btn];
        
        [self.topButtonItems removeAllObjects];
        [self.topButtonItems addObject:btn];
        
        if (self.menuConfig.isShowVerLine && i < count-1) {
            UIImageView *verLine = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), (CGRectGetHeight(self.frame) - 20.0)/2.0, 1.0, 20.0)];
            verLine.backgroundColor = [UIColor grayColor];
            [self addSubview:verLine];
        }
     
    }
    
    if (self.menuConfig.isShowBottomLine) {
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) -1.0, kWidth, 1.0)];
        bottomLine.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomLine];
    }
    
}

- (void)dropDownMenuBtnAction:(UIButton *)sender{
    NSInteger index = sender.tag - DorpDownMenuButton_Tag;
    self.selectedBtn.selected = NO;
    
    self.selectedListView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 0);
    
    if (sender != self.selectedBtn) {
        self.isOpen = YES;
    }else{
        self.isOpen = !self.isOpen;
    }
    
    UIView *aView;
    if (index !=0) {
        SigleTableListView *listView = self.itemViews[index];
        aView = listView;
        listView.backgroundColor = [UIColor whiteColor];
        listView.didSelectRowAtIndexPathBlock = ^(NSString *title, NSInteger row) {
            [self.selectedBtn setTitle:title forState:UIControlStateNormal];
            [self.selectedBtn setImagePositionWithType:SSImagePositionTypeRight spacing:2.0];
            [self hiddenCoverBgViewTap:nil];
            
            if (self.didSelectedItemBlock) {
                self.didSelectedItemBlock(self, title, row, index);
            }
        };
    }else{
        SigleCollectionItemView *itemView = self.itemViews[index];
        aView = itemView;
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.didSelectRowAtIndexPathBlock = ^(NSString *title, NSInteger row) {
            [self.selectedBtn setTitle:title forState:UIControlStateNormal];
            [self.selectedBtn setImagePositionWithType:SSImagePositionTypeRight spacing:2.0];
            [self hiddenCoverBgViewTap:nil];
            
            if (self.didSelectedItemBlock) {
                self.didSelectedItemBlock(self, title, row, index);
            }
        };
    }
    
    
    if (self.isOpen) {
        sender.selected = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.coverBgView.alpha = 0.3;
            self.coverBgView.hidden = NO;
            ///设置视图的高度
            
            if ([aView isKindOfClass:[SigleTableListView class]]) {
                SigleTableListView *lView = (SigleTableListView *)aView;
                aView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 44 * lView.dataArr.count);
            }else{
                SigleCollectionItemView *cView = (SigleCollectionItemView *)aView;
                cView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 100.0);
            }
            
            
        }];
    }else{
        sender.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.coverBgView.alpha = 0.0;
            aView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 0);
            
        }completion:^(BOOL finished) {
            self.coverBgView.hidden = YES;
        }];
    }
    self.coverBgView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, kHeight);
    [self.superview addSubview:self.coverBgView];
    
    [self.superview addSubview:aView];
    
    self.selectedBtn = sender;
    self.selectedListView = aView;
    
    
    
    
    
}

- (void)hiddenCoverBgViewTap:(UITapGestureRecognizer *)ges{
    self.isOpen = NO;
    self.selectedBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.coverBgView.alpha = 0.0;
         self.selectedListView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), kWidth, 0);
        
    }completion:^(BOOL finished) {
        self.coverBgView.hidden = YES;
    }];
    
}

@end
