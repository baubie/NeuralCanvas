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

- (void)drawRect:(NSRect)dirtyRect
{
    [[[[[self window] windowController] document] canvas] drawRect:dirtyRect onView:self];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent 
{
    return true;
}

- (void)mouseDown:(NSEvent*)theEvent
{
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