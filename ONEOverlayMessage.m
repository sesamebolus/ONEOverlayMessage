//
//  ONEOverlayMessage.m
//  
//
//  Created by 张 智超 on 13-11-13.
//
//

#import "ONEOverlayMessage.h"

#define OVERLAYVIEW_TAG 201311140920

@implementation ONEOverlayMessage

+(void)show:(UIView *)_parentView labelText:(NSString *)_text isKeyboardDisplayed:(BOOL)_Keyboard
{
    CGSize contentSize = [_text sizeWithFont:[UIFont systemFontOfSize:15]
                           constrainedToSize:CGSizeMake(220, MAXFLOAT)
                               lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat overlayPositionX = (320 - contentSize.width - 20) / 2;
    CGFloat overlayPositionY;
    if (_Keyboard) {
        overlayPositionY = (_parentView.frame.size.height - 216 - contentSize.height) / 2 - 10;
    } else {
        overlayPositionY = (_parentView.frame.size.height - contentSize.height) / 2 - 10;
    }
    
    UIView *overlayView = (UIView *)[_parentView viewWithTag:OVERLAYVIEW_TAG];
    if (overlayView == nil) {
        UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(overlayPositionX, overlayPositionY, contentSize.width + 20, contentSize.height + 20)];
        [overlayView setTag:OVERLAYVIEW_TAG];
        [overlayView setBackgroundColor:RGBA(0, 0, 0, 0.7)];
        [overlayView.layer setCornerRadius:3];
        [_parentView addSubview:overlayView];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220, 20)];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        [messageLabel setFont:[UIFont systemFontOfSize:15]];
        [messageLabel setTextColor:[UIColor whiteColor]];
        [messageLabel setTextAlignment:NSTextAlignmentCenter];
        [messageLabel setNumberOfLines:0];
        [messageLabel setText:_text];
        [messageLabel sizeToFit];
        [overlayView addSubview:messageLabel];
        
        [overlayView setAlpha:0];
        [overlayView setTransform:CGAffineTransformMakeScale(1, 1)];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [overlayView setAlpha:1];
                         }
                         completion:^(BOOL finished){
                             [self hiddenOverlayView:overlayView];
                         }];
    } 
}

+ (void)hiddenOverlayView:(UIView *)_targetView
{
    [UIView animateWithDuration:0.3
                          delay:2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_targetView setAlpha:0];
                         [_targetView setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
                     }
                     completion:^(BOOL finished){
                         [_targetView removeFromSuperview];
                     }];
}
@end
