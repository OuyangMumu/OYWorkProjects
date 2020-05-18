//
//  EmbedViewController.m
//  my_ios
//
//  Created by ouyanggaojun on 2020/5/16.
//  Copyright © 2020 ouyanggaojun. All rights reserved.
//

#import "EmbedViewController.h"
#import <Flutter/Flutter.h>
#import <flutter_boost/FlutterBoost.h>

@interface EmbedViewController ()

@property(nonatomic, strong)FLBFlutterViewContainer *flutterContainer;

@end

@implementation EmbedViewController

- (instancetype)init{
    if (self = [super init]) {
        _flutterContainer = [[FLBFlutterViewContainer alloc]init];
        [_flutterContainer setName:@"embededPage" params:@{}];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.flutterContainer.view.frame = CGRectInset(self.view.bounds, 30, 100);
    [self.view addSubview:self.flutterContainer.view];
    [self addChildViewController:self.flutterContainer];
    
    UIButton *nativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nativeButton.frame = CGRectMake(50,self.view.bounds.size.height-50,200,40);
    nativeButton.backgroundColor = [UIColor blueColor];
    [nativeButton setTitle:@"push in Native" forState:UIControlStateNormal];
    [nativeButton addTarget:self action:@selector(pushMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nativeButton];
}

- (void)pushMe
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //注意这行代码不可缺少
//    [self.flutterContainer.view setNeedsLayout];
//    [self.flutterContainer.view layoutIfNeeded];
}

//NOTES: embed情景下必须实现！！！
- (void)didMoveToParentViewController:(UIViewController *)parent {
    [self.flutterContainer didMoveToParentViewController:parent];
    [super didMoveToParentViewController:parent];
}

- (void)dealloc{
    NSLog(@"dealloc embedcontroller%p", self.flutterContainer);
}

@end
