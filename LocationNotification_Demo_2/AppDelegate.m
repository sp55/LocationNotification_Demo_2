//
//  AppDelegate.m
//  LocationNotification_Demo_2
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //打开app时候,消除掉badge
    [application setApplicationIconBadgeNumber:0];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // iOS8以后 本地通知必须注册(获取权限)
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        
        [application registerUserNotificationSettings:settings];
    }
   
    
    // 页面跳转(针对应用程序被杀死的页面跳转)
    /* launchOptions: 1.点击图标打开是空的
     2.应用间跳转是有值的
     3.杀死的应用接收到本地通知,也是有值的
     虽然说launchOptions有值,但是他们不同的key有值
     
     */
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 如果这个key有值,代表是杀死的程序接收到本地通知跳转
        
        // 根据这种方式查看launchOptions的内容
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.frame = CGRectMake(0, 0, 300, 300);
        infoLabel.backgroundColor = [UIColor yellowColor];
        infoLabel.numberOfLines = 0;
        infoLabel.font = [UIFont systemFontOfSize:10];
        infoLabel.text = [NSString stringWithFormat:@"%@",launchOptions];
        [self.window.rootViewController.view addSubview:infoLabel];
        
        
        NSLog(@"跳转到指定页面");
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"收到本地通知");
    // 可以让用户跳转到指定界面 app在前台接收到通知直接跳转界面不太好,所以要判断一下,是从后台进入前台还是本身就在前台
    if (application.applicationState == UIApplicationStateInactive) {// 进入前台时候
        NSLog(@"跳转到指定界面");
        
        // 如果接收到不同的通知,跳转到不同的界面:
        NSLog(@"%@", notification.userInfo); //通知的额外信息,根据设置的通知的额外信息确定
        
    }
}



@end
