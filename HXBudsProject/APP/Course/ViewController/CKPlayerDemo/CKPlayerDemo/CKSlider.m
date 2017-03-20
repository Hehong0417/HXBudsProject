//
//  CKSlider.m
//  CKPlayerDemo
//
//  Created by n on 2017/3/16.
//  Copyright © 2017年 n. All rights reserved.
//

#import "CKSlider.h"

@implementation CKSlider

- (instancetype)initWithFrame:(CGRect)frame {

    if (self =[super initWithFrame:frame]) {
        
        [self setup];
        
    }

    return self;
}
- (void)setup{

    UIImage *thumpImage = [self getPictureWithName:@"CLRound"];
    
    [self setThumbImage:thumpImage forState:UIControlStateNormal];
    [self setThumbImage:thumpImage forState:UIControlStateHighlighted];
    
    
}
//// 控制slider的宽和高，这个方法才是真正的改变slider滑道的高的
//- (CGRect)trackRectForBounds:(CGRect)bounds{
//    [super trackRectForBounds:bounds];
//    return CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds), 2);
//}
////修改滑块位置
//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
//    rect.origin.x = rect.origin.x - 6 ;
//    rect.size.width = rect.size.width + 12;
//    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
//}

- (UIImage *)getPictureWithName:(NSString *)name{

    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CKPlayer" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];

    return image;
}
@end
