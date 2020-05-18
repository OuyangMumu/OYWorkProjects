//
//  AppDelegate.m
//  my_ios
//
//  Created by ouyanggaojun on 2020/5/16.
//  Copyright © 2020 ouyanggaojun. All rights reserved.
//

#import "AppDelegate.h"
#import "PlatformRouterImp.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PlatformRouterImp *router = [PlatformRouterImp new];
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router onStart:^(FlutterEngine *engine) { }];
    
    
    //1
    ViewController *vc = [[ViewController alloc] init];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"hybrid" image:nil tag:0];
    //2
    FLBFlutterViewContainer *fvc = FLBFlutterViewContainer.new;
    [fvc setName:@"tab" params:@{}];
    fvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"flutter_tab" image:nil tag:1];

    //TabBarController
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[vc,fvc];
    
    //NavigationController
    UINavigationController *rvc = [[UINavigationController alloc] initWithRootViewController:tabVC];
    router.navigationController = rvc;
    
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = rvc;
    
    return YES;
}


@end
