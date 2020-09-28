//
//  SJPromise.m
//  SJPromise
//
//  Created by jack on 2020/9/28.
//  Copyright © 2020 slientjack. All rights reserved.
//

#import "SJPromise.h"

@interface SJPromise ()

@property (nonatomic, assign) SJPromiseState state;
@property (nonatomic, strong) id resoleRes;
@property (nonatomic, strong) id rejectRes;
@property (nonatomic, strong) NSMutableArray *thenArr;
@property (nonatomic, strong) NSMutableArray *failArr;

@end

@implementation SJPromise

+ (instancetype)do:(SJPromiseCallback)callback
{
    return [[SJPromise alloc] init:callback];
}

- (instancetype)init:(SJPromiseCallback)callback
{
    self = [super init];
    if (self) {
        self.thenArr = [NSMutableArray array];
        self.failArr = [NSMutableArray array];
        
        __weak typeof(self) wself = self;
        self.resole = ^(id data) {
            if (wself.state == SJPromiseStatePending) {
                wself.resoleRes = data;
                wself.state = SJPromiseStateResolve;
                [wself onThen:data];
            }
        };
        
        self.reject = ^(id data) {
            if (wself.state == SJPromiseStatePending) {
                wself.rejectRes = data;
                wself.state = SJPromiseStateReject;
                [wself onFail:data];
            }
        };
        
        self.then = ^SJPromise *(SJPromiseThenCallback callback) {
            if (wself.state == SJPromiseStateResolve) {
                SJPromise *p = callback(wself.resoleRes);
                if (p) return p;
            } else if (wself.state == SJPromiseStatePending) {
                [wself.thenArr addObject:callback];
            }
            return wself;
        };
        
        self.fail = ^(SJPromiseFailCallback callback) {
            if (wself.state == SJPromiseStateReject) {
                callback(wself.rejectRes);
            } else if (wself.state == SJPromiseStatePending) {
                [wself.failArr addObject:callback];
            }
            return wself;
        };
        
        callback(self);
    }
    return self;
}
    
- (void)onThen:(id)res
{
    SJPromise *p = nil;
    for (SJPromiseThenCallback callback in self.thenArr) {
        if (p) {
            p.then(callback);
        } else {
            p = callback(res);
            if (p) {
                for (SJPromiseFailCallback fail in self.failArr) {
                    p.fail(fail);
                }
            }
        }
    }
}

- (void)onFail:(id)res
{
    for (SJPromiseFailCallback callback in self.failArr) {
        callback(res);
    }
}

- (void)dealloc
{
    NSLog(@"Promise dealloc!!!");
}

@end
