//
//  HXMyAttentionCell.m
//  HXBudsProject
//
//  Created by n on 2017/3/24.
//  Copyright © 2017年 n. All rights reserved.
//

#import "HXMyAttentionCell.h"

@implementation HXMyAttentionCell

+ (instancetype)initMyAttentionCellWithXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HXMyAttentionCell" owner:nil options:nil]lastObject];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.iconImagV lh_setRoundImageViewWithBorderWidth:0 borderColor:nil];
}
- (void)setModel:(HXteacherVarListModel *)model {

    _model = model;
    
    self.hobbyLab.text = model.hobby;
    self.nameLab.text = model.the_name;
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.the_headportrait)] placeholderImage:[UIImage imageNamed:@"article_ico"]];

}
- (void)setFriendsModel:(HXAttentionFriendVarlistModel *)friendsModel {
    _friendsModel = friendsModel;
    self.hobbyLab.text = friendsModel.hobby;
    self.nameLab.text = friendsModel.nickname;
    [self.iconImagV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(friendsModel.headportrait)] placeholderImage:[UIImage imageNamed:@"person_ico"]];
}

@end
