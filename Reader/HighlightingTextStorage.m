//
//  HighlightingTextStorage.m
//  Reader
//
//  Created by juju on 2017/3/1.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "HighlightingTextStorage.h"

@implementation HighlightingTextStorage {
    NSMutableAttributedString *_nmastring;
}

- (id)initWithString:(NSString *)str {
    
    self = [super initWithString:str];
    
    if (self) {
        
        _nmastring = [NSMutableAttributedString new];
    }
    
    return self;
}

- (NSString *)string {
    
    return _nmastring.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    
    return [_nmastring attributesAtIndex: location effectiveRange: range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    
    [_nmastring replaceCharactersInRange: range withString: str];
    
    [self edited: NSTextStorageEditedCharacters range: range changeInLength: str.length - range.length];
}

- (void)processEditing {
    
    static NSRegularExpression *words;
    
    words = words ?: [NSRegularExpression regularExpressionWithPattern: @"word" options: 0 error: nil];
    
    NSRange range = [self.string paragraphRangeForRange: self.editedRange];
    
    [self removeAttribute: NSForegroundColorAttributeName range: range];
    
    [words enumerateMatchesInString: self.string options: 0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        [self addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: result.range];
    }];
    
    [super processEditing];
}
@end
