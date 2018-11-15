//
//  CYXRatingStarMaskView.h
//  CYXRatingStarViewDemo
//
//  Created by 超级腕电商 on 2018/11/15.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CYXRatingStarStyle) {
    RatingStarStyleFull = 0, //满星打分
    RatingStarStyleHalf = 1, //可半星打分
};
NS_ASSUME_NONNULL_BEGIN

@interface CYXRatingStarMaskView : UIView

/*星星个数*/
-(instancetype)initWithStarNum:(NSInteger)starNum;
/**
 初始化方法
 
 @param starNum 星星个数
 @param space 星星直接的间距 默认15
 @return self
 */
-(instancetype)initWithStarNum:(NSInteger)starNum andSpace:(CGFloat)space;
/*更新布局 在设置frame之后调用*/
-(void)updateViewConstrains;
/*触摸*/
-(void)touchesWithPoint:(CGPoint)touchPoint;
/*打分风格*/
@property (nonatomic,assign) CYXRatingStarStyle ratingStarStyle;
/*总分*/
@property (nonatomic,assign) NSInteger fullScore;
/*点击 调用block  transformPoint转换过的点  score得分*/
@property (nonatomic,strong) void(^touchBlock)(CGPoint transformPoint,NSInteger score);

@end

NS_ASSUME_NONNULL_END
