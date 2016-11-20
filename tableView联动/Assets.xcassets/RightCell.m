//
//  RightCell.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "RightCell.h"
#import "Model1.h"


@implementation RightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    self.backgroundColor = [UIColor greenColor];
    self.textLabel.textColor = [UIColor blackColor];
}


- (void)setInfoModel:(Model1 *)infoModel {
    _infoModel = infoModel;
    self.textLabel.text = self.infoModel.name;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTextLabel.text = self.infoModel.category;
    self.detailTextLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
