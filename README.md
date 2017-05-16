# ListDropMenu
一款可自定义的DropDownMenuView

使用方法:
-(void)initTopDropDownMenuView{

    DropDownMenuConfig *config = [[DropDownMenuConfig alloc] init];
    config.titles = @[@"全部",@"最新发布",@"拍卖中"];
    config.titleNormalColor = [UIColor blackColor];
    config.titleSelectedColor = [UIColor redColor];
    config.titleFont = [UIFont systemFontOfSize:14.0];
    config.imageNormalName = @"ic_pull_down";
    config.imageSelectedName = @"ic_pull_up";
    config.isShowVerLine = YES;
    config.isShowBottomLine = YES;
    
    
    ///可自定义自己的选项视图  然后在DropDownView的dropDownMenuBtnAction:方法中获取对应的视图修改高度,回调等操作即可
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        
        if (i == 0){
            SigleCollectionItemView *listView = [[SigleCollectionItemView alloc] initWithFrame:CGRectMake(0, 108, kWidth, 0)];
            listView.tagsArr = @[@"全部",@"数码办公",@"家具用品",@"母婴用品",@"健康养生",@"户外休闲",@"尊享区"];
            [arr addObject:listView];
            
        }else if (i == 1){
            SigleTableListView *listView = [[SigleTableListView alloc] initWithFrame:CGRectMake(0, 108, kWidth, 0)];
            listView.dataArr = @[@"最新发布",@"价格从高到低",@"价格从低到高",@"出价次数由高到低"];
            [arr addObject:listView];
            
        }else if (i == 2) {
            SigleTableListView *listView = [[SigleTableListView alloc] initWithFrame:CGRectMake(0, 108, kWidth, 0)];
            listView.dataArr = @[@"拍卖中",@"即将拍卖",@"拍卖结束"];
            [arr addObject:listView];
            
        }
    }
    
    
    DropDownView *downView = [[DropDownView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 44.0) config:config];
    downView.backgroundColor = [UIColor whiteColor];
    downView.itemViews = arr;
    
    downView.didSelectedItemBlock = ^(DropDownView *UIView, NSString *title, NSInteger row, NSInteger tag) {
        NSLog(@"---- btnTag = %ld, row = %ld", tag , row);
    };
    
    [self.view addSubview:downView];

    
}


