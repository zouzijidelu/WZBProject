//
//  HSArrowMenuAlert.m
//  Arm
//
//  Created by Michael Wu on 2019/7/3.
//  Copyright © 2019 iTalkBB. All rights reserved.
//

#import "HSArrowMenuAlert.h"
#import "HSArrowMenuItem.h"

#define keyWindow [UIApplication sharedApplication].delegate.window
#define Color_White             [UIColor whiteColor]

static NSString * const kAnimation_Type_Key = @"animationType";
static NSString * const kAnimation_Show_Value = @"show";
static NSString * const kAnimation_Dismiss_Value = @"dismiss";

static NSString * const kShow_Animation_Key = @"kShow_Animation_Key";
static NSString * const kDismiss_Animation_Key = @"kDismiss_Animation_Key";

@interface HSArrowMenuAlert () <CAAnimationDelegate,HSArrowMenuItemDelegate>

@property (nonatomic, strong) NSArray<HSArrowMenuItemStyle*> *itemStyles;
@property (nonatomic, assign) HSArrowMenuViewDirection direction;
@property (nonatomic, assign) CGPoint showPointCenter;

// ui
@property (nonatomic, weak) UIView *superView;
@property (nonatomic, strong) UIView *coverTapView;

@property (nonatomic, strong) HSArrowMenuAlertStyle *alertStyle;

@property (nonatomic, strong) NSMutableArray<HSArrowMenuItem*> *itemViews;

@property (nonatomic, strong) NSArray<NSValue*> *points;

@property (nonatomic, copy) HSArrowMenuAlertCancelBlock cancelBlock;
@property (nonatomic, copy) HSArrowMenuAlertItemClickBlock itemClickBlock;
@property (nonatomic, assign) BOOL isAppear;

@end

@implementation HSArrowMenuAlert

#pragma mark - Initialize

+ (instancetype)showToast:(HSArrowMenuAlertStyle *)style
                    items:(NSArray<HSArrowMenuItemStyle *> *)items
                    point:(CGPoint)point
                direction:(HSArrowMenuViewDirection)direction
                superView:(UIView *)superView
                   cancel:(HSArrowMenuAlertCancelBlock)cancelClosure
                itemClick:(HSArrowMenuAlertItemClickBlock)clickClosure {
    
    HSArrowMenuAlert *alert = [[HSArrowMenuAlert alloc]initWithStyle:style items:items point:point direction:direction superView:superView cancel:cancelClosure itemClick:clickClosure];
    
    [alert show];
    return alert;
}

- (instancetype)initWithStyle:(HSArrowMenuAlertStyle *)style
                        items:(NSArray<HSArrowMenuItemStyle *> *)items
                        point:(CGPoint)point
                    direction:(HSArrowMenuViewDirection)direction
                    superView:(UIView *)superView
                       cancel:(HSArrowMenuAlertCancelBlock)cancelClosure
                    itemClick:(HSArrowMenuAlertItemClickBlock)clickClosure {
    
    if (self = [super init]) {
        
        [self initialize];
        if (!style) {
            style = [[HSArrowMenuAlertStyle alloc]init];
        }
        _alertStyle = style;
        _itemStyles = items;
        _showPointCenter = point;
        _direction = direction;
        _superView = superView?:keyWindow;
        _itemClickBlock = [clickClosure copy];
        _cancelBlock = [cancelClosure copy];
        
        self.frame = [self caculateHoleFrame];
        _points = [self calculateTrianglePoints];
        
        [self setNeedsDisplay];
        [self configUIAfterDrawRect];
    }
    return self;
}

- (instancetype)initialize {
    
    _itemViews = [NSMutableArray new];
    self.opaque = NO;
    
    _coverTapView = ({
        UIView *cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        cover.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToDismissAction:)];
        [cover addGestureRecognizer:tap];
        cover;
    });
    
    return self;
}


#pragma mark - UI

