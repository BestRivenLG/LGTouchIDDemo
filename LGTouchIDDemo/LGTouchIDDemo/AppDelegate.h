//
//  AppDelegate.h
//  LGTouchIDDemo
//
//  Created by Marvin on 2017/6/12.
//  Copyright © 2017年 Marvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SecondViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) ViewController *vc;
@property (strong, nonatomic) SecondViewController *svc;

@end

