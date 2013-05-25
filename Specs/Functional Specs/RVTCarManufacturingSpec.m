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

__block RVTObjectModel        *model;
__block RVTModelDrivenFactory *factory;
__block RVTConfiguration      *configuration;

before(^{
    model = [RVTObjectModel objectModel];
    factory = [RVTModelDrivenFactory modelDrivenFactoryWithObjectModel:model];
    
    RVTObjectDescription *engine    = [RVTObjectDescription objectDescriptionWithClass:[RVTEngine class] identifier:@""];
    RVTObjectDescription *frequency = [RVTObjectDescription objectDescriptionWithClass:[NSNumber  class] identifier:@"Frequency"];
    RVTObjectDescription *radio     = [RVTObjectDescription objectDescriptionWithClass:[RVTRadio  class] identifier:@""];
    RVTObjectDescription *wheel     = [RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@""];
    RVTObjectDescription *wheels    = [RVTObjectDescription objectDescriptionWithClass:[NSArray   class] identifier:@"Wheels"];
    RVTObjectDescription *car       = [RVTObjectDescription objectDescriptionWithClass:[RVTCar    class] identifier:@""];
    
    RVTRelationshipDescription *carToEngine = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:car destinationObjectDescription:engine];
    RVTRelationshipDescription *carToRadio = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:car destinationObjectDescription:radio];
    RVTRelationshipDescription *carToWheels = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:car destinationObjectDescription:wheels];
    RVTRelationshipDescription *radioToFrequency = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:radio destinationObjectDescription:frequency];
    
    [model addObjectDescription:engine];
    [model addObjectDescription:frequency];
    [model addObjectDescription:radio];
    [model addObjectDescription:wheel];
    [model addObjectDescription:wheels]; // collection?
    [model addObjectDescription:car];
    
    [model addRelationshipDescription:carToEngine];
    [model addRelationshipDescription:carToRadio];
    [model addRelationshipDescription:carToWheels];
    [model addRelationshipDescription:radioToFrequency];
    
    [configuration setFactory:[RVTCarFactory       new] forDescription:car];
    [configuration setFactory:[RVTEngineFactory    new] forDescription:engine];
    [configuration setFactory:[RVTFrequencyFactory new] forDescription:frequency];
    [configuration setFactory:[RVTRadioFactory     new] forDescription:radio];
    [configuration setFactory:[RVTWheelFactory     new] forDescription:wheel];
    [configuration setFactory:[RVTWheelsFactory    new] forDescription:wheels];
});

//describe(@"an independent radio", ^{
//    it(@"has a frequency of 102.8", ^{
//        RVTDependency *radioProduct = [[RVTDependency alloc] initWithClass:[RVTRadio class] name:nil];
//        RVTRadio *radio = [factory supplyDependency:radioProduct inModule:nil];
//        expect([radio frequency]).to.equal(@102.8);
//    });
//});
//
//describe(@"a car", ^{
//    __block RVTCar *car;
//    
//    before(^{
//        RVTDependency *dependency = [[RVTDependency alloc] initWithClass:[RVTCar class] name:nil];
//        car = [factory supplyDependency:dependency inModule:nil];
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
    RVTModelDrivenFactory *factory = [RVTModelDrivenFactory modelDrivenFactoryWithObjectModel:model];
    RVTCar *car = [factory createObjectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""]];
    
    NSLog(@"Car: %@", car);
    NSLog(@"Engine: %@", [car engine]);
    NSLog(@"Radio: %@", [car radio]);
    NSLog(@"Wheels: %@", [car wheels]);
});

SpecEnd
