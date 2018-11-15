//
//  ViewController.m
//  CYXRatingStarViewDemo
//
//  Created by 超级腕电商 on 2018/11/15.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "ViewController.h"
#import "CYXRatingStarView/CYXRatingStarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CYXRatingStarView * view = [[CYXRatingStarView alloc] initWithFrame:CGRectMake(30, 100, 250, 37)
                                                     andRatingStarStyle:RatingStarStyleHalf
                                                           andFullScore:10];
    [view initLayers];
    view.selectScore = ^(NSInteger score) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"得分%ld",(long)score] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"d确定", nil];
            [alertView show];
        });
        NSLog(@"显示一些分数UI 得分%ld",(long)score);
        
    };
    [self.view addSubview:view];
}


@end
