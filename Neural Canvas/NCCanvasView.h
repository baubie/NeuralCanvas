//
//  NCCanvasView.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-11.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *NCSelectedAddNeuronToolNotification;
extern NSString *NCSelectedSelectToolNotification;
extern NSString *NCSelectedAddConnectionToolNotification;
extern NSString *NCSelectedAddStimulusToolNotification;

@interface NCCanvasView : NSView 

- (void)selectedToolChanged:(NSNotification *)notification;
- (void)setCursor;

@property (nonatomic) int currentTool;

@end
