//
//  BaseViewController.h
//  Reader
//
//  Created by juju on 2017/3/1.
//  Copyright © 2017年 juju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DBAccess.h"

#import <CoreText/CoreText.h>
@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSMutableArray *words;

@property (nonatomic, assign) NSInteger lesson;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *passageTitle;

@property (nonatomic, strong) UIButton *HighlightBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *Highlight;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic) BOOL isHighlight;

@property (nonatomic, strong) UIView *navbarView;
@end
