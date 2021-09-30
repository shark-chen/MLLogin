//
//  MLForgotPasswordApi.m
//  GameProject
//
//  Created by shark on 2021/9/8.
//

#import "MLForgetPasswordApi.h"
#import "MLUserManger.h"
#import "Header.h"

@implementation MLForgetPasswordApi {
    NSString *_email;
    NSDictionary *_parameter;
}

- (id)initWithEmail:(NSString *)email
          parameter:(NSDictionary * __nullable)parameter {
  self = [super init];
  if (self) {
      _email = email;
      _parameter = parameter;
  }
  return self;
}

- (NSString *)requestUrl {
    return @"/handle/forgot_password";
}

- (MLRequestMethod)requestMethod {
    return MLRequestMethodGET;
}

- (id)requestArgument {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:[MLParameter publicParametersDic]];
    [parameter removeObjectForKey:@"uuid"];
    [parameter removeObjectForKey:@"game"];
    parameter[@"email"] = _email ?:@"";
    [parameter addEntriesFromDictionary:_parameter];
    parameter[@"token"] = [self token: parameter];
    return parameter;
}

- (NSString *)token:(NSDictionary *)parameter {
    NSString *result = @"";
    NSArray *md5Arr = @[@"email", @"time"];
    for (NSString *str in md5Arr) {
        if (parameter[str]) {
            result = [NSString stringWithFormat:@"%@%@",result,parameter[str]];
        }
    }
    return [[NSString stringWithFormat:@"%@%@",result, [MLUserManger share].encryptKey] md5Hash];
}

@end
