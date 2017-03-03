//
//  HXActivityDetailContentCell.m
//  HXBudsProject
//
//  Created by n on 2017/2/22.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXActivityDetailContentCell.h"

@implementation HXActivityDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UITextView *textView = [UITextView lh_textViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - WidthScaleSize_H(328) ) font:FONT(14) backgroundColor:kWhiteColor];
        textView.textColor = kGrayColor;
        _textView = textView;
        
        [self.contentView addSubview:textView];
    }
    
    return self;

}
@end
