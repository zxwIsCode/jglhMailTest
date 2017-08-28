//
//  FAPayKindTableCell.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JABAddBankModel.h"


@interface JABAddBankTableCell : UITableViewCell

+(instancetype)updateWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)JABAddBankModel *model;

@end
