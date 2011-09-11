//
//  NCWindowController.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-25.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCWindowController.h"


NSString *NCSelectedToolDidChangeNotification = @"NCSelectedToolDidChange";


@implementation NCWindowController

@synthesize addNeuronButton;
@synthesize canvasView;


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
}

- (IBAction)selectAddNeuronButton: (id)pId
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCSelectedToolDidChangeNotification object:self];

}



@end
