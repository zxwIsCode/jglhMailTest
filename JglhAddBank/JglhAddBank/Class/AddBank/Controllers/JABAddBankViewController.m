//
//  JABAddBankViewController.m
//  JglhAddBank
//
//  Created by jgrm on 2017/8/27.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "JABAddBankViewController.h"
#import "JABAddBankSelectedView.h"
#import "JABAddBankModel.h"


@interface JABAddBankViewController ()
@property(nonatomic,strong)UIButton *addButton;

@property(nonatomic,strong)JABAddBankSelectedView *selectedTableView;

@property(nonatomic,strong)NSMutableArray *bankArr;

// 背景的灰色View
@property(nonatomic,strong)UIView *backgroundView;
// 临时记录点中的cell，可以在合适的时候再显示cell选中
@property(nonatomic,assign)NSInteger selectedIndex;



@end

@implementation JABAddBankViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    // 默认选中的银行
//    self.selectedTableView.indexKind =0;
    // 默认不选中任何银行
    self.selectedTableView.indexKind = -1;
    self.selectedIndex =-1;
    
    [self initAllPayKindDatas];
    WS(ws);
    self.selectedTableView.addBankBlock =^(NSInteger index) {
        ws.selectedIndex =index;
        [ws closeAddBank:nil];
        
    };
    
    UITapGestureRecognizer *gesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAddBank:)];
    [self.backgroundView addGestureRecognizer:gesture];
    
    self.addButton.center =CGPointMake(SCREEN_WIDTH *0.5,SCREEN_HEIGHT *0.5);
    self.addButton.bounds =CGRectMake(0, 0, 100, 100);
    [self.view addSubview:self.addButton];
    
}

-(void)initAllPayKindDatas {
    // 假数据处理
    NSArray *kindStrArr =@[@"中国工商银行",@"中国农业银行",@"中国建设银行",@"中国邮政银行",@"中国招商银行"];
    for (int index =0; index <5; index ++) {
        JABAddBankModel *payModel =[[JABAddBankModel alloc]init];
        payModel.payKindStr =kindStrArr[index];
        // 默认选中第一个
//        if (index ==0) {
//            payModel.isSelected =YES;
//        }else {
//            payModel.isSelected =NO;
//
//        }
        // 默认不选
        payModel.isSelected =NO;
        
        [self.bankArr addObject:payModel];
    }
    // 传值
    self.selectedTableView.bankArr =self.bankArr;
    
}
// 显示动画开始的所有控件frame为0
-(void)startSelectedTableFrame {
    _selectedTableView.center =CGPointMake(SCREEN_WIDTH *0.5, 320 *kAppScale);
    _selectedTableView.bounds =CGRectMake(0, 0, 0, 0);
    [self animationSubViewsToZero];
}
// 显示动画结束后selectedTableView的frame为正常布局
-(void)endSelectedTableFrame {
    _selectedTableView.center =CGPointMake(SCREEN_WIDTH *0.5, 320 *kAppScale);
    _selectedTableView.bounds =CGRectMake(0, 0, SCREEN_WIDTH *0.7, 310*kAppScale);
    
}
// 显示动画完成后selectedTableView的子View的frame为正常布局
-(void)animationFinishLayoutSubViews {
    _selectedTableView.bankTitleLable.frame =CGRectMake(0, 0, CGRectGetWidth(_selectedTableView.frame), 60 *kAppScale);
    CGFloat bankTitleLableMaxY =CGRectGetMaxY(_selectedTableView.bankTitleLable.frame);
    _selectedTableView.tableView.frame =CGRectMake(0, bankTitleLableMaxY, CGRectGetWidth(_selectedTableView.frame), 200 *kAppScale );
}
// 关闭动画完成后selectedTableView的子View的frame为0
-(void)animationSubViewsToZero {
    _selectedTableView.bankTitleLable.frame =CGRectZero;
    CGFloat bankTitleLableMaxY =CGRectGetMaxY(_selectedTableView.bankTitleLable.frame);
    _selectedTableView.tableView.frame =CGRectMake(0, bankTitleLableMaxY, 0, 0);
}
#pragma mark - Action Methods
-(void)addButtonClick:(UIButton *)button {
    [self.view.window addSubview:self.backgroundView];
    [self.view.window addSubview:self.selectedTableView];
    
    self.selectedTableView.indexKind = -1;
    self.selectedIndex =-1;
    
    WS(ws);
    [self startSelectedTableFrame];
    [UIView animateWithDuration:0.2 animations:^{
        [ws endSelectedTableFrame];
        
    } completion:^(BOOL finished) {
        [ws animationFinishLayoutSubViews];
        // 打开后弹簧的效果
        [UIView animateWithDuration:0.05 animations:^{
          __block  CATransform3D trans = CATransform3DMakeScale(1.1, 1.1, 1);
            ws.selectedTableView.layer.transform =trans;
        } completion:^(BOOL finished) {
            ws.selectedTableView.layer.transform =CATransform3DIdentity;
            
        }];
    }];
    
}
-(void)closeAddBank:(UITapGestureRecognizer *)gesture {
    
    
    // 1.记录点击的银行
    if (self.selectedTableView.bankArr.count >self.selectedTableView.indexKind) {
        JABAddBankModel *model = self.selectedTableView.bankArr[self.selectedTableView.indexKind];
        DDLog(@"您点击了%@",model.payKindStr);
        
    }
    //
    // 2.传递选中的状态给界面刷新
    self.selectedTableView.indexKind = self.selectedIndex;
    
    // 3.动画
    WS(ws);
    // 选中的状态需要定时一会展示给用户之后通过动画关闭
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [ws animationFinishLayoutSubViews];
        [ws animationSubViewsToZero];
        
        [UIView animateWithDuration:0.1 animations:^{
            [ws startSelectedTableFrame];
        } completion:^(BOOL finished) {
            
            // 4.动画结束后清除当前的View
            [_selectedTableView removeFromSuperview];
            [_backgroundView removeFromSuperview];
            
        }];
        
    });
    
}

#pragma mark - Setter & Getter
-(NSMutableArray *)bankArr {
    if (!_bankArr) {
        _bankArr =[NSMutableArray array];
    }
    return _bankArr;
}
-(UIButton *)addButton {
    if (!_addButton) {
        _addButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"添加" forState:UIControlStateNormal];
        _addButton.backgroundColor =[UIColor redColor];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addButton;
}

-(JABAddBankSelectedView *)selectedTableView {
    if (!_selectedTableView) {
        // 1.初始化自定义控件
        _selectedTableView =[JABAddBankSelectedView SelectedTableView];
        
        _selectedTableView.layer.cornerRadius = 10 *kAppScale;
        _selectedTableView.layer.masksToBounds =YES;
        
        // 2.以下为设置selectedTableView的子View的相关属性
        _selectedTableView.bankTitleLable.text =@"开户行";
        _selectedTableView.bankTitleLable.font =[UIFont systemFontOfSize:18 *kAppScale];
        _selectedTableView.bankTitleLable.textAlignment =NSTextAlignmentCenter;
        
        // 3.添加测试颜色
        _selectedTableView.backgroundColor =[UIColor whiteColor];
//        _selectedTableView.bankTitleLable.backgroundColor =[UIColor blueColor];
//        _selectedTableView.tableView.backgroundColor =[UIColor orangeColor];
    }
    return _selectedTableView;
}

-(UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView =[[UIView alloc]init];
        _backgroundView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _backgroundView.backgroundColor =[UIColor blackColor];
        _backgroundView.alpha =0.5;
        _backgroundView.userInteractionEnabled =YES;
    }
    return _backgroundView;
}

@end
