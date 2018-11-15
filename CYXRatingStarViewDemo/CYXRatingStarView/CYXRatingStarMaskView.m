//
//  CYXRatingStarMaskView.m
//  CYXRatingStarViewDemo
//
//  Created by 超级腕电商 on 2018/11/15.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXRatingStarMaskView.h"
@interface CYXRatingStarMaskView ()
/*星星个数 最少两个*/
@property (nonatomic,assign) NSInteger starNum;
/*星星间距 默认15*/
@property (nonatomic,assign) CGFloat space;

@property (nonatomic,strong) NSMutableArray *itemList;
@end
@implementation CYXRatingStarMaskView
-(instancetype)initWithStarNum:(NSInteger)starNum{
    return [self initWithStarNum:starNum andSpace:15];
}

-(instancetype)initWithStarNum:(NSInteger)starNum andSpace:(CGFloat)space{
    if (self = [super init]) {
        self.starNum = starNum;
        self.space = space;
        [self createItems];
    }
    return self;
}
-(void)createItems{
    self.itemList = [NSMutableArray new];
    for (int i =0; i<self.starNum; i++) {
        UIImageView * item = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"starUnselected"]];
        [self.itemList addObject:item];
        [self addSubview:item];
    }
}
-(void)updateViewConstrains{
    if (self.starNum>1) {
        CGFloat itemWidth = (self.frame.size.width-(self.starNum -1)*self.space)/self.starNum;
        if (itemWidth>0) {
            CGFloat x = 0;
            for (UIImageView * item in self.itemList) {
                item.frame = CGRectMake(x, 0, itemWidth, self.frame.size.height);
                x+=itemWidth;
                x+=self.space;
            }
        }
    }
}
-(void)touchesWithPoint:(CGPoint)touchPoint{
    [self transformPointWithTouchPoint:touchPoint];
}

/*将触点转化成填充星星的点*/
-(CGPoint)transformPointWithTouchPoint:(CGPoint)touchPoint{
    /*满星平均分*/
    NSInteger average = self.fullScore/[self.itemList count];
    /*触摸点x*/
    CGFloat x = touchPoint.x;
    /*得分*/
    CGFloat score = 0;
    /*倒序遍历*/
    for (NSInteger i = [self.itemList count]-1; i>=0; i--) {
        UIImageView * item = self.itemList[i];
        if (x>item.frame.origin.x) {
            switch (self.ratingStarStyle) {
                case RatingStarStyleFull:{//满星
                    score = (i+1)*average;
                    x = item.frame.origin.x+item.frame.size.width;
                }
                    break;
                case RatingStarStyleHalf:{//支持半星
                    if (x>(item.frame.origin.x+item.frame.size.width/2)) {//超过半星
                        score = (i+1)*average;
                        x = item.frame.origin.x+item.frame.size.width;
                    }else{
                        score = (i+1)*average - (average/2);
                        x = item.frame.origin.x+item.frame.size.width/2;
                    }
                    
                }
                    break;
                default:
                    break;
            }
            break;
        }
    }
    CGPoint transformPoint = CGPointMake(x, touchPoint.y);
    if (self.touchBlock) {
        self.touchBlock(transformPoint, score);
    }
    return CGPointZero;
}
@end
