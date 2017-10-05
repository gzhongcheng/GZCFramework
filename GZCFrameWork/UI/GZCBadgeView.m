//
//  GZCBadgeView.m
//  XinYang
//
//  Created by GuoZhongCheng on 16/3/28.
//  Copyright © 2016年 GuoZhongCheng. All rights reserved.
//

#import "GZCBadgeView.h"

#import <QuartzCore/QuartzCore.h>

#define kDefaultBadgeTextColor [UIColor whiteColor]
#define kDefaultBadgeBackgroundColor [UIColor redColor]
#define kDefaultOverlayColor [UIColor colorWithWhite:1.0f alpha:0.3]

#define kDefaultBadgeTextFont [UIFont boldSystemFontOfSize:11]

#define kDefaultBadgeShadowColor [UIColor clearColor]

#define kBadgeStrokeColor [UIColor whiteColor]
#define kBadgeStrokeWidth 1.0f

#define kMarginToDrawInside (kBadgeStrokeWidth * 2)

#define kShadowOffset CGSizeMake(0.0f, 0.0f)
#define kShadowOpacity 0.4f
#define kShadowColor [UIColor colorWithWhite:0.0f alpha:kShadowOpacity]
#define kShadowRadius 0.0f

#define kBadgeHeight 16.0f
#define kBadgeTextSideMargin 0.0f

#define kBadgeCornerRadius 10.0f

#define kDefaultBadgeAlignment GZCBadgeViewAlignmentTopRight

@interface GZCBadgeView(){
    UIView *theParentView;
}

- (void)_init;
- (CGSize)sizeOfTextForCurrentSettings;

@end

@implementation GZCBadgeView

@synthesize badgeAlignment = _badgeAlignment;

@synthesize badgePositionAdjustment = _badgePositionAdjustment;
@synthesize frameToPositionInRelationWith = _frameToPositionInRelationWith;

@synthesize badgeHeight = _badgeHeight;
@synthesize badgeText = _badgeText;
@synthesize badgeTextColor = _badgeTextColor;
@synthesize badgeTextShadowColor = _badgeTextShadowColor;
@synthesize badgeTextShadowOffset = _badgeTextShadowOffset;
@synthesize badgeTextFont = _badgeTextFont;
@synthesize badgeBackgroundColor = _badgeBackgroundColor;
@synthesize badgeOverlayColor = _badgeOverlayColor;
@synthesize badgeStrokeColor = _badgeStrokeColor;
@synthesize badgeStrokeWidth = _badgeStrokeWidth;
@synthesize badgeMarginToDrawInside = _badgeMarginToDrawInside;
@synthesize badgeTextSideMargin = _badgeTextSideMargin;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _init];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self _init];
    }
    
    return self;
}

