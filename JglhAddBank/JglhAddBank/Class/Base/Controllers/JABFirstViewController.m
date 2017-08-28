//
//  JABFirstViewController.m
//  JglhAddBank
//
//  Created by jgrm on 2017/8/28.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "JABFirstViewController.h"
#import "JABAddBankViewController.h"
#import "JABDataViewController.h"

#define kFirstCellId @"kFirstCellId"

@interface JABFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation JABFirstViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAllDatas];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Private Methods
-(void)initAllDatas {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFirstCellId];
    self.dataArray =[@[@"添加银行卡",@"数据统计"] mutableCopy];
}
#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kFirstCellId forIndexPath:indexPath];
    if (cell) {
        if (self.dataArray.count) {
            cell.textLabel.text =self.dataArray[indexPath.row];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
            if (YES) {
                JABAddBankViewController *addBankVC =[[JABAddBankViewController alloc]init];
                [self.navigationController pushViewController:addBankVC animated:YES];
            }
            
            break;
        case 1:
            if (YES) {
                JABDataViewController *dataStatisticsVC =[[JABDataViewController alloc]init];
                [self.navigationController pushViewController:dataStatisticsVC animated:YES];
            }
            
            break;
        default:
            break;
    }
}
#pragma mark - Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}

@end
