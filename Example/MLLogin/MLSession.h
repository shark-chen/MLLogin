//
//  MLSession.h
//  MLLogin_Example
//
//  Created by shark on 2021/9/24.
//  Copyright © 2021 git. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLSession : NSObject

- (void)executeTask:(void(^)(void))complete;

- (void)doSomething;

@end

NS_ASSUME_NONNULL_END