- (id)initWithParentView:(UIView *)parentView alignment:(GZCBadgeViewAlignment)alignment
{
    if ((self = [self initWithFrame:CGRectMake(0, 0, 1, 1)]))
    {
        self.badgeAlignment = alignment;
        if (alignment==GZCBadgeViewAlignmentTopRight||alignment==GZCBadgeViewAlignmentTopRightWithoutNumber) {
            [parentView.superview addSubview:self];
        }
        if (alignment==GZCBadgeViewAlignmentRightCenter||alignment==GZCBadgeViewAlignmentRightCenterWithoutNumber) {
            [parentView addSubview:self];
        }
        theParentView=parentView;
        self.badgeOverlayColor = [UIColor clearColor];
        self.badgeStrokeColor = [UIColor clearColor];
        self.badgeTextShadowColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)_init
{
    self.backgroundColor = [UIColor clearColor];
    self.badgeHeight = kBadgeHeight;
    self.badgeAlignment = kDefaultBadgeAlignment;
    self.badgeStrokeColor = kBadgeStrokeColor;
    self.badgeBackgroundColor = kDefaultBadgeBackgroundColor;
    self.badgeOverlayColor = kDefaultOverlayColor;
    self.badgeTextColor = kDefaultBadgeTextColor;
    self.badgeTextShadowColor = kDefaultBadgeShadowColor;
    self.badgeTextFont = kDefaultBadgeTextFont;
    self.badgeStrokeWidth = kBadgeStrokeWidth;
    self.badgeMarginToDrawInside = kMarginToDrawInside;
    self.badgeTextSideMargin = kBadgeTextSideMargin;
    self.marginToDrawInside = kMarginToDrawInside;
    
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [self updateView];
}

-(void)updateView{
    CGRect newFrame = self.frame;
    CGRect superviewFrame = CGRectIsEmpty(_frameToPositionInRelationWith) ? theParentView.frame : _frameToPositionInRelationWith;
    
    CGFloat textWidth = [self sizeOfTextForCurrentSettings].width;
    CGFloat textHeight = [self sizeOfTextForCurrentSettings].height;
    
    CGFloat viewWidth = textWidth + _badgeTextSideMargin + (_marginToDrawInside * 2)+4.f;
    CGFloat viewHeight =  textHeight + _badgeTextSideMargin + (_marginToDrawInside * 2);
    viewWidth = (viewWidth>viewHeight)?viewWidth:viewHeight;
    
    CGFloat superviewWidth = superviewFrame.size.width;
    CGFloat superviewHeight = superviewFrame.size.height;
    
    newFrame.size.width = viewWidth;
    newFrame.size.height = viewHeight;
    
    switch (self.badgeAlignment) {
        case GZCBadgeViewAlignmentTopRight:
            newFrame.origin.x = CGRectGetMaxX(superviewFrame) - (viewWidth / 2.0f);
            newFrame.origin.y = -viewHeight / 2.0f + 3 + CGRectGetMinY(superviewFrame);
            break;
        case GZCBadgeViewAlignmentRightCenter:
            newFrame.origin.x = superviewWidth - viewWidth -20.0f;
            newFrame.origin.y = (superviewHeight - viewHeight) / 2.0f;
            break;
        case GZCBadgeViewAlignmentTopRightWithoutNumber:
            newFrame.size.width= 8 ;   //19.0f;
            newFrame.size.height= 8;   //18.0f;
            newFrame.origin.x = CGRectGetMaxX(superviewFrame) - 4;
            newFrame.origin.y = CGRectGetMinY(superviewFrame) - 2;
            break;
        case GZCBadgeViewAlignmentRightCenterWithoutNumber:
            newFrame.size.width= 8;
            newFrame.size.height= 8;
            newFrame.origin.x = superviewWidth - _badgeHeight/2 -20.0f;
            newFrame.origin.y = (superviewHeight - _badgeHeight) / 2.0f;
            break;
        default:
            NSAssert(NO, @"Unimplemented GZCBadgeAligment type %d", self.badgeAlignment);
    }
    
    newFrame.origin.x += _badgePositionAdjustment.x;
    newFrame.origin.y += _badgePositionAdjustment.y;
    
    self.frame = newFrame;
    
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)sizeOfTextForCurrentSettings
{
    if ([self.badgeText isEqualToString:@""]) {
        return CGSizeMake(2.0f, 2.0f);
    }
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:self.badgeTextFont forKey:NSFontAttributeName];
    return [self.badgeText sizeWithAttributes:attributes];
}

#pragma mark - Setters

- (void)setBadgeAlignment:(GZCBadgeViewAlignment)badgeAlignment
{
    if (badgeAlignment != _badgeAlignment)
    {
        _badgeAlignment = badgeAlignment;
        
        switch (badgeAlignment)
        {
            case GZCBadgeViewAlignmentTopRight:
                self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            case GZCBadgeViewAlignmentRightCenter:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            case GZCBadgeViewAlignmentTopRightWithoutNumber:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
                break;
            case GZCBadgeViewAlignmentRightCenterWithoutNumber:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            default:
                NSAssert(NO, @"Unimplemented GZCBadgeAligment type %d", self.badgeAlignment);
        }
        
        [self updateView];
    }
}

- (void)setBadgePositionAdjustment:(CGPoint)badgePositionAdjustment
{
    _badgePositionAdjustment = badgePositionAdjustment;
    
    [self setNeedsLayout];
}

- (void)setBadgeText:(NSString *)badgeText
{
    if (badgeText != _badgeText)
    {
        _badgeText = [badgeText copy];
        [self updateView];
    }
}

