//
//  SigleTableListView.m
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "SigleTableListView.h"
#import <Masonry.h>

@interface SigleTableListView ()<UITableViewDelegate,UITableViewDataSource>

@property  (nonatomic,strong) UITableView *tableView;

@property (nonatomic) NSInteger selectedRow;

@end

@implementation SigleTableListView

-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.row == _selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = [UIColor orangeColor];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedRow = indexPath.row;
    [tableView reloadData];
    NSString *title = _dataArr[indexPath.row];
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(title, indexPath.row);
    }
    
}

@end
