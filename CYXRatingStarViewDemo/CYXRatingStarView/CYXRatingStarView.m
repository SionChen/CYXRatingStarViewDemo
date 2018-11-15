//
//  CYXRatingStarView.m
//  CYXRatingStarViewDemo
//
//  Created by 超级腕电商 on 2018/11/15.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXRatingStarView.h"

@interface CYXRatingStarView()
/*背景红色*/
@property (nonatomic,strong) CAShapeLayer *backColorLayer;
@property (nonatomic,strong) CYXRatingStarMaskView *maskView;
@end
@implementation CYXRatingStarView

-(instancetype)initWithFrame:(CGRect)frame
          andRatingStarStyle:(CYXRatingStarStyle)ratingStarStyle
                andFullScore:(NSInteger)fullScore{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.maskView.fullScore = fullScore;
        self.maskView.ratingStarStyle = ratingStarStyle;
        [self.layer addSublayer:self.backColorLayer];
        
    }
    return self;
}
-(void)initLayers{
    self.maskView.frame = self.bounds;
    [self.maskView updateViewConstrains];
    self.backColorLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    self.backColorLayer.path = path.CGPath;
    self.backColorLayer.lineWidth = self.frame.size.height;
    self.backColorLayer.mask = self.maskView.layer;
    self.backColorLayer.strokeEnd = 0;
}
/*设置选择的星星*/
-(void)setStrokeWithTransformPoint:(CGPoint)transformPoint{
    CGPoint newPoint = [self convertPoint:transformPoint fromView:self.maskView];
    NSLog(@"%f",newPoint.x);
    self.backColorLayer.strokeEnd = newPoint.x/self.frame.size.width;
}
/*一根或者多根手指开始触摸view，系统会自动调用view的下面方法*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取touch
    UITouch * touch = [touches anyObject];
    //获取当前点
    CGPoint touchPoint = [touch locationInView:self];
    CGPoint newPoint = [self convertPoint:touchPoint toView:self.maskView];
    [self.maskView touchesWithPoint:newPoint];
}
#pragma mark ---G
-(CAShapeLayer*)backColorLayer{
    if(!_backColorLayer){
        _backColorLayer = [[CAShapeLayer alloc] init];
        _backColorLayer.backgroundColor = [UIColor grayColor].CGColor;//在这里是未填充的颜色
        _backColorLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
        //_backColorLayer.lineCap = kCALineCapSquare; // 设置线为圆角
        _backColorLayer.strokeColor = [UIColor redColor].CGColor; // 路径颜色颜色（填充颜色）
    }
    return _backColorLayer;
}
-(CYXRatingStarMaskView*)maskView{
    if(!_maskView){
        __weak __typeof(&*self)weakSelf = self;
        _maskView = [[CYXRatingStarMaskView alloc] initWithStarNum:5];
        _maskView.touchBlock = ^(CGPoint transformPoint, NSInteger score) {
            NSLog(@"%@",NSStringFromCGPoint(transformPoint));
            NSLog(@"%ld",(long)score);
            [weakSelf setStrokeWithTransformPoint:transformPoint];
            if (weakSelf.selectScore) {
                weakSelf.selectScore(score);
            }
        };
    }
    return _maskView;
}
@end
