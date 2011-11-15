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


@implementation NCCanvasView

@synthesize currentTool;
@synthesize canvas;


- (void)awakeFromNib
{
    
    [super awakeFromNib];
  
    // Add observers for the toolbar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedSelectToolNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddNeuronToolNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddConnectionToolNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolChanged:) name:NCSelectedAddStimulusToolNotification object:nil];

    canvasScale = 1;
    
}

- (NSPoint)screenPointFromDocPoint:(NSPoint)point {    
    NSPoint r;  
    NSRect thisViewSize = [self convertRect:[self bounds] fromView:nil];
    NSPoint mid;
    mid.x = thisViewSize.size.width * 0.5;
    mid.y = thisViewSize.size.height * 0.5;
    // We are starting from mid = (0,0)
    r.x = mid.x+canvasOffset.x+point.x*canvasScale;
    r.y = mid.y+canvasOffset.y+point.y*canvasScale;
    
    return r;
}

- (NSPoint)docPointFromScreenPoint:(NSPoint)point {
    NSPoint r;  
    NSRect thisViewSize = [self convertRect:[self bounds] fromView:nil];
    NSPoint mid;
    mid.x = thisViewSize.size.width * 0.5;
    mid.y = thisViewSize.size.height * 0.5;
    // We are starting from mid = (0,0)
    r.x = (point.x-(mid.x+canvasOffset.x))/canvasScale;
    r.y = (point.y-(mid.y+canvasOffset.y))/canvasScale;
    
    return r;
}

- (void) drawGrid
{
    
    if (canvasScale <= 0) canvasScale = 0.25;
    
    NSRect thisViewSize = [self convertRect:[self bounds] fromView:nil];
        

    // We need to draw from (0,0) out to the extremes in document co-ordinates.[[

    NSPoint mid = {thisViewSize.size.width*0.5+canvasOffset.x, thisViewSize.size.height*0.5+canvasOffset.y};
        
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
        i = i + 10*canvasScale; // Jump 10 document size points
        
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
        i = i - 10*canvasScale; // Jump 10 document size points
        
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
        i = i + 10*canvasScale;
 
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
        i = i - 10*canvasScale;
        
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
        NCObject* obj = [[[self canvas] objects] objectAtIndex:i];
        [obj drawAtPoint:[self screenPointFromDocPoint:[obj location]] withScale:canvasScale];
    }    
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self lockFocus];
    [self drawGrid];
    [self drawObjects];
    [self unlockFocus];
}


/****
 * Keyboard Events
 ****/

- (void)keyDown:(NSEvent*)theEvent
{

    if ([[theEvent characters] isEqualToString:@"-"])
    {
        canvasScale -= 0.25; 
        if (canvasScale < 0.25) canvasScale = 0.25;
        [self setNeedsDisplay:YES];
        return;
    }
    if ([[theEvent characters] isEqualToString:@"+"] || [[theEvent characters] isEqualToString:@"="])
    {
        canvasScale += 0.25; 
        if (canvasScale > 4.0) canvasScale = 4.0;
        [self setNeedsDisplay:YES];
        return;
    } 
    [super keyDown:theEvent];     
}



/****
 * Mouse Events
 ****/

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent 
{
    return YES;
}
- (BOOL)acceptsFirstResponder 
{
    return YES; 
} 

- (void)mouseDown:(NSEvent*)theEvent
{
    [super mouseDown:theEvent];
    
    lastDragLocation = [self convertPoint:[theEvent locationInWindow] fromView:nil];

    // First, figure out if we mouse downed on an object.
    for(int i = (int)[[[self canvas] objects] count]-1; i >= 0 ; i--) {
        NCObject* obj = [[[self canvas] objects] objectAtIndex:i];
        if ([obj containsDocumentPoint:[self docPointFromScreenPoint:[self convertPoint:[theEvent locationInWindow] fromView:nil]]]) 
        {
            if (selectObjectForSignalMode) {
                
                // We are trying to select an object for a signal
                // Therefore, post the notification that we found a signal
                [[[self window] windowController] addTraceFromObject:obj index:0];
                
                // Get out of this mode.
                selectObjectForSignalMode = NO;
                return;
                
            } else {
                draggingObject = obj;
                [draggingObject setSelected:YES];
                return;
            }
        }
    }     
    
    
    if ([theEvent clickCount] == 2) 
    {
        canvasOffset.x = 0;
        canvasOffset.y = 0;
        [self setNeedsDisplay:YES];
    }
    
    
    switch (currentTool) {
        
        case toolAddNeuron:
            // Add the neuron and return to selector tool
            [[self canvas] addObjectOfType:@"Neuron" At:[self docPointFromScreenPoint:[self convertPoint:[theEvent locationInWindow] fromView:nil]]];
            currentTool = toolSelector;
            [[[self window] windowController] resetToolbar];  
            [self setNeedsDisplay:YES];
            break;

    }
    
    [self setCursor];
}

- (void)mouseUp:(NSEvent*)theEvent
{
    [super mouseUp:theEvent];
    // If the mouse is ever up, definitely stop dragging an object.
    [draggingObject setSelected:NO];    
    draggingObject = nil;
    [self setNeedsDisplay:YES];
}


- (void)mouseDragged:(NSEvent *)theEvent
{    
    [super mouseDragged:theEvent];
    
    if (currentTool == toolSelector && draggingObject == nil) {
        NSPoint newDragLocation = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        canvasOffset.x += -lastDragLocation.x + newDragLocation.x;
        canvasOffset.y += -lastDragLocation.y + newDragLocation.y;
        lastDragLocation = newDragLocation;
        [self setNeedsDisplay:YES];
    } else if (currentTool == toolSelector && draggingObject != nil) {
        NSPoint newDragLocation = [self convertPoint:[theEvent locationInWindow] fromView:nil];
        NSPoint curLocation = [draggingObject location];
        curLocation.x += (-lastDragLocation.x + newDragLocation.x)/canvasScale;
        curLocation.y += (-lastDragLocation.y + newDragLocation.y)/canvasScale;
        [draggingObject setLocation:curLocation];
        lastDragLocation = newDragLocation;
        [self setNeedsDisplay:YES];
    }
}

- (void)mouseMoved:(NSEvent *)theEvent
{
    bool needRedraw = NO;
    for(int i = (int)[[[self canvas] objects] count]-1; i >= 0 ; i--) {
        NCObject* obj = [[[self canvas] objects] objectAtIndex:i];
        if ([obj containsDocumentPoint:[self docPointFromScreenPoint:[self convertPoint:[theEvent locationInWindow] fromView:nil]]]) 
        {
            if ([obj hovered] == NO)
            {
                [obj setHovered:YES];
                needRedraw = YES;
            }
        } else {
            if ([obj hovered] == YES)
            {
                [obj setHovered:NO];
                needRedraw = YES;
            }
        }
    }
    if (needRedraw)
    {
        [self setNeedsDisplay:YES];
    }
}


- (void) resetCursorRects
{
    [super resetCursorRects];

    switch (currentTool)
    {
        case toolAddNeuron:
        case toolAddConnection:
        case toolAddStimulus:
            [self addCursorRect: [self convertRect:[self bounds] fromView:nil] cursor: [NCNeuron creationCursor]];
            break;
            
        default:
            [self addCursorRect: [self convertRect:[self bounds] fromView:nil] cursor: [NSCursor arrowCursor]];
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

- (void)selectObjectForSignal:(NSNotification *)notification
{
    selectObjectForSignalMode = YES;
}


@end