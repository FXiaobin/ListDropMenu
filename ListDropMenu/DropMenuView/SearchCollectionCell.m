//
//  SearchCollectionCell.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/17.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "SearchCollectionCell.h"
#import <Masonry.h>
#import "UIColor+YGExtension.m"

#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/1080.f
#define kSCALE(value)  value * UI_SCALE
#define kFont(fontSize) [UIFont systemFontOfSize:fontSize]

@interface SearchCollectionCell ()



@end

@implementation SearchCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleBtn = [[UIButton alloc] init];
        self.titleBtn.userInteractionEnabled = NO;
        self.titleBtn.titleLabel.font = kFont(kSCALE(42.0));
        [self.titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleBtn.backgroundColor = [UIColor cz_colorWithHex:0xf6f6f6];
        self.titleBtn.clipsToBounds = YES;
        self.titleBtn.layer.cornerRadius = kSCALE(84.0)/2.0;
        [self.contentView addSubview:self.titleBtn];
        
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
}



@end
