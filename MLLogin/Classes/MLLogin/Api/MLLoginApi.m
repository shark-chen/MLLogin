//
//  MLLoginApi.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLLoginApi.h"
#import "MLUserManger.h"
#import "Header.h"

@implementation MLLoginApi {
    NSString *_account;
    NSString *_password;
    NSDictionary *_parameter;
}

- (id)initWithAccount:(NSString *)account password:(NSString * __nullable)password parameter:(NSDictionary * __nullable)parameter {
  self = [super init];
  if (self) {
      _account = account;
      _password = password;
      _parameter = parameter;
  }
  return self;
}

- (NSString *)requestUrl {
  return @"/handle/login";
}

- (MLRequestMethod)requestMethod {
  return MLRequestMethodGET;
}

- (id)requestArgument {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:[MLParameter publicParametersDic]];
    parameter[@"account"] = _account ?:@"";
    if (_password) {
        parameter[@"password"] = _password;
    }
    [parameter addEntriesFromDictionary:_parameter];
    parameter[@"token"] = [self token: parameter];
    return parameter;
}

- (NSString *)token:(NSDictionary *)parameter {
    NSString *result = @"";
    NSArray *md5Arr = @[@"uuid", @"account", @"password", @"game", @"time"];
    for (NSString *str in md5Arr) {
        if (parameter[str]) {
            result = [NSString stringWithFormat:@"%@%@",result,parameter[str]];
        }
    }
    return [[NSString stringWithFormat:@"%@%@",result, [MLUserManger share].encryptKey] md5Hash];
}

@end
