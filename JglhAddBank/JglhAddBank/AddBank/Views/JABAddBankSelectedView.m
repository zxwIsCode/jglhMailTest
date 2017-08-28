//
//  FAPayKindSelectedView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/21.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "JABAddBankSelectedView.h"
#import "JABAddBankTableCell.h"

@implementation JABAddBankSelectedView

#pragma mark - Init
+(instancetype)SelectedTableView {
    
    return [[self alloc]init];
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.bankTitleLable];
        [self addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark - Private Methods

-(void)cancleAllSelected {
    NSMutableArray *payOriginalArr =self.bankArr;
    for (JABAddBankModel *model in payOriginalArr) {
        model.isSelected =NO;
    }
    self.bankArr =payOriginalArr;
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JABAddBankTableCell *cell =[JABAddBankTableCell updateWithTableView:tableView];
    if (cell) {
        if (self.bankArr.count) {
            JABAddBankModel *model =self.bankArr[indexPath.row];
            if (indexPath.row ==_indexKind) { // 如果当前初始化的cell的下标与处于选择状态的一致，则界面必定处于选择状态
                model.isSelected =YES;
            }else {
                model.isSelected =NO;
            }
            cell.model =model;
            
        }
        
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 *kAppScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.bankArr.count) {        
        // 所有的取消选择状态
        [self cancleAllSelected];
        
        // 确定点击的是哪一个
        self.indexKind =indexPath.row;
        
        if (self.addBankBlock) {
            self.addBankBlock(_indexKind);
        }
    }
}


#pragma mark - Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}


-(void)setIndexKind:(NSInteger)indexKind {
    _indexKind =indexKind;
    [self.tableView reloadData];
    
}

-(UILabel *)bankTitleLable {
    if (!_bankTitleLable) {
        _bankTitleLable =[[UILabel alloc]init];
        _bankTitleLable.backgroundColor =[UIColor whiteColor];
    }
    return _bankTitleLable;
}




@end
