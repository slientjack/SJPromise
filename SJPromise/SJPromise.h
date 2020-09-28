//
//  SJPromise.h
//  SJPromise
//
//  Created by jack on 2020/9/28.
//

#import <Foundation/Foundation.h>

@class SJPromise;

typedef NS_ENUM(NSUInteger, SJPromiseState) {
    SJPromiseStatePending,
    SJPromiseStateResolve,
    SJPromiseStateReject,
};

typedef void(^SJPromiseResolve)(id data);
typedef void(^SJPromiseReject)(id data);
typedef void(^SJPromiseCallback)(SJPromise *promise);
typedef SJPromise*(^SJPromiseThenCallback)(id res);
typedef void(^SJPromiseFailCallback)(id res);
typedef SJPromise*(^SJPromiseThen)(SJPromiseThenCallback callback);
typedef SJPromise*(^SJPromiseFail)(SJPromiseFailCallback callback);

@interface SJPromise : NSObject

@property (nonatomic, strong) SJPromiseResolve resole;
@property (nonatomic, strong) SJPromiseReject reject;
@property (nonatomic, strong) SJPromiseThen then;
@property (nonatomic, strong) SJPromiseFail fail;

+ (instancetype)do:(SJPromiseCallback)callback;

- (instancetype)init:(SJPromiseCallback)callback;

@end


