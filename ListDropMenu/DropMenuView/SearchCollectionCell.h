//
//  SearchCollectionCell.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/17.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCollectionCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;
@property  (nonatomic,strong) UIButton *titleBtn;

///是否是全部拍卖下来菜单用的cell
@property (nonatomic) BOOL isDropMenu;

@end