-(void)setBadgeText:(NSString *)badgeText animation:(BOOL)animation{
    if (!animation) {
        [self setBadgeText:badgeText];
    }else{
        [UIView animateWithDuration:.1f animations:^{
            self.transform=CGAffineTransformMakeScale(1.3f, 1.3f);
        } completion:^(BOOL finished) {
            self.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
            [self setBadgeText:badgeText];
        }];
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    if (badgeTextColor != _badgeTextColor)
    {
        _badgeTextColor = badgeTextColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowColor:(UIColor *)badgeTextShadowColor
{
    if (badgeTextShadowColor != _badgeTextShadowColor)
    {
        _badgeTextShadowColor = badgeTextShadowColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowOffset:(CGSize)badgeTextShadowOffset
{
    _badgeTextShadowOffset = badgeTextShadowOffset;
    
    [self setNeedsDisplay];
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont
{
    if (badgeTextFont != _badgeTextFont)
    {
        _badgeTextFont = badgeTextFont;
        
        [self setNeedsDisplay];
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    if (badgeBackgroundColor != _badgeBackgroundColor)
    {
        _badgeBackgroundColor = badgeBackgroundColor;
        
        [self setNeedsDisplay];
    }
}

-(void)setBadgeStrokeWidth:(CGFloat)badgeStrokeWidth{
    if (badgeStrokeWidth != _badgeStrokeWidth) {
        _badgeStrokeWidth = badgeStrokeWidth;
        [self setNeedsDisplay];
    }
}

-(void)setBadgeHeight:(CGFloat)badgeHeight{
    if (badgeHeight != _badgeHeight) {
        _badgeHeight = badgeHeight;
        [self setNeedsDisplay];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    BOOL anyTextToDraw =true;
    
    if (anyTextToDraw)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGRect rectToDraw = CGRectInset(rect, 0, 0);
        
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(rectToDraw.size.width/2, rectToDraw.size.height/2)];
        
        /* Background and shadow */
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, borderPath.CGPath);
            
            CGContextSetFillColorWithColor(ctx, self.badgeBackgroundColor.CGColor);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor);
            
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        BOOL colorForOverlayPresent = self.badgeOverlayColor && ![self.badgeOverlayColor isEqual:[UIColor clearColor]];
        
        if (colorForOverlayPresent)
        {
            /* Gradient overlay */
            CGContextSaveGState(ctx);
            {
                CGContextAddPath(ctx, borderPath.CGPath);
                CGContextClip(ctx);
                
                CGFloat height = rectToDraw.size.height;
                CGFloat width = rectToDraw.size.width;
                
                CGRect rectForOverlayCircle = CGRectMake(rectToDraw.origin.x,
                                                         rectToDraw.origin.y - ceilf(height * 0.5),
                                                         width,
                                                         height);
                
                CGContextAddEllipseInRect(ctx, rectForOverlayCircle);
                CGContextSetFillColorWithColor(ctx, self.badgeOverlayColor.CGColor);
                
                CGContextDrawPath(ctx, kCGPathFill);
            }
            CGContextRestoreGState(ctx);
        }
        
        /* Stroke */
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, borderPath.CGPath);
            
            CGContextSetLineWidth(ctx, _badgeStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, _badgeStrokeColor.CGColor);
            
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        /* Text */
        CGContextSaveGState(ctx);
        {
            //            CGContextSetFillColorWithColor(ctx, self.badgeTextColor.CGColor);
            CGContextSetShadowWithColor(ctx, self.badgeTextShadowOffset, 1.0, self.badgeTextShadowColor.CGColor);
            
            CGRect textFrame = rectToDraw;
            CGSize textSize = [self sizeOfTextForCurrentSettings];
            
            textFrame.size.height = textSize.height;
            textFrame.origin.y = ceilf((rectToDraw.size.height - textFrame.size.height) / 2.0f);
            
            //            [self.badgeText drawInRect:textFrame
            //                              withFont:self.badgeTextFont
            //                         lineBreakMode:NSLineBreakByCharWrapping
            //                             alignment:NSTextAlignmentCenter];
            NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            NSDictionary*attribute = @{NSFontAttributeName:_badgeTextFont,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:self.badgeTextColor};
            [self.badgeText drawWithRect:textFrame options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
            
        }
        CGContextRestoreGState(ctx);
    }
}


@end
