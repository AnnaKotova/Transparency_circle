//
//  ViewController.m
//  jion
//
//  Created by Ann Kotova on 2/17/16.
//  Copyright © 2016 Bmuse. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat _width;
    CGFloat _diametr;
    UIView * _playArea;
    UIView * _playArea1;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat xIndent = 10;
    _width = self.view.bounds.size.width - 2 * xIndent;
    _diametr = (_width)/3.0; // - xIndent * 5
    
    _playArea = [[UIView alloc] initWithFrame:CGRectMake(xIndent, self.view.bounds.size.height / 2 - _width / 2, _width, _width)];
    _playArea.opaque = YES;
    _playArea.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_playArea];

    
    [_playArea addSubview:[[UIImageView alloc]initWithImage:[self circularOverlayMask] ] ];
    [self _drawCircleFrom:CGPointMake(50, 50)];
    
}

- (void)_drawCircleFrom:(CGPoint)point
{
    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x, point.y, _diametr, _diametr)] CGPath]];
    
    [[self.view layer] insertSublayer:circleLayer below:_playArea.layer];
    [circleLayer setFillColor:[[UIColor greenColor] CGColor]];
}

- (UIImage *)circularOverlayMask
{
    // Constants
    CGRect bounds = _playArea.bounds;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    CGFloat diameter = width - (30 * 2);
    CGFloat radius = diameter / 2;
    CGPoint center = CGPointMake(width / 2, height / 2);
    
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    
    // Create the bezier paths
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:bounds];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radius, center.y - radius, diameter, diameter)];
    
    [clipPath appendPath:maskPath];
    clipPath.usesEvenOddFillRule = YES;
    
    [clipPath addClip];
    [[UIColor blueColor] setFill];
    [clipPath fill];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}
@end
