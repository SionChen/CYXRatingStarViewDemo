//
//  CYXRatingStarView.h
//  CYXRatingStarViewDemo
//
//  Created by 超级腕电商 on 2018/11/15.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYXRatingStarMaskView.h"
NS_ASSUME_NONNULL_BEGIN
@interface CYXRatingStarView : UIView

/**
 初始化方法

 @param frame frame
 @param ratingStarStyle 打分风格
 @param fullScore 满分
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame
          andRatingStarStyle:(CYXRatingStarStyle)ratingStarStyle
                andFullScore:(NSInteger)fullScore;
/**
 初始化layer 在完成frame赋值后调用一下
 */
-(void)initLayers;
/*选择分数*/
@property (nonatomic,strong) void (^selectScore)(NSInteger score);
@end

NS_ASSUME_NONNULL_END
