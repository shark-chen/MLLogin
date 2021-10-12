//
//  MLViewController.m
//  MLLogin
//
//  Created by git on 09/08/2021.
//  Copyright (c) 2021 git. All rights reserved.
//

#import "MLViewController.h"
#import "MLoginSDK.h"
#import <SafariServices/SafariServices.h>

@interface MLViewController ()<MLLoginDalegate>

@property (strong, nonatomic) UILabel *lb;

@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lb = [[UILabel alloc] init];
    _lb.text = @"点击屏幕启动登陆SDK";
        
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    _lb.frame = CGRectMake(0, height * 0.4 , width, 60);
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_lb];
     
    
    [self adddNotification];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)adddNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    _lb.frame = CGRectMake(0, height * 0.4 , width, 60);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    MLLoginConfig *a = [[MLLoginConfig alloc] init];
//    a.needAutoLogin = YES;
    a.gooleClientID = @"748197369663-mtcr8e00arei2bogdnofsoabdbsi86k2.apps.googleusercontent.com";

    MLoginSDK *vc = [[MLoginSDK alloc] initWithGame:@"SK-APP-001" encryptKey:@"#MRT-@KK?8425$F1Q" config:a];
    vc.delegate = self;

//    [vc clearAccout];
    [vc showTo: self];
    
    NSLog(@" - %@ -%@ -  %@ - %@", [MLLoginSDKInfo share].account, [MLLoginSDKInfo share].password, [MLLoginSDKInfo share].gameId, [MLLoginSDKInfo share].gusetGameId);
}

- (void)callBackApiUrl:(MLApiUrlType)apiUrlType status:(NSString *)status result:(id)result error:(NSError *)error {
    NSLog(@"cheenwe %ld-- %@-- %@", (unsigned long)apiUrlType, status, result);
}

@end
