//
//  NCCanvasView.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-11.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCCanvasView.h"
#import "NeuralCanvasDocument.h"
#import "NCCanvas.h"
#import "NCNeuron.h"

enum {
    toolSelector = 0,
    toolAddNeuron,
    toolAddConnection,
    toolAddStimulus
};

CGFloat docToScreenScaling = 1;


@implementation NCCanvasView

@synthesize currentTool;
@synthesize canvas;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    
        // Add observers for the toolbar
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedSelectToolNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddNeuronToolNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddConnectionToolNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddStimulusToolNotification object:nil];

    }
    
    return self;
}

- (NSPoint)screenPointFromDocPoint:(NSPoint)point {    
    NSPoint r;  
    NSRect thisViewSize = [self bounds];
    NSPoint mid;
    mid.x = thisViewSize.size.width * 0.5;
    mid.y = thisViewSize.size.height * 0.5;
    // We are starting from mid = (0,0)
    r.x = mid.x + point.x*docToScreenScaling;
    r.y = mid.y + point.y*docToScreenScaling;
    return r;
}

- (NSPoint)docPointFromScreenPoint:(NSPoint)point {
    NSPoint r;  
    NSRect thisViewSize = [self bounds];
    NSPoint mid;
    mid.x = thisViewSize.size.width * 0.5;
    mid.y = thisViewSize.size.height * 0.5;
    // We are starting from mid = (0,0)
    r.x = point.x/docToScreenScaling-mid.x;
    r.y = point.y/docToScreenScaling-mid.y;
    return r;
}

- (void) drawGrid
{
    NSRect thisViewSize = [self bounds];

    // We need to draw from (0,0) out to the extremes in document co-ordinates.[[

    NSPoint mid = {thisViewSize.size.width*0.5+canvasOffset.x, thisViewSize.size.height*0.5+canvasOffset.y};
    
    // Set the line color
    
    // Draw the vertical lines first
    NSBezierPath * verticalLinePath = [NSBezierPath bezierPath];
    
    int gridWidth = thisViewSize.size.width;
    int gridHeight = thisViewSize.size.height;    


    // Draw the middle line
    [[NSColor colorWithDeviceRed:(195/255.0) 
                           green:(215/255.0) 
                            blue:(255/255.0) 
                           alpha:1] set];
    if (mid.x > 0 && mid.x < gridWidth)
    {
        NSPoint startPoint = {mid.x,0};
        NSPoint endPoint = {mid.x, gridHeight};
        [verticalLinePath setLineWidth:1.25];
        [verticalLinePath moveToPoint:startPoint];
        [verticalLinePath lineToPoint:endPoint];
        [verticalLinePath stroke];
    }
    
    // Draw the other lines
    [[NSColor colorWithDeviceRed:(204/255.0) 
                           green:(230/255.0) 
                            blue:(255/255.0) 
                           alpha:1] set];
    int i = mid.x;
    while (i < gridWidth)
    {
        i = i + 10; // Jump 10 document size points
        
        if (i > 0) {
            NSPoint startPoint = {i,0};
            NSPoint endPoint = {i, gridHeight};
            [verticalLinePath setLineWidth:0.5];
            [verticalLinePath moveToPoint:startPoint];
            [verticalLinePath lineToPoint:endPoint];
        }
    }
    i = mid.x;
    while (i > 0)
    {        
        i = i - 10; // Jump 10 document size points
        
        if (i < gridWidth)       {
            NSPoint startPoint = {i,0};
            NSPoint endPoint = {i, gridHeight};
            [verticalLinePath setLineWidth:0.5];
            [verticalLinePath moveToPoint:startPoint];
            [verticalLinePath lineToPoint:endPoint];
        }
    }    
    [verticalLinePath stroke];
    

    // Draw the horizontal lines    
    NSBezierPath * horizontalLinePath = [NSBezierPath bezierPath];
        
    // Draw the middle line
    [[NSColor colorWithDeviceRed:(195/255.0) 
                           green:(215/255.0) 
                            blue:(255/255.0) 
                           alpha:1] set];
    if (mid.y > 0 && mid.y < gridHeight)
    {
        NSPoint startPoint = {0,mid.y};
        NSPoint endPoint = {gridWidth,mid.y};
        [horizontalLinePath setLineWidth:1.25];
        [horizontalLinePath moveToPoint:startPoint];
        [horizontalLinePath lineToPoint:endPoint];
        [horizontalLinePath stroke];
    }    
    i = mid.y;
    while (i < gridHeight)
    {
        i = i + 10;
 
        if (i > 0) 
        {
            NSPoint startPoint = {0,i};
            NSPoint endPoint = {gridWidth, i};        
            [horizontalLinePath setLineWidth:0.5];
            [horizontalLinePath moveToPoint:startPoint];
            [horizontalLinePath lineToPoint:endPoint];
        }
    }
    i = mid.y;
    while (i > 0)
    {
        i = i - 10;
        
        if (i < gridHeight) 
        {
            NSPoint startPoint = {0,i};
            NSPoint endPoint = {gridWidth, i};        
            [horizontalLinePath setLineWidth:0.5];
            [horizontalLinePath moveToPoint:startPoint];
            [horizontalLinePath lineToPoint:endPoint];
        }
    }        
    [horizontalLinePath stroke];
    
}

