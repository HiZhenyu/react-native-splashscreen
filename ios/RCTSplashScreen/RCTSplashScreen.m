//
//  RCTSplashScreen.m
//  RCTSplashScreen
//
//  Created by fangyunjiang on 15/11/20.
//  Copyright (c) 2015年 remobile. All rights reserved.
//

#import "RCTSplashScreen.h"

static RCTRootView *rootView = nil;

@interface RCTSplashScreen()

@end

@implementation RCTSplashScreen

RCT_EXPORT_MODULE(SplashScreen)

+ (void)show:(RCTRootView *)v {
    rootView = v;
    rootView.loadingViewFadeDelay = 0;
    rootView.loadingViewFadeDuration = 0;
    UIImageView *view = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];

    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat screenHeight = screenBounds.size.height;

    NSString* imageName = @"LaunchImage";

    if (screenHeight == 480)
        imageName = [imageName stringByAppendingString:@"-700"];
    if (screenHeight == 568)
        imageName = [imageName stringByAppendingString:@"-700-568h"];
    else if (screenHeight == 667)
        imageName = [imageName stringByAppendingString:@"-800-667h"];
    else if (screenHeight == 736)
        imageName = [imageName stringByAppendingString:@"-800-Portrait-736h"];


    view.image = [UIImage imageNamed:imageName];

    [[NSNotificationCenter defaultCenter] removeObserver:rootView  name:RCTContentDidAppearNotification object:rootView];

    [rootView setLoadingView:view];
}


RCT_EXPORT_METHOD(hide) {
    if (!rootView) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rootView.loadingViewFadeDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       [UIView transitionWithView: rootView
                                         duration:rootView.loadingViewFadeDelay
                                          options:UIViewAnimationOptionTransitionCrossDissolve
                                       animations:^{
                                           rootView.loadingView.hidden = YES;
                                       } completion:^(__unused BOOL finished) {
                                           [rootView.loadingView removeFromSuperview];
                                       }];
                   });
}

@end
