//
//  ViewController.m
//  CCLActivityIndicatorView
//
//  Created by chen on 15/12/23.
//  Copyright © 2015年 chen. All rights reserved.
//

#import "ViewController.h"
#import "CCLActivityView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * view = [[CCLActivityView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
