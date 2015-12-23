//
//  ViewController.m
//  MNAlertView
//
//  Created by mnn on 15/12/14.
//  Copyright © 2015年 mnn. All rights reserved.
//

#import "ViewController.h"
#import "MNAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testButton];
}

- (void)testButton{
    UIButton *test =[UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(MN_WIDTH/3, MN_HEIGHT/3, MN_WIDTH/3, 40);
    [test setTitle:@"自定义Alert" forState:UIControlStateNormal];
    test.backgroundColor =[UIColor redColor];
    [test addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}


// 调用MNAlert方法实现自定义Alert
- (void) buttonclick {
    AlertViewBlock block  = ^(NSInteger index) {
        if (index == 1) {
            NSLog(@"取消");
            MNAlert *alert = [[MNAlert alloc]init];
            [alert closeView];
        }else if (index == 2){
            NSLog(@"确定");
            self.view.backgroundColor = [UIColor blueColor];
        }
    }; 
    MNAlert *alterView = [[MNAlert alloc]initWithTitle:@"测试" message:@"这只是一个测试" buttonTitles:@"取消" andEnter:@"确定" clickButton:block];
    [alterView showWithCompletion:^(MNAlert *alertView, NSInteger selectIndex) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
