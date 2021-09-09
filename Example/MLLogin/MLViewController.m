//
//  MLViewController.m
//  MLLogin
//
//  Created by git on 09/08/2021.
//  Copyright (c) 2021 git. All rights reserved.
//

#import "MLViewController.h"
#import "MLoginSDK.h"

@interface MLViewController ()<MLLoginDalegate>

@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"点击屏幕启动登陆SDK";
    lb.frame = CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 60);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:lb];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MLoginSDK *vc = [[MLoginSDK alloc] initWithGame:@"SK-APP-001" encryptKey:@"#MRT-@KK?8425$F1Q" config:nil];
    vc.delegate = self;
    MLLoginConfig *a = [[MLLoginConfig alloc] init];
    a.needAutoLogin = NO;
    vc.loginConfig = a;
//    [vc clearAccout];
    [vc show: self];
    
    NSLog(@" - %@ -%@ -  %@ - %@", [MLLoginSDKInfo share].account, [MLLoginSDKInfo share].password, [MLLoginSDKInfo share].gameId, [MLLoginSDKInfo share].gusetGameId);

}

- (void)callBackApiUrl:(MLApiUrlType)apiUrlType status:(NSString *)status result:(id)result error:(NSError *)error {
    NSLog(@"%ld-- %@-- %@", (unsigned long)apiUrlType, status, result);
}

@end
