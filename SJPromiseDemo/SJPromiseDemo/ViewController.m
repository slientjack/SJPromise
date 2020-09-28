//
//  ViewController.m
//  SJPromiseDemo
//
//  Created by jack on 2020/9/28.
//

#import "ViewController.h"
#import <SJPromise/SJPromise.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"---> 0.Start");
    [SJPromise do:^(SJPromise *promise) {
        // 异步操作1
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            promise.resole(@"helloworld");
        });
    }].then(^SJPromise *(id res) {
        // 异步操作1的结果
        NSLog(@"---> 1.%@", res);
        // 异步操作2
        return [SJPromise do:^(SJPromise *promise) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //promise.resole(@"Jack!!!");
                promise.reject(@"error!!!");
            });
        }];
    }).then(^SJPromise *(id res) {
        // 异步操作2的结果
        NSLog(@"---> 2.%@", res);
        return nil;
    }).fail(^(id res) {
        // 错误处理1
        NSLog(@"---> fail1: %@", res);
    });
}

@end