- (void)configUIAfterDrawRect {
    
    CGFloat originalY = 0.f;
    if (_direction == HSArrowMenuViewDirectionLeftBottom || _direction == HSArrowMenuViewDirectionCenterBottom || _direction == HSArrowMenuViewDirectionRightBottom) {
        originalY = _alertStyle.triangleSize.height;
    }
    
    __block HSArrowMenuItem *lastItem = nil;
    [_itemStyles enumerateObjectsUsingBlock:^(HSArrowMenuItemStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isNeedLine = !_alertStyle.isNeedLine ? _alertStyle.isNeedLine : (idx != _itemStyles.count - 1);
        HSArrowMenuItem *item = [[HSArrowMenuItem alloc]initWithItemStyle:obj delegate:self index:idx cornerRadius:_alertStyle.cornerRadius isNeedLine:isNeedLine];
        item.frame = CGRectMake(0, originalY + lastItem.bounds.size.height*idx, self.frame.size.width, obj.itemSize.height);
        [self addSubview:item];
        lastItem = item;
        [_itemViews addObject:item];
    }];
    
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self private_drawRect:rect contextHandler:^(CGContextRef context) {
        
        if (_alertStyle && _alertStyle.backgroundColor) {
            [_alertStyle.backgroundColor setStroke];
            [_alertStyle.backgroundColor setFill];
        } else {
            [Color_White setStroke];
            [Color_White setFill];
        }
        
        
        // 三角形
        CGPoint points[3];
        points[0] = [_points[0] CGPointValue];
        points[1] = [_points[1] CGPointValue];
        points[2] = [_points[2] CGPointValue];
        CGContextAddLines(context, points, 3);
        
        // 矩形
        CGFloat squareX , squareY , squareWidth, squareHeight;
        switch (_direction) {
            case HSArrowMenuViewDirectionLeftTop:
            case HSArrowMenuViewDirectionCenterTop:
            case HSArrowMenuViewDirectionRightTop:
            {
                squareX = 0;
                squareY = 0;
                squareWidth = self.bounds.size.width;
                squareHeight = self.bounds.size.height - _alertStyle.triangleSize.height;
            }
                break;
            case HSArrowMenuViewDirectionLeftBottom:
            case HSArrowMenuViewDirectionCenterBottom:
            case HSArrowMenuViewDirectionRightBottom:
            {
                squareX = 0;
                squareY = _alertStyle.triangleSize.height;
                squareWidth = self.bounds.size.width;
                squareHeight = self.bounds.size.height - _alertStyle.triangleSize.height;
            }
                break;
            default:
            {
//                HSAssert(NO, @"unknwon direction");
            }
                break;
        }
        UIBezierPath *squarePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(squareX,squareY,squareWidth,squareHeight) cornerRadius:_alertStyle.cornerRadius];
        
        
        [squarePath fill];
        [squarePath stroke];                
        
    }];
}

- (void)private_drawRect:(CGRect)rect contextHandler:(void(^)(CGContextRef context))contextHandler {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    contextHandler(context);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)updateShadow {
    
    if (!_alertStyle.enableShadow) {
        return;
    }
    
    CALayer *shadowLayer = self.layer;
    shadowLayer.shadowOpacity = 0.1f;
    shadowLayer.shadowRadius = 5.f;
    shadowLayer.shadowOffset = CGSizeMake(0, 1);
}

- (void)layoutSubviews {
    
    [self updateShadow];
}

#pragma mark - Api

- (void)show {
    [self showIfDelayDismiss:NO];
}

- (void)showNerverDismiss {
    [self showIfDelayDismiss:NO];
}

- (void)showIfDelayDismiss:(BOOL)ifDismiss {
    if (_isAppear) {
        return;
    }
    _isAppear = YES;
    
    [_superView addSubview:_coverTapView];
    [_superView addSubview:self];
    [self animation_show];
    
    if (ifDismiss) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:5.f];
    }
}

- (void)dismiss {
    if (!_isAppear) {
        return;
    }
    [self animation_dismiss];
}

#pragma mark - Event Method

- (void)tapToDismissAction:(id)sender {
    
    if (_cancelBlock) {
        _cancelBlock();
    }
    
    [self dismiss];
    
}

