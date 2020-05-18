//
//  DemoRouter.m
//  Runner
//
//  Created by Jidong Chen on 2018/10/22.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "PlatformRouterImp.h"
#import <flutter_boost/FlutterBoost.h>

@interface PlatformRouterImp()
@end

@implementation PlatformRouterImp

- (void)openNativeVC:(NSString *)className
           urlParams:(NSDictionary *)params
                exts:(NSDictionary *)exts {
    if (className.length <= 0) {
        className = @"UIViewController";
    }
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    if (![vc isKindOfClass:[UIViewController class]]) {
        return;
    }
    vc.view.backgroundColor = [UIColor redColor];
    BOOL animated = [exts[@"animated"] boolValue];
    if([params[@"present"] boolValue]){
        [self.navigationController presentViewController:vc animated:animated completion:^{
        }];
    }else{
        [self.navigationController pushViewController:vc animated:animated];
    }
}

#pragma mark - Boost 1.5
- (void)open:(NSString *)name
   urlParams:(NSDictionary *)params
        exts:(NSDictionary *)exts
  completion:(void (^)(BOOL))completion {
    if ([name hasPrefix:@"Native//"]) {
        NSString *className = [name substringFromIndex:8];
        NSMutableDictionary *newParams = params.mutableCopy;
        newParams[@"present"] = @(NO);
        //模拟打开native页面
        [self openNativeVC:className urlParams:newParams exts:exts];
        return;
    } else {
        BOOL animated = [exts[@"animated"] boolValue];
        FLBFlutterViewContainer *vc = FLBFlutterViewContainer.new;
        [vc setName:name params:params];
        [self.navigationController pushViewController:vc animated:animated];
        if(completion) completion(YES);
    }
}

- (void)present:(NSString *)name
   urlParams:(NSDictionary *)params
        exts:(NSDictionary *)exts
     completion:(void (^)(BOOL))completion {
    
    if ([name hasPrefix:@"Native//"]) {
        NSString *className = [name substringFromIndex:8];
        NSMutableDictionary *newParams = params.mutableCopy;
        newParams[@"present"] = @(YES);
        //模拟打开native页面
        [self openNativeVC:className urlParams:newParams exts:exts];
        return;
    } else {
        BOOL animated = [exts[@"animated"] boolValue];
        FLBFlutterViewContainer *vc = FLBFlutterViewContainer.new;
        [vc setName:name params:params];
        [self.navigationController presentViewController:vc animated:animated completion:^{
            if(completion) completion(YES);
        }];
    }
}

- (void)close:(NSString *)uid
       result:(NSDictionary *)result
         exts:(NSDictionary *)exts
   completion:(void (^)(BOOL))completion {
    BOOL animated = [exts[@"animated"] boolValue];
    animated = YES;
    FLBFlutterViewContainer *vc = (id)self.navigationController.presentedViewController;
    if([vc isKindOfClass:FLBFlutterViewContainer.class] && [vc.uniqueIDString isEqual: uid]){
        [vc dismissViewControllerAnimated:animated completion:^{}];
    }else{
        [self.navigationController popViewControllerAnimated:animated];
    }
}


@end