- (void) drawObjects
{
    // Loop over all objects
    for(int i = 0; i < [[[self canvas] objects] count]; i++) {
        [[[[self canvas] objects] objectAtIndex:i] drawInView:self];
    }    
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self drawGrid];
    [self drawObjects];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent 
{
    return true;
}

- (void)mouseDown:(NSEvent*)theEvent
{
    
    NSPoint s2d = [self docPointFromScreenPoint:[theEvent locationInWindow]];
    NSPoint d2s = [self screenPointFromDocPoint:s2d];

    NSLog(@"Window Size (%f,%f)", [self bounds].size.width, [self bounds].size.height);
    NSLog(@"Clicked at (%f,%f)", [theEvent locationInWindow].x, [theEvent locationInWindow].y);
    NSLog(@"Document location (%f,%f)", s2d.x, s2d.y);
    NSLog(@"Inverse location (%f,%f)", d2s.x, d2s.y);
    
    switch (currentTool) {
        
        case toolAddNeuron:
            // Add the neuron and return to selector tool
            [[[[[self window] windowController] document] canvas] addObjectOfType:@"Neuron" At:[theEvent locationInWindow]];
            currentTool = toolSelector;
            [[[self window] windowController] resetToolbar];  
            [[[self window] windowController] redrawCanvas]; 
            break;

    }
    
    [self setCursor];
}

- (void) resetCursorRects
{
    [super resetCursorRects];

    switch (currentTool)
    {
        case toolAddNeuron:
        case toolAddConnection:
        case toolAddStimulus:
            [self addCursorRect: [self bounds] cursor: [NCNeuron creationCursor]];
            break;
            
        default:
            [self addCursorRect: [self bounds] cursor: [NSCursor arrowCursor]];
            break;
    }
    
    
}

- (void)setCursor
{
    [[self window] resetCursorRects];
}

- (void)selectedToolChanged:(NSNotification *)notification
{
    if ([[notification name] isEqualToString: NCSelectedSelectToolNotification])
    {
        [self setCurrentTool:toolSelector];
    }
    if ([[notification name] isEqualToString: NCSelectedAddNeuronToolNotification])
    {
        [self setCurrentTool:toolAddNeuron];
    }
    if ([[notification name] isEqualToString: NCSelectedAddConnectionToolNotification])
    {
        [self setCurrentTool:toolAddConnection];
    }
    if ([[notification name] isEqualToString: NCSelectedAddStimulusToolNotification])
    {
        [self setCurrentTool:toolAddStimulus];
    }
    [self setCursor];
}


@end