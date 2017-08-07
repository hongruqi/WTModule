//
//  WTViewController.m
//  WTModule
//
//  Created by lbrsilva-allin on 08/07/2017.
//  Copyright (c) 2017 lbrsilva-allin. All rights reserved.
//

#import "WTViewController.h"
#import "WTBXXViewController.h"

@interface WTViewController ()

@end

@implementation WTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    WTBXXViewController  *VC = [[WTBXXViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
