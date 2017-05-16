//
//  SigleCollectionItemView.m
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "SigleCollectionItemView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SearchCollectionCell.h"
#import <Masonry.h>
#import "UIColor+YGExtension.m"

#define UI_SCALE  [UIScreen mainScreen].bounds.size.width/1080.f
#define kSCALE(value)  value * UI_SCALE
#define kFont(fontSize) [UIFont systemFontOfSize:fontSize]

@interface SigleCollectionItemView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property  (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIButton *curSelectedBtn;




@end

@implementation SigleCollectionItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setTagsArr:(NSArray *)tagsArr{
    _tagsArr = tagsArr;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = kSCALE(30.0);
        layout.minimumInteritemSpacing = kSCALE(20.0);
        layout.sectionInset = UIEdgeInsetsMake(kSCALE(20.0), kSCALE(40.0), kSCALE(100.0), kSCALE(40.0));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        [_collectionView registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:@"SearchCollectionCell"];
        
        
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
    }
    return _collectionView;
}

#pragma mark --- 需要重写的方法就重写
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagsArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionCell" forIndexPath:indexPath];
    cell.isDropMenu = YES;
    
    cell.title = self.tagsArr[indexPath.row];
    
    if (!self.curSelectedBtn && self.defaultCateName && [cell.titleBtn.currentTitle isEqualToString:self.defaultCateName]) {
        cell.titleBtn.selected = YES;
        cell.titleBtn.backgroundColor = [UIColor cz_colorWithHex:0xffe2d9];
        self.curSelectedBtn = cell.titleBtn;
    }
    
    if (!self.defaultCateName) {
        if (indexPath.item == 0 && self.curSelectedBtn == nil) {
            cell.titleBtn.selected = YES;
            cell.titleBtn.backgroundColor = [UIColor cz_colorWithHex:0xffe2d9];
            self.curSelectedBtn = cell.titleBtn;
        }
    }
    
    return cell;
}

#pragma mark --- CHTCollectionViewDelegateWaterfallLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.tagsArr[indexPath.row];
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName : kFont(kSCALE(42.0))}].width;
    
    return CGSizeMake(width + kSCALE(80.0), kSCALE(86.0));
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cateName = self.tagsArr[indexPath.row];
    self.defaultCateName = cateName;
    
    SearchCollectionCell *cell = (SearchCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.curSelectedBtn.selected = NO;
    self.curSelectedBtn.backgroundColor = [UIColor cz_colorWithHex:0xf6f6f6];
    
    cell.titleBtn.selected = YES;
    cell.titleBtn.backgroundColor = [UIColor cz_colorWithHex:0xffe2d9];
    self.curSelectedBtn = cell.titleBtn;
   
    
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(cateName, indexPath.item);
    }
    
}


@end
