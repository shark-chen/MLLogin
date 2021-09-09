//
//  MLVisitorApi.m
//  GameProject
//
//  Created by shark on 2021/9/1.
//

#import "MLVisitorApi.h"
#import "MLUserManger.h"
#import "NSString+ML.h"

@implementation MLVisitorApi{
    NSDictionary *_parameter;
}

- (id)initWithParameter:(NSDictionary * __nullable)parameter {
    self = [super init];
    if (self) {
        _parameter = parameter;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/handle/guest_login";
}

- (MLRequestMethod)requestMethod {
    return MLRequestMethodGET;
}

- (id)requestArgument {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:[MLParameter publicParametersDic]];
    [parameter addEntriesFromDictionary:_parameter];
    parameter[@"token"] = [self token: parameter];
    return parameter;
}

- (NSString *)token:(NSDictionary *)parameter {
    NSString *result = @"";
    NSArray *md5Arr = @[@"uuid", @"account", @"game", @"time"];
    for (NSString *str in md5Arr) {
        if (parameter[str]) {
            result = [NSString stringWithFormat:@"%@%@",result,parameter[str]];
        }
    }
    return [[NSString stringWithFormat:@"%@%@",result, [MLUserManger share].encryptKey] md5Hash];
}

@end
