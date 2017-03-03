//
//  BaseViewController.m
//  Reader
//
//  Created by juju on 2017/3/1.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "BaseViewController.h"

#import "PrefixHeader.pch"

#import <CoreText/CoreText.h>

@interface BaseViewController ()<UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *wordHighligtArray;

@property (nonatomic, strong) NSAttributedString *attString;

@property (nonatomic, strong) DBAccess *db;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    [self setNavigationBar];
    
    [self setUIView];
}

- (void)setNavigationBar {
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navbarView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, UISCREENFRAME.width, 64)];
    
    self.navbarView.backgroundColor = NAVBAR_CORLOR;
    
    //set title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, UISCREENFRAME.width, 20)];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = FONT_NAMESIZE;
    
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.titleLabel.text = self.passageTitle;
    
    //set highlight button
    self.Highlight = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.Highlight.frame = CGRectMake(UISCREENFRAME.width - 45, 30, 30, 30);
    
    [self.Highlight setImage: [UIImage imageNamed:@"click.jpg"] forState:UIControlStateNormal];
    
    self.Highlight.tintColor = [UIColor blackColor];
    
    [self.Highlight addTarget:self action:@selector(ClickToHighlight) forControlEvents:UIControlEventTouchUpInside];
    
    //set back button
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.backButton.frame = CGRectMake(30, 30, 30, 30);
    
    [self.backButton setImage: [UIImage imageNamed:@"home.jpg"] forState:UIControlStateNormal];
    
    self.backButton.titleLabel.text = @"主页";
    
    [self.backButton addTarget:self action:@selector(ClickToBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.navbarView];
    
    [self.view addSubview: self.titleLabel];
    
    [self.view addSubview: self.Highlight];
    
    [self.view addSubview: self.backButton];
}

- (void)getData {
    
    self.db = [[DBAccess alloc] init];
    
    [self.db initializeDatabase];
    
    self.content = [self.db getContentById:self.lesson];
    
    self.isHighlight = NO;
}

- (void)setUIView {
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:216 / 255.0 green:240 / 255.0 blue:227 / 255.0 alpha:1];
    
    //set text
    NSTextStorage *passage = [[NSTextStorage alloc] initWithString:self.content];

    //set Layout
    NSLayoutManager *contentLayout = [[NSLayoutManager alloc] init];
    
    [passage addLayoutManager: contentLayout];
    
    //set textContainer
    NSTextContainer *contentContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
    
    [contentLayout addTextContainer: contentContainer];
    
    //set textView
    self.textView = [[UITextView alloc] initWithFrame: CGRectMake(5, 64, UISCREENFRAME.width - 5, UISCREENFRAME.height - 100) textContainer: contentContainer];
    
    self.textView.backgroundColor = [UIColor colorWithRed:216 / 255.0 green:240 / 255.0 blue:227 / 255.0 alpha:1];
    
    self.textView.font = FONT_NAMESIZE;
    
    self.textView.editable = NO;
    
    self.textView.selectable = YES;
    
    self.textView.delegate = self;
    
    [self.view addSubview: self.textView];
    
    //set slider
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, UISCREENFRAME.height - 50, UISCREENFRAME.width - 10, 40)];
    
    self.slider.minimumValue = 0;
    
    self.slider.maximumValue = 6;
    
    [self.slider addTarget:self action:@selector(ValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.slider];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(NotificationToHighlight:) name:@"HIGHLIGHTWORDSBYWORDS" object:nil];
}

//根据单词查看level
#pragma mark -- textViewDelegate

- (bool)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    NSLog(@"有响应就好了");
    
    NSString *str = [self.db getLevelByWords: [self.content substringWithRange: characterRange]];
    
    int level = [str intValue];

    NSString *wordLevel = @"⭐︎";
    
    for (int i = 0; i < level; ++ i) {
        
        wordLevel = [wordLevel stringByAppendingString:@"★"];
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"level: %@", wordLevel] message:[NSString stringWithFormat:@"word: %@", [self.content uppercaseString]] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction: [UIAlertAction actionWithTitle: @"确定" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
        
    return YES;
}

- (void)reHighlight {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: FONT_NAMESIZE, NSFontAttributeName, nil];
    
    [self.textView.textStorage setAttributes: dic range: NSMakeRange(0, self.textView.text.length)];
    
}

- (void)NotificationToHighlight: (NSNotification *)notification{
    
    if (self.isHighlight == YES) {
        
        [self reHighlight];
        
        self.isHighlight = NO;
    }
    
    int obj = (int)[notification object];
    
    self.words = [self.db getWordByLevel: obj];
    
    [self Highlight: self.textView withWords: self.words];
    
    self.isHighlight = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickToHighlight {
    
    if (self.isHighlight == YES) {

        [self reHighlight];
        
        self.isHighlight = NO;
        
        return;
    }
    
    self.words = [self.db getWordByLesson:self.lesson];
    
    [self Highlight: self.textView withWords: self.words];
    
    self.isHighlight = YES;
    
}

- (void)ValueChanged {
    
    if (self.isHighlight == YES) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: FONT_NAMESIZE, NSFontAttributeName, nil];
        
        [self.textView.textStorage setAttributes: dic range: NSMakeRange(0, self.textView.text.length)];
        
        self.isHighlight = NO;
    }
    
    int x = (int)self.slider.value;
    
    self.words = [self.db getWordByLevelDown: x];
    
    [self Highlight: self.textView withWords: self.words];
    
    self.isHighlight = YES;
}

/*
 *
 NSFontAttributeName  字体
 
 NSParagraphStyleAttributeName       段落格式
 
 NSForegroundColorAttributeName     字体颜色
 
 NSBackgroundColorAttributeName    背景颜色
 
 NSStrikethroughStyleAttributeName  删除线格式
 
 NSUnderlineStyleAttributeName       下划线格式
 
 NSStrokeColorAttributeName            删除线颜色
 
 NSStrokeWidthAttributeName           删除线宽度
 
 NSShadowAttributeName                 阴影
 
 */

- (void)Highlight: (UITextView *) textView withWords: (NSMutableArray *)wordsArray {
    
    for (NSString *word in wordsArray) {
        
        NSTextStorage *passage = [[NSTextStorage alloc] initWithString:textView.text];
        
        NSRange range = [textView.text rangeOfString: word options: NSRegularExpressionSearch];
    
        NSLayoutManager *contentLayout = [[NSLayoutManager alloc] init];
        
        [passage addLayoutManager: contentLayout];
        
        NSTextContainer *contentContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
        
        [contentLayout addTextContainer: contentContainer];
        
        NSDictionary *dic;
        
        if (!self.isHighlight) {
            
            dic = [NSDictionary dictionaryWithObjectsAndKeys:
                   [UIColor whiteColor], NSBackgroundColorAttributeName,
                   FONT_NAMESIZE, NSFontAttributeName,
                   [UIColor blackColor], NSForegroundColorAttributeName,
                   nil];
        } else {
            
            dic = [NSDictionary dictionaryWithObjectsAndKeys: FONT_NAMESIZE, NSFontAttributeName, nil];
        }
        
        
        NSLog(@"文字的位置:%lu",(unsigned long)range.location);
        
        [textView.textStorage setAttributes: dic range: NSMakeRange(range.location, range.length)];
    }
    
    
}

//返回
- (void)ClickToBack {
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
