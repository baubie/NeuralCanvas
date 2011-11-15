//
//  NCglScope.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-14.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#import "NCOpenGLScope.h"
#include <OpenGL/gl.h>

@implementation NCOpenGLScope

@synthesize canvas;

- (void)prepareOpenGL 
{
    glDisable(GL_DITHER);
    glDisable(GL_ALPHA_TEST);
    glDisable(GL_BLEND);
    glDisable(GL_STENCIL_TEST);
    glDisable(GL_FOG);
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_DEPTH_TEST);
    glPixelZoom(1.0,1.0);
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    [self drawTrace];
    glFlush();    
}

- (void) drawTrace 
{
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_LINES);
    {
        
    }
    glEnd();
}


@end
