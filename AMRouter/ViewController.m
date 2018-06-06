//
//  ViewController.m
//  AMRouter
//
//  Created by archmagees on 2018/06/06.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "ViewController.h"
#import "AMComponent+Message.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    BOOL enabled =
    [[AMComponent message] notificationEnabled];
    
    NSLog(@"is notification enabled: %@", enabled ? @"yes" : @"no");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end