//
//  ViewController.m
//  LGTouchIDDemo
//
//  Created by Marvin on 2017/6/12.
//  Copyright © 2017年 Marvin. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)checkTouchID {
    
    //2. LAContext : 本地验证对象上下文
    LAContext *context = [LAContext new];
    
    //3. 判断是否可用
    //Evaluate: 评估  Policy: 策略,方针
    //LAPolicyDeviceOwnerAuthenticationWithBiometrics: 允许设备拥有者使用生物识别技术
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        NSLog(@"对不起, 指纹识别技术暂时不可用");
 
    }
    
    //4. 开始使用指纹识别
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"开启了指纹识别, 将打开隐藏功能" reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            NSLog(@"指纹识别成功");
            // 指纹识别成功，回主线程更新UI,弹出提示框
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"指纹识别成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            });
        }
        
        if (error) {
            
            // 错误的判断chuli
            
            if (error.code == -2) {
                NSLog(@"用户取消了操作");
                
                // 取消操作，回主线程更新UI,弹出提示框
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户取消了操作" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertView show];
                    
                });
                
            }else if (error.code == -3){//点输入密码按钮
                NSLog(@"点输入密码按钮");
            }else if (error.code == -1){//连续三次指纹识别错误
                NSLog(@"连续三次指纹识别错误");
            }else if (error.code == -4){//按下电源键
                NSLog(@"按下电源键");
            }else if (error.code == -8){//Touch ID功能被锁定，下一次需要输入系统密码
                NSLog(@"Touch ID功能被锁定，下一次需要输入系统密码");
            }
            
        }
        
        
    }];

}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    //苹果从iPhone5S开始,具有指纹识别技术。但是，是从iOS8.0之后程序员具有使用指纹识别的权利——苹果允许第三方 App 使用 Touch ID 实现免密码登陆。
    //1. 判断系统版本
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        [self checkTouchID];
   
    }else {
         NSLog(@"对不起, 该手机不支持指纹识别");
    }
    
    
}

@end