#pragma mark - Animation

- (void)animation_show {
    
    CABasicAnimation *alphaAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnima.duration = .2f;
    alphaAnima.removedOnCompletion = YES;
    alphaAnima.fromValue = @0;
    alphaAnima.toValue = @1;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2f;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.keyTimes = @[ @0, @0.5, @1 ];
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    /** postion and anchorPoint :
     *
     * frame.origin.x = position.x - anchorPoint.x * bounds.size.width；
     * frame.origin.y = position.y - anchorPoint.y * bounds.size.height；
     */
    CGRect oldFrame = self.frame;
    switch (_direction) {
        case HSArrowMenuViewDirectionLeftTop:
        {
            self.layer.anchorPoint = CGPointMake(0.1, 1);
        }
            break;
        case HSArrowMenuViewDirectionCenterTop:
        {
            self.layer.anchorPoint = CGPointMake(0.5, 1);
        }
            break;
        case HSArrowMenuViewDirectionRightTop:
        {
            self.layer.anchorPoint = CGPointMake(0.9, 1);
        }
            break;
        case HSArrowMenuViewDirectionLeftBottom:
        {
            self.layer.anchorPoint = CGPointMake(0.1, 0);
        }
            break;
        case HSArrowMenuViewDirectionCenterBottom:
        {
            self.layer.anchorPoint = CGPointMake(0.5, 0);
        }
            break;
        case HSArrowMenuViewDirectionRightBottom:
        {
            self.layer.anchorPoint = CGPointMake(0.9, 0);
        }
            break;
        default:
            break;
    }
    self.frame = oldFrame; // fix wrong frame when anchorPoint changed.
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[alphaAnima,animation];
    group.delegate = self;
    
    [group setValue:kAnimation_Show_Value forKey:kAnimation_Type_Key];
    [self.layer addAnimation:group forKey:kShow_Animation_Key];
    
}

