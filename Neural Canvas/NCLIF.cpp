//
//  LIF.c
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-06.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#include "NCLIF.h"

void NCLIF::initialize() {
    this->V = 0;
    this->tau = 5;
    this->R = 1;
    this->tref = 1;
    this->thresh = 1;
    this->spike_height = 1.5;
}

void NCLIF::update(double dt) {
    this->update(dt, 0);
}

void NCLIF::update(double dt, double I) {
    if (ref > 0) { ref -= dt; V = 0; }
    else { 
        this->V += (-1*this->V + I * R) / tau;
        if (V >= this->thresh) {
            this->ref = this->tref;
        }
    }
}

void NCLIF::printStatus() {
    printf("V: %f", this->V);
}

int NCLIF::getNumParams() {
   
    return 1;
}

const char* NCLIF::getParamName(int index) {
    
    switch (index) {
        case 0:
                return "tau";
            break;
            
        default:
            break;
    }
    return NULL;
}

double NCLIF::getParamValue(int index) {
    
    return 0;
}

int NCLIF::getNumTraces() {
    return 1;
}

const char* NCLIF::getTraceName(int index) {
    return "Voltage";
}

double NCLIF::getTraceValue(int index) {
    
    switch (index) {
        case 0:
            return this->V;
        default: 
            return 0;
    }
}


