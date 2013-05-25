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

// library
#import "RVTConfiguration.h"
#import "RVTModelDrivenFactory.h"
#import "RVTModule.h"
#import "RVTObjectDescription.h"
#import "RVTObjectModel.h"
#import "RVTRelationshipDescription.h"

// model
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"
#import "RVTWheel.h"

// modules
#import "RVTCarModule.h"
#import "RVTRadioModule.h"

// factories
#import "RVTCarFactory.h"
#import "RVTEngineFactory.h"
#import "RVTFrequencyFactory.h"
#import "RVTRadioFactory.h"
#import "RVTWheelFactory.h"
#import "RVTWheelsFactory.h"

SpecBegin(RVTObjectGraphSpec)

__block RVTConfiguration      *configuration;
__block RVTObjectModel        *model;
__block RVTModelDrivenFactory *factory;

before(^{
    configuration = [RVTConfiguration configuration];
    model = [RVTObjectModel objectModel];
    factory = [RVTModelDrivenFactory modelDrivenFactoryWithConfiguration:configuration objectModel:model];
    
    [[RVTCarModule new] addToObjectModel:model];
    [[RVTCarModule new] addToConfiguration:configuration];
});

//describe(@"an independent radio", ^{
//    it(@"has a frequency of 102.8", ^{
//        RVTRadio *radio = [factory createObjectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTRadio class] identifier:@""]];
//        expect([radio frequency]).to.equal(@102.8);
//    });
//});
//
//describe(@"a car", ^{
//    __block RVTCar *car;
//    
//    before(^{
//        car = [factory createObjectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""]];
//    });
//    
//    it(@"has an engine", ^{
//        expect([car engine]).to.beKindOf([RVTEngine class]);
//    });
//    
//    it(@"has 4 wheels", ^{
//        expect([car wheels]).to.haveCountOf(4);
//    });
//    
//    describe(@"radio", ^{
//        it(@"has a frequency of 102.8", ^{
//            expect([[car radio] frequency]).to.equal(@102.8);
//        });
//    });
//});

it(@"builds an object with its dependencies", ^{
    RVTCar *car = [factory createObjectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""]];
    NSLog(@"Car:    %@", car);
    NSLog(@"Engine: %@", [car engine]);
    NSLog(@"Radio:  %@", [car radio]);
    NSLog(@"Wheels: %@", [car wheels]);
});

SpecEnd
