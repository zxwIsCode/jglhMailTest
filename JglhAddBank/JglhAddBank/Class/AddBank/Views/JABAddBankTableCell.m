//
//  FAPayKindTableCell.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "JABAddBankTableCell.h"

@interface JABAddBankTableCell ()

@property(nonatomic,strong)UIImageView *bankImage;

@property(nonatomic,strong)UILabel *lable;

@property(nonatomic,strong)UIImageView *selectedImage;


@end

@implementation JABAddBankTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)updateWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"JABAddBankTableCellId";
    JABAddBankTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JABAddBankTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.初始化
        self.bankImage =[[UIImageView alloc]init];
        self.lable =[[UILabel alloc]init];
        self.selectedImage =[[UIImageView alloc]init];
        
        // 2.设置frame
        CGFloat selfH =50 *kAppScale;
        CGFloat selfW =SCREEN_WIDTH *0.7;
        CGFloat bankImageWH =20 *kAppScale;
        CGFloat cellItemSpacing =10 *kAppScale;
        self.bankImage.center =CGPointMake(40 *kAppScale, selfH *0.5);
        self.bankImage.bounds =CGRectMake(0, 0, bankImageWH, bankImageWH);
        
        self.lable.frame =CGRectMake(CGRectGetMaxX(self.bankImage.frame) +cellItemSpacing, 0, 100 *kAppScale, selfH);
        CGFloat selectedBtnWH =selfH -24 *kAppScale;
        
        self.selectedImage.frame = CGRectMake(selfW -selectedBtnWH -20 *kAppScale, 12 *kAppScale, selectedBtnWH, selectedBtnWH);
        
        
        // 属性设置
        self.selectedImage.image =[UIImage imageNamed:@"icon_xuanzhongx"];
        self.lable.font =[UIFont systemFontOfSize:15 *kAppScale];

        // 测试颜色
        self.bankImage.backgroundColor =[UIColor redColor];
//        self.lable.backgroundColor =[UIColor blueColor];
//        self.selectedImage.backgroundColor =[UIColor orangeColor];
        
        // 添加到父View
        [self.contentView addSubview:self.bankImage];
        [self.contentView addSubview:self.lable];
        [self.contentView addSubview:self.selectedImage];
    }
    return self;
}
-(void)setModel:(JABAddBankModel *)model {
    _model =model;
//    self.bankImage.backgroundColor =[UIColor yellowColor];
    self.lable.text =model.payKindStr;
    if (model.isSelected) {
        self.selectedImage.image =[UIImage imageNamed:@"icon_xuanzhongbx"];
    }else {
        self.selectedImage.image =[UIImage imageNamed:@"icon_xuanzhongx"];
    }
}




@end
