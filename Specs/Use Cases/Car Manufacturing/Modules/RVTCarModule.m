// The MIT License
//
// Copyright (c) 2013 Ryan Davies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RVTCarModule.h"
#import "RVTProduct.h"
#import "RVTRadioModule.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"
#import "RVTWheel.h"
#import "RVTCarFactory.h"
#import "RVTEngineFactory.h"
#import "RVTRadioFactory.h"
#import "RVTWheelFactory.h"

@implementation RVTCarModule

- (void)declareModules
{
    [self addModule:[RVTRadioModule new]];
}

- (void)declareFactories
{
    RVTProduct *car    = [[RVTProduct alloc] initWithClass:[RVTCar    class] name:nil];
    RVTProduct *engine = [[RVTProduct alloc] initWithClass:[RVTEngine class] name:nil];
    RVTProduct *radio  = [[RVTProduct alloc] initWithClass:[RVTRadio  class] name:nil];
    RVTProduct *wheel  = [[RVTProduct alloc] initWithClass:[RVTWheel  class] name:nil];
    
    [self setFactory:[RVTCarFactory    new] forProduct:car];
    [self setFactory:[RVTEngineFactory new] forProduct:engine];
    [self setFactory:[RVTRadioFactory  new] forProduct:radio];
    [self setFactory:[RVTWheelFactory  new] forProduct:wheel];
}

@end
