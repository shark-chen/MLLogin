//
//  MLRequestEventAccessory.m
//  MLNetwork
//
//  Created by Chuanren Shang on 2020/8/17.
//

#import "MLRequestEventAccessory.h"

@implementation MLRequestEventAccessory

- (void)requestWillStart:(id)request {
    if (self.willStartBlock != nil) {
        self.willStartBlock(request);
        self.willStartBlock = nil;
    }
}

- (void)requestWillStop:(id)request {
    if (self.willStopBlock != nil) {
        self.willStopBlock(request);
        self.willStopBlock = nil;
    }
}

- (void)requestDidStop:(id)request {
    if (self.didStopBlock != nil) {
        self.didStopBlock(request);
        self.didStopBlock = nil;
    }
}

@end

@implementation MLBaseRequest (MLRequestEventAccessory)

- (void)startWithWillStart:(nullable MLRequestCompletionBlock)willStart
                  willStop:(nullable MLRequestCompletionBlock)willStop
                   success:(nullable MLRequestCompletionBlock)success
                   failure:(nullable MLRequestCompletionBlock)failure
                   didStop:(nullable MLRequestCompletionBlock)didStop {
    MLRequestEventAccessory *accessory = [MLRequestEventAccessory new];
    accessory.willStartBlock = willStart;
    accessory.willStopBlock = willStop;
    accessory.didStopBlock = didStop;
    [self addAccessory:accessory];
    [self startWithCompletionBlockWithSuccess:success
                                      failure:failure];
}

@end

@implementation MLBatchRequest (MLRequestEventAccessory)

- (void)startWithWillStart:(nullable void (^)(MLBatchRequest *batchRequest))willStart
                  willStop:(nullable void (^)(MLBatchRequest *batchRequest))willStop
                   success:(nullable void (^)(MLBatchRequest *batchRequest))success
                   failure:(nullable void (^)(MLBatchRequest *batchRequest))failure
                   didStop:(nullable void (^)(MLBatchRequest *batchRequest))didStop {
    MLRequestEventAccessory *accessory = [MLRequestEventAccessory new];
    accessory.willStartBlock = willStart;
    accessory.willStopBlock = willStop;
    accessory.didStopBlock = didStop;
    [self addAccessory:accessory];
    [self startWithCompletionBlockWithSuccess:success
                                      failure:failure];
}

@end
