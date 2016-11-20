//
//  LeftCell.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/19.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "LeftCell.h"
#import "Model.h"

@interface LeftCell ()

@property (weak,   nonatomic) UIView *identification;

@end

@implementation LeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setUpUI {
    self.backgroundColor = [UIColor purpleColor];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.highlightedTextColor = [UIColor redColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectedBackgroundView = [[UIView alloc] init];
    
    CGRect frame = CGRectMake(2, (44 - 10) * 0.5, 10, 10);
    UIView *identification = [[UIView alloc] initWithFrame:frame];
    [self addSubview:identification];
    self.identification = identification;
    [identification setBackgroundColor: [UIColor greenColor]];
    identification.layer.cornerRadius = 5;
    identification.layer.masksToBounds = YES;
    identification.hidden = YES;
}

// 设置子控件的frame

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    // 设置图片的大小
//    CGRect frame = self.imageView.frame;
//    frame.size.width = 30;
//    frame.size.height = 30;
}

- (void)setLefModel:(Model *)lefModel {
    _lefModel = lefModel;
    self.textLabel.text = [NSString stringWithFormat:@"%@(%ld)", lefModel.name, lefModel.size];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.identification.hidden = selected ? NO : YES;
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
    NSLog(@"selected  = %@", _lefModel.name);
}

@end
