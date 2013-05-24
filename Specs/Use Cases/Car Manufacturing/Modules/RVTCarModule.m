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
#import "RVTDependencyMap.h"
#import "RVTDependency.h"
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

- (void)configure
{
    [[self definitions] setFactory:[RVTCarFactory    new] forDependency:[RVTDependency dependencyWithClass:[RVTCar    class] name:nil]];
    [[self definitions] setFactory:[RVTEngineFactory new] forDependency:[RVTDependency dependencyWithClass:[RVTEngine class] name:nil]];
    [[self definitions] setFactory:[RVTRadioFactory  new] forDependency:[RVTDependency dependencyWithClass:[RVTRadio  class] name:nil]];
    [[self definitions] setFactory:[RVTWheelFactory  new] forDependency:[RVTDependency dependencyWithClass:[RVTWheel  class] name:nil]];
}

@end
