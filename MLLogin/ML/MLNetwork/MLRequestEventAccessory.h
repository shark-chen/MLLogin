//
//  MLRequestEventAccessory.h
//  MLNetwork
//
//  Created by Chuanren Shang on 2020/8/17.
//

#import "MLBaseRequest.h"
#import "MLBatchRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLRequestEventAccessory : NSObject <MLRequestAccessory>

@property (nonatomic, copy, nullable) void (^willStartBlock)(id);
@property (nonatomic, copy, nullable) void (^willStopBlock)(id);
@property (nonatomic, copy, nullable) void (^didStopBlock)(id);

@end

@interface MLBaseRequest (MLRequestEventAccessory)

- (void)startWithWillStart:(nullable MLRequestCompletionBlock)willStart
                  willStop:(nullable MLRequestCompletionBlock)willStop
                   success:(nullable MLRequestCompletionBlock)success
                   failure:(nullable MLRequestCompletionBlock)failure
                   didStop:(nullable MLRequestCompletionBlock)didStop;

@end

@interface MLBatchRequest (MLRequestEventAccessory)

- (void)startWithWillStart:(nullable void (^)(MLBatchRequest *batchRequest))willStart
                  willStop:(nullable void (^)(MLBatchRequest *batchRequest))willStop
                   success:(nullable void (^)(MLBatchRequest *batchRequest))success
                   failure:(nullable void (^)(MLBatchRequest *batchRequest))failure
                   didStop:(nullable void (^)(MLBatchRequest *batchRequest))didStop;

@end

NS_ASSUME_NONNULL_END
