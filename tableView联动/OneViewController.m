//
//  OneViewController.m
//  tableView联动
//
//  Created by Hongpeng Yu on 2016/11/20.
//  Copyright © 2016年 Hongpeng Yu. All rights reserved.
//

#import "OneViewController.h"
#import "ViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushBtnDidClick:(id)sender {
    
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)appliedFlowBtnDidClick:(id)sender {
    TwoViewController *tewVc = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:tewVc animated:YES];
}



@end
