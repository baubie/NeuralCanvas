//
//  NCWindowController.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-25.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCWindowController.h"

NSString *NCSelectedSelectToolNotification = @"NCSelectedSelectTool";
NSString *NCSelectedAddNeuronToolNotification = @"NCSelectedAddNeuronTool";
NSString *NCSelectedAddConnectionToolNotification = @"NCSelectedAddConnectionTool";
NSString *NCSelectedAddStimulusToolNotification = @"NCSelectedAddStimulusTool";


@implementation NCWindowController


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Select the Selection Tool by default
    [toolBar setSelectedItemIdentifier:@"SelectionTool"];    
}

- (void) resetToolbar
{
    [toolBar setSelectedItemIdentifier:@"SelectionTool"];    
}

- (void) redrawCanvas
{
    [canvasView display];
}


- (IBAction)selectSelectButton: (id) pId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCSelectedSelectToolNotification object:self];
}

- (IBAction)selectAddNeuronButton: (id)pId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCSelectedAddNeuronToolNotification object:self];
}

- (IBAction)selectAddConnectionButton: (id)pId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCSelectedAddConnectionToolNotification object:self];
}

- (IBAction)selectAddStimulusButton: (id)pId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCSelectedAddStimulusToolNotification object:self];
}



@end
