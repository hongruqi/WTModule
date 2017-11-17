//
//  WTBXXViewController.m
//  WTModule
//
//  Created by walter on 07/08/2017.
//  Copyright © 2017 lbrsilva-allin. All rights reserved.
//

#import "WTBXXViewController.h"
#import "WTModule.h"
#import "WTEventBus.h"
#import "WTEventItem.h"

@interface WTBXXViewController ()

@end

@implementation WTBXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"XYFollowedViewController";
    //    BOOL flag = [XYModuleService call:@"liveShow/liveShowStart" withParams:@{}];
    BOOL flag = [WTModuleMessager performAPI:@"AXX" methodName:@"liveShowEnd" withParams:@{@"username":@"username"} block:^(id result, NSError *error) {
        NSLog(@"I am a block");
        
        NSLog(@"aa");
        WTEventItem *item = [[WTEventItem alloc] initWithTopic:@"loginSuccessed"];
        [item setParam:@"userName" forKey:@"userName"];
        [[WTEventBus defaultBus] postEvent:item];
    }];
    if (flag) {
        NSLog(@"flag = %d", flag);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
