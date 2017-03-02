//
//  DetailsView.m
//  Reader
//
//  Created by juju on 2017/3/2.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "DetailsView.h"

#import "PrefixHeader.pch"

@implementation DetailsView

- (IBAction)ClickToBack:(id)sender {
}

- (IBAction)ClickToAccept:(id)sender {
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setView];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
}

- (void)setView {
    
    self.cornerRadius = 10;
    
    self.wordViewBackgroundColor = [UIColor whiteColor];
    
    self.showViewBgAlpha = 0.7;
    
    self.hideClodeBtn = false;
    
    self.acceptBtnText = @"❤️，收藏";
    
    self.size = CGSizeMake(270, 350);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsView" ofType:@"bundle"];
    
    [_closeBtn setImage:[UIImage imageWithContentsOfFile:[NSBundle bundleWithPath:path]] forState:UIControlStateNormal];
    
}

- (void)setSize:(CGSize)size {
    
    _size = size;
    
//    self.showView.bounds = CGRectMake(100, 100, 300, 300);
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    _cornerRadius = cornerRadius;
    
    self.wordView.layer.cornerRadius = _cornerRadius;
    
    self.wordView.layer.masksToBounds = YES;
}

- (void)setWordLevelText:(NSMutableAttributedString *)wordLevelText {
    
    _wordLevelText = wordLevelText;
    
    _wordLevel.attributedText = wordLevelText;
}

- (void)setWordText:(NSMutableAttributedString *)wordText {
    
    _wordText = wordText;
    
    _world.attributedText = wordText;
}

- (void)setShowViewBgAlpha:(CGFloat)showViewBgAlpha {
    
    _showViewBgAlpha = showViewBgAlpha;
    
    self.showView.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    self.showView.layer.shadowOpacity = _showViewBgAlpha;
    
    self.showView.layer.cornerRadius = 10;
    
    self.showView.layer.shadowOffset = CGSizeZero;
    
    self.showView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)setWordViewBackgroundColor:(UIColor *)wordViewBackgroundColor {
    
    _wordViewBackgroundColor = wordViewBackgroundColor;
    
    self.wordView.backgroundColor = wordViewBackgroundColor;
}

- (void)setAcceptBtnColor:(UIColor *)acceptBtnColor {
    
    _acceptBtnColor = acceptBtnColor;
    
    self.wordAccept.backgroundColor = acceptBtnColor;
}

- (void)setAcceptBtnTextColor:(UIColor *)acceptBtnTextColor {
    
    _acceptBtnTextColor = acceptBtnTextColor;
    
    self.wordAccept.titleLabel.tintColor = acceptBtnTextColor;
}

- (void)setAcceptBtnFont:(UIFont *)acceptBtnFont {
    
    _acceptBtnFont = acceptBtnFont;
    
    self.wordAccept.titleLabel.font = acceptBtnFont;
}

- (void)setAcceptBtnText:(NSString *)acceptBtnText {
    
    _acceptBtnText = acceptBtnText;
    
    self.wordAccept.titleLabel.text = acceptBtnText;
}

- (void)setHideClodeBtn:(bool)hideClodeBtn {
    
    _hideClodeBtn = hideClodeBtn;
    
    self.closeBtn.hidden = hideClodeBtn;
}

- (void)dismissDetailsView:(bool)dismiss {
    
    [self dismissDetailsView:dismiss completion:nil];
}

- (void)dismissDetailsView:(bool)dismiss completion:(void (^)())completion {
    
    if (dismiss) {
        
        [self dissmiss];
    }
    
    __weak typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.1 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}

- (void)dissmiss {
    
    if (!self.showView) {
        
        return;
    }
}
@end
