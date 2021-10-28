//
//  HSArrowMenuItemStyle.m
//  Arm
//
//  Created by Michael Wu on 2019/7/3.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#define kMaxMenuWidth 200
#define kMaxDetailTextWidth 50

#import "HSArrowMenuItemStyle.h"

@implementation HSArrowMenuItemStyle

- (instancetype)init {
    if (self = [super init]) {
        
        _type = HSArrowMenuItemTypeIconAndText;
        
        _icon = nil;
        _title = nil;
        _backgroundColor = [UIColor whiteColor];
        _pressBackgroundColor = Global_RGBHex(@"0xfafafa");
        
        _textFont = [UIFont systemFontOfSize:15.f];
        _detailTextFont = [UIFont systemFontOfSize:14.f];
        _textColor = Global_RGBHex(@"0x000000");
        _detailTextColor = Global_RGBHex(@"0x000000");
        _pressTextColor = [UIColor lightGrayColor];        
        
        _itemLeftRightMargion = 15.f;
        _itemImageTextSpace = 10.f;
        
        _itemHeight = 42.f;
        _itemWidth = 150.f;
        
        _itemIconSize = CGSizeMake(25.f, 25.f);
    }
    return self;
}


- (CGSize)textSize {
    CGSize textSize = [_title boundingRectWithSize:CGSizeMake(kMaxMenuWidth, _itemHeight)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{
                                                     NSForegroundColorAttributeName:_textColor,
                                                     NSFontAttributeName:_textFont,
                                                     }
                                           context:nil].size;
    return textSize;
}

- (CGSize)detailTextSize {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    CGSize textSize = [_detailText boundingRectWithSize:CGSizeMake(kMaxDetailTextWidth, _itemHeight)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{
                                                     NSForegroundColorAttributeName:_detailTextColor,
                                                     NSFontAttributeName:_detailTextFont,
                                                     NSParagraphStyleAttributeName:paragraphStyle,
                                                     }
                                           context:nil].size;
    return textSize;
}

- (CGSize)itemSize {
    
    CGFloat width = 0.f;
    
    if (_type == HSArrowMenuItemTypeIconAndText) {
        width = _itemLeftRightMargion*2 + _itemImageTextSpace + self.textSize.width + _itemIconSize.width;
    }else {
        width = _itemWidth;
    }
    
    return CGSizeMake(width, _itemHeight);
}

@end
