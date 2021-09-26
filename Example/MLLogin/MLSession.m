//
//  MLSession.m
//  MLLogin_Example
//
//  Created by shark on 2021/9/24.
//  Copyright © 2021 git. All rights reserved.
//

#import "MLSession.h"

@implementation MLSession

- (void)executeTask:(void(^)(void))complete {
    !complete?:complete();
}

- (void)doSomething {
    NSLog(@"MLSession 我奔溃了");
}

@end
