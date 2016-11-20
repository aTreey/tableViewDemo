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
//    self.backgroundColor = [UIColor greenColor];
    self.textLabel.textColor = [UIColor blackColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)setInfoModel:(Model1 *)infoModel {
    _infoModel = infoModel;
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.text = [NSString stringWithFormat:@"%@:%ld:%ld", self.infoModel.name, self.infoModel.fversion, self.infoModel.formId];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTextLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
