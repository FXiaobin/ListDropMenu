//
//  SigleTableListView.h
//  ListDropMenu
//
//  Created by fanxiaobin on 2017/5/12.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigleTableListView : UIView

@property  (nonatomic,strong) NSArray *dataArr;

///row
@property (nonatomic,copy) void (^didSelectRowAtIndexPathBlock) (NSString *title,NSInteger row);

@end
