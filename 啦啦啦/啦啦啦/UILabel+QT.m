//
//  UILabel+QT.m
//  啦啦啦
//
//  Created by 彭盛凇 on 2017/9/6.
//  Copyright © 2017年 huangbaoche. All rights reserved.
//

#import "UILabel+QT.h"
#import <CoreText/CoreText.h>

@implementation UILabel (QT)

- (void)setLineBreakByTruncatingLastLineMiddle{
    
    if ( self.numberOfLines <= 0 ) {
        return;
    }
    NSArray *separatedLines = [self getSeparatedLinesArray];
    
    NSMutableString *limitedText = [NSMutableString string];
    
    if ( separatedLines.count >= self.numberOfLines ) {
        
        for (int i = 0 ; i < self.numberOfLines; i++) {
            
            if ( i == self.numberOfLines - 1) {
                UILabel *lastLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, MAXFLOAT)];
                lastLineLabel.text = separatedLines[self.numberOfLines - 1];
                
                NSArray *subSeparatedLines = [lastLineLabel getSeparatedLinesArray];
                NSString *lastLineText = [subSeparatedLines firstObject];
                NSInteger lastLineTextCount = lastLineText.length;
                [limitedText appendString:[NSString stringWithFormat:@"%@...",[lastLineText substringToIndex:lastLineTextCount]]];
            }else{
                [limitedText appendString:separatedLines[i]];
            }
        }
        
        
    }else{
        [limitedText appendString:self.text];
    }
    
    self.text = limitedText;
    
}

- (NSArray *)getSeparatedLinesArray
{
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

@end
