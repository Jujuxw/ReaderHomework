//
//  LayoutManager.h
//  Reader
//
//  Created by juju on 2017/3/1.
//  Copyright © 2017年 juju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayoutManager : NSLayoutManager

- (void)fillBackgroundRectArray:(const CGRect *)rectArray count:(NSUInteger)rectCount forCharacterRange:(NSRange)charRange color:(UIColor *)color;

@end
