//
//  MLNetwork.h
//
//  Copyright (c) 2012-2016 MLNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>

#ifndef _MLNETWORK_
    #define _MLNETWORK_

#if __has_include(<MLNetwork/MLNetwork.h>)

    FOUNDATION_EXPORT double MLNetworkVersionNumber;
    FOUNDATION_EXPORT const unsigned char MLNetworkVersionString[];

    #import <MLNetwork/MLRequest.h>
    #import <MLNetwork/MLBaseRequest.h>
    #import <MLNetwork/MLNetworkAgent.h>
    #import <MLNetwork/MLBatchRequest.h>
    #import <MLNetwork/MLBatchRequestAgent.h>
    #import <MLNetwork/MLChainRequest.h>
    #import <MLNetwork/MLChainRequestAgent.h>
    #import <MLNetwork/MLNetworkConfig.h>
    #import <MLNetwork/MLRequestEventAccessory.h>

#else

    #import "MLRequest.h"
    #import "MLBaseRequest.h"
    #import "MLNetworkAgent.h"
    #import "MLBatchRequest.h"
    #import "MLBatchRequestAgent.h"
    #import "MLChainRequest.h"
    #import "MLChainRequestAgent.h"
    #import "MLNetworkConfig.h"
    #import "MLRequestEventAccessory.h"

#endif /* __has_include */

#endif /* _MLNETWORK_ */
