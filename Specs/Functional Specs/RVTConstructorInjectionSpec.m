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
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTPerson.h"

SpecBegin(RVTConstructorInjection)

it(@"injects an instance of RVTCar with dependencies resolved", ^{
    RVTCarModule *module = [[RVTCarModule alloc] init];
    RVTInjector *injector = [[RVTInjector alloc] initWithDependencies:[module dependencies]];
    RVTCar *car = [injector injectInstanceOf:[RVTCar class]];
    expect(car).to.beKindOf([RVTCar class]);
    expect([car engine]).to.beKindOf([RVTEngine class]);
    expect([car driver]).to.beKindOf([RVTPerson class]);
});

it(@"injects a car with a driver named John Smith", ^{
    RVTCarModule *module = [[RVTCarModule alloc] init];
    RVTInjector *injector = [[RVTInjector alloc] initWithDependencies:[module dependencies]];
    RVTCar *car = [injector injectInstanceOf:[RVTCar class]];
    RVTPerson *driver = [car driver];
    expect([driver name]).to.equal(@"John Smith");
});

SpecEnd