- (void)animation_dismiss {
 
    [self.layer removeAnimationForKey:kShow_Animation_Key];
    
    [UIView animateWithDuration:.2f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        _isAppear = NO;
        
        [_coverTapView removeFromSuperview];
        [self removeFromSuperview];
        
        self.alpha = 1.f;
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}

#pragma mark - Private


- (CGRect)caculateHoleFrame {
    
    // find the max width item
    __block CGFloat maxItemWidth = 0.f;
    __block CGFloat totalItemsHeight = 0.f;
    [_itemStyles enumerateObjectsUsingBlock:^(HSArrowMenuItemStyle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat itemWidth = obj.itemSize.width;
        CGFloat itemHeght = obj.itemSize.height;
        if (itemWidth > maxItemWidth) {
            maxItemWidth = itemWidth;
        }
        totalItemsHeight += itemHeght;
    }];
    
    CGFloat toastX = 0.f;
    CGFloat toastY = 0.f;
    CGFloat toastWidth = maxItemWidth;
    CGFloat toastHeight = totalItemsHeight + _alertStyle.triangleSize.height;
    
    switch (_direction) {
            
            // top:
        case HSArrowMenuViewDirectionLeftTop:
        {
            toastX = _showPointCenter.x - _alertStyle.triangleSize.width*0.5 - _alertStyle.triangleLeftMargion;
            toastY = _showPointCenter.y - toastHeight;
        }
            break;
        case HSArrowMenuViewDirectionCenterTop:
        {
            toastX = _showPointCenter.x  - toastWidth*0.5;
            toastY = _showPointCenter.y  - toastHeight;
        }
            break;
        case HSArrowMenuViewDirectionRightTop:
        {
            toastX = _showPointCenter.x - _alertStyle.triangleSize.width*0.5 - (toastWidth-(_alertStyle.triangleLeftMargion+_alertStyle.triangleSize.width));
            toastY = _showPointCenter.y  - toastHeight;
        }
            break;
            
            // bottom:
        case HSArrowMenuViewDirectionLeftBottom:
        {
            toastX = _showPointCenter.x - _alertStyle.triangleSize.width*0.5 - _alertStyle.triangleLeftMargion;
            toastY = _showPointCenter.y;
        }
            break;
        case HSArrowMenuViewDirectionCenterBottom:
        {
            toastX = _showPointCenter.x - toastWidth*0.5;
            toastY = _showPointCenter.y;
        }
            break;
        case HSArrowMenuViewDirectionRightBottom:
        {
            toastX = _showPointCenter.x - _alertStyle.triangleSize.width*0.5 - (toastWidth-(_alertStyle.triangleLeftMargion+_alertStyle.triangleSize.width));
            toastY = _showPointCenter.y;
        }
            break;
        default:
        {
//            HSAssert(NO, @"unknwon direction");
        }
            break;
    }
    
    CGRect frame = CGRectMake(toastX, toastY, toastWidth, toastHeight);
    
    return frame;
}

- (NSArray<NSValue*>*)calculateTrianglePoints {
    
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
//        HSAssert(NO, @"frame must get before this !");
    }
    
    CGFloat triangleLeftMargion = 0.f;
    
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    
    switch (_direction) {
            
            // top:
        case HSArrowMenuViewDirectionLeftTop:
        case HSArrowMenuViewDirectionCenterTop:
        case HSArrowMenuViewDirectionRightTop:
        {
            if (_direction == HSArrowMenuViewDirectionLeftTop) {
                triangleLeftMargion = _alertStyle.triangleLeftMargion;
            }else if (_direction == HSArrowMenuViewDirectionCenterTop){
                triangleLeftMargion = self.bounds.size.width*0.5 - _alertStyle.triangleSize.width*0.5;
            }else if (_direction == HSArrowMenuViewDirectionRightTop){
                triangleLeftMargion = self.bounds.size.width - (_alertStyle.triangleLeftMargion+_alertStyle.triangleSize.width) ;
            }
            
            point0 = CGPointMake(triangleLeftMargion, self.bounds.size.height-_alertStyle.triangleSize.height);
            point1 = CGPointMake(triangleLeftMargion +_alertStyle.triangleSize.width*0.5, self.bounds.size.height);
            point2 = CGPointMake(triangleLeftMargion + _alertStyle.triangleSize.width, point0.y);
        }
            break;
            
            // bottom:
        case HSArrowMenuViewDirectionLeftBottom:
        case HSArrowMenuViewDirectionCenterBottom:
        case HSArrowMenuViewDirectionRightBottom:
        {
            if (_direction == HSArrowMenuViewDirectionLeftBottom) {
                triangleLeftMargion = _alertStyle.triangleLeftMargion;
            }else if (_direction == HSArrowMenuViewDirectionCenterBottom){
                triangleLeftMargion = self.bounds.size.width*0.5 - _alertStyle.triangleSize.width*0.5;
            }else if (_direction == HSArrowMenuViewDirectionRightBottom){
                triangleLeftMargion = self.bounds.size.width - (_alertStyle.triangleLeftMargion+_alertStyle.triangleSize.width) ;
            }
            point0 = CGPointMake(triangleLeftMargion, _alertStyle.triangleSize.height);
            point1 = CGPointMake(triangleLeftMargion +_alertStyle.triangleSize.width*0.5, 0);
            point2 = CGPointMake(triangleLeftMargion + _alertStyle.triangleSize.width, point0.y);
        }
            break;
        default:
        {
//            HSAssert(NO, @"unknwon direction");
        }
            break;
    }
    
    NSValue *value0 = [NSValue valueWithCGPoint:point0];
    NSValue *value1 = [NSValue valueWithCGPoint:point1];
    NSValue *value2 = [NSValue valueWithCGPoint:point2];
    
    return @[value0,value1,value2];
}

#pragma mark - HSArrowMenuItemDelegate

- (void)arrowMenuItem:(HSArrowMenuItem *)item didClickAtIndex:(NSInteger)index {
    
    if (_itemClickBlock) {
        _itemClickBlock(item, index);
        
        [self dismiss];
    }
    
}

@end
