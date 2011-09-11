//
//  NCWindowController.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-25.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NCCanvasView.h"

enum {
    modeSelect = 0,
    modeAddNeuron,
    modeAddConnection,
    modeAddStimulus,
};

@interface NCWindowController : NSWindowController

- (IBAction)selectAddNeuronButton: (id) pId;
@property (nonatomic, retain) IBOutlet NSToolbarItem *addNeuronButton;


@property (nonatomic, retain) IBOutlet NCCanvasView *canvasView;


@end


int currentMode;
