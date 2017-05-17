//
//  ViewController.m
//  FMPageRouter
//
//  Created by Fantasy on 2017/4/28.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+FMRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *tButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tButton setTitle:@"test" forState:UIControlStateNormal];
    [tButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [tButton setFrame:CGRectMake(30.f, 100.f, 100.f, 50.f)];
    [tButton addTarget:self action:@selector(toSecondPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) toSecondPage:(id)page {
    [self routerWithURLString:[[FMPageRouter shareInstance] appPathWithRelativePath:@"api/second/testpage?id=09fac3d22adf&name=test"]];
}

@end
