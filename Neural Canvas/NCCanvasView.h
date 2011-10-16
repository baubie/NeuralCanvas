//
//  NCCanvasView.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-11.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NCCanvas.h"

extern NSString *NCSelectedAddNeuronToolNotification;
extern NSString *NCSelectedSelectToolNotification;
extern NSString *NCSelectedAddConnectionToolNotification;
extern NSString *NCSelectedAddStimulusToolNotification;

@interface NCCanvasView : NSView {
    
    NSPoint canvasOffset;
}

- (void)selectedToolChanged:(NSNotification *)notification;
- (void)setCursor;

- (NSPoint)screenPointFromDocPoint:(NSPoint)point;
- (NSPoint)docPointFromScreenPoint:(NSPoint)point;


- (void) drawGrid;
- (void) drawObjects;

@property (nonatomic) int currentTool;
@property (nonatomic,retain) NCCanvas* canvas;


@end
