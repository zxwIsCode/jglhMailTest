//
//  FAPayKindSelectedView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/21.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JABAddBankModel.h"

typedef void(^AddBankSelectedViewBlock)(NSInteger index);

@interface JABAddBankSelectedView : UIView<UITableViewDelegate,UITableViewDataSource>

// frame需要外界设置
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *bankArr;

// 那个平台是选中状态
@property(nonatomic,assign)NSInteger indexKind;

// 选择配送方式的Lable(配送专用)，frame需要外界设置
@property(nonatomic,strong)UILabel *bankTitleLable;

@property(nonatomic,copy)AddBankSelectedViewBlock addBankBlock;

+(instancetype)SelectedTableView;

// 取消所有的选中状态
-(void)cancleAllSelected;
@end
