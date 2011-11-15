//
//  NCOverlayView.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-14.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#import "NCOverlayView.h"

@implementation NCOverlayView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{

    NSBezierPath *path = [NSBezierPath bezierPath];

    NSPoint start;
    start.x = 10;
    start.y = 10;
    
    NSPoint end;
    end.x = 50;
    end.y = 50;
    
    [path moveToPoint:start];
    [path lineToPoint:end];
    
    [path setLineWidth:4];
    [path stroke];
    
}

@end
