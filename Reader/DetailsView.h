//
//  DetailsView.h
//  Reader
//
//  Created by juju on 2017/3/2.
//  Copyright © 2017年 juju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailsView;
@protocol DetailsViewDelegat <NSObject>

@optional

- (void)detailsView: (DetailsView *)detailView PressAcceptButton: (UIButton *)accButton;

- (void)detailsViewDismissd: (DetailsView *)detailView;

- (void)detailsViewWillDismiss: (DetailsView *)detailView;

@end

@interface DetailsView : UIView

@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIButton *wordAccept;

@property (strong, nonatomic) IBOutlet UIButton *closeBtn;

@property (strong, nonatomic) IBOutlet UIView *showView;

@property (strong, nonatomic) IBOutlet UIView *wordView;

@property (strong, nonatomic) IBOutlet UILabel *wordLevel;

@property (strong, nonatomic) IBOutlet UILabel *world;

- (IBAction)ClickToBack:(id)sender;

- (IBAction)ClickToAccept:(id)sender;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat showViewBgAlpha;

@property (nonatomic, strong) UIColor *wordViewBackgroundColor;

@property (nonatomic, strong) UIColor *acceptBtnColor;

@property (nonatomic, strong) UIColor *acceptBtnTextColor;

@property (nonatomic, strong) UIFont *acceptBtnFont;

@property (nonatomic, strong) NSMutableAttributedString *wordLevelText;

@property (nonatomic, strong) NSMutableAttributedString *wordText;

@property (nonatomic, strong) NSString *acceptBtnText;

@property (nonatomic, assign) bool hideClodeBtn;

- (void)dismissDetailsView: (bool)dismiss;

- (void)dismissDetailsView: (bool)dismiss completion: (void(^)())completion;

- (void)creatBlurBackgroundWithImage: (UIImage *)backgroundImage tintColor:(UIColor *)tintColor blurRadius:(CGFloat)blurRadius;

@end
