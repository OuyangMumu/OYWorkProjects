//
//  ViewController.m
//  my_ios
//
//  Created by ouyanggaojun on 2020/5/16.
//  Copyright © 2020 ouyanggaojun. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import <flutter_boost/FlutterBoostPlugin.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)toFlutter:(UIButton *)sender {
    [FlutterBoostPlugin open:@"NativePushFlutter" urlParams:@{kPageCallBackId : @"MycallbackId#1",@"title" : @"toNative"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
}


- (IBAction)toFlutterParams:(UIButton *)sender {
    [FlutterBoostPlugin present:@"NativePresentFlutter" urlParams:@{kPageCallBackId : @"MycallbackId#1",@"title" : @"toNative"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary * _Nonnull result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
}
- (IBAction)toNative:(UIButton *)sender {
    [FlutterBoostPlugin open:@"Native//EmbedViewController" urlParams:@{kPageCallBackId : @"MycallbackId#1",@"className" : @"EmbedViewController"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary * _Nonnull result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
}
- (IBAction)toNativeParams:(UIButton *)sender {
   
}

@end
