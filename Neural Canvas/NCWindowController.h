//
//  NCWindowController.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-25.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NCCanvasView.h"

extern NSString *NCSelectedAddNeuronToolNotification;
extern NSString *NCSelectedSelectToolNotification;
extern NSString *NCSelectedAddConnectionToolNotification;
extern NSString *NCSelectedAddStimulusToolNotification;

@interface NCWindowController : NSWindowController {

    IBOutlet NSToolbar  *toolBar;
    IBOutlet NSToolbarItem *selectButton;
    IBOutlet NSToolbarItem *addNeuronButton;
    IBOutlet NSToolbarItem *addConnectionButton;
    IBOutlet NSToolbarItem *addStimulusButton;
    IBOutlet NSToolbarItem *runSimulationButton;
    IBOutlet NCCanvasView *canvasView;
    
    IBOutlet NSTextField* statusbarLeftLabel;
    
    IBOutlet NSTextField* simTimestep;
    IBOutlet NSTextField* simLength;
    
}

- (void) setCanvas: (NCCanvas*) canvas;
- (IBAction)selectSelectButton: (id) pId;
- (IBAction)selectAddNeuronButton: (id) pId;
- (IBAction)selectAddConnectionButton: (id) pId;
- (IBAction)selectAddStimulusButton: (id) pId;
- (IBAction)selectRunSimulationButton: (id) pId;

- (void) resetToolbar;
- (void) redrawCanvas;

- (void) updateStatusBarText:(NSString*) text;


@property (nonatomic,retain) NCCanvas* canvas;


@end
