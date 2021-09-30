//
//  MLBindApi.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLBindApi.h"
#import "MLUserManger.h"
#import "Header.h"

@implementation MLBindApi{
    NSString *_account;
    NSString *_password;
    NSString *_gameId;
    NSDictionary *_parameter;
}

- (id)initWithAccount:(NSString *)account
             password:(NSString *)password
               gameId:(NSString *)gameId
            parameter:(NSDictionary * __nullable)parameter {
  self = [super init];
  if (self) {
      _account = account;
      _password = password;
      _gameId = gameId;
      _parameter = parameter;
  }
  return self;
}

- (NSString *)requestUrl {
    return @"/handle/bind";
}

- (MLRequestMethod)requestMethod {
    return MLRequestMethodGET;
}

- (id)requestArgument {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:[MLParameter publicParametersDic]];
    parameter[@"account"] = _account ?:@"";
    parameter[@"password"] = _password ?:@"";
    parameter[@"game_id"] = _gameId ?:@"";
    [parameter addEntriesFromDictionary:_parameter];
    parameter[@"token"] = [self token: parameter];
    return parameter;
}

- (NSString *)token:(NSDictionary *)parameter {
    NSString *result = @"";
    NSArray *md5Arr = @[@"uuid", @"game_id", @"account", @"password", @"game", @"time"];
    for (NSString *str in md5Arr) {
        if (parameter[str]) {
            result = [NSString stringWithFormat:@"%@%@",result,parameter[str]];
        }
    }
    return [[NSString stringWithFormat:@"%@%@",result, [MLUserManger share].encryptKey] md5Hash];
}

@end
