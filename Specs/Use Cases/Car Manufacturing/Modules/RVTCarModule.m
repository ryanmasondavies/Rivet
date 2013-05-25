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
#import "RVTConfiguration.h"
#import "RVTObjectDescription.h"
#import "RVTObjectModel.h"
#import "RVTRelationshipDescription.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"
#import "RVTWheel.h"
#import "RVTCarFactory.h"
#import "RVTEngineFactory.h"
#import "RVTRadioFactory.h"
#import "RVTWheelFactory.h"
#import "RVTWheelsFactory.h"
#import "RVTRadioModule.h"

@implementation RVTCarModule

- (void)addToConfiguration:(RVTConfiguration *)configuration
{
    [configuration setFactory:[RVTCarFactory    new] forObjectDescription:[self carDescription]];
    [configuration setFactory:[RVTEngineFactory new] forObjectDescription:[self engineDescription]];
    [configuration setFactory:[RVTRadioFactory  new] forObjectDescription:[self radioDescription]];
    [configuration setFactory:[RVTWheelFactory  new] forObjectDescription:[self frontLeftWheelDescription]];
    [configuration setFactory:[RVTWheelFactory  new] forObjectDescription:[self frontRightWheelDescription]];
    [configuration setFactory:[RVTWheelFactory  new] forObjectDescription:[self rearLeftWheelDescription]];
    [configuration setFactory:[RVTWheelFactory  new] forObjectDescription:[self rearRightWheelDescription]];
    [configuration setFactory:[RVTWheelsFactory new] forObjectDescription:[self wheelsDescription]];
    
    [[RVTRadioModule new] addToConfiguration:configuration];
}

- (void)addToObjectModel:(RVTObjectModel *)objectModel
{
    RVTRelationshipDescription *carToEngine   = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self carDescription] destinationObjectDescription:[self engineDescription]];
    RVTRelationshipDescription *carToRadio    = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self carDescription] destinationObjectDescription:[self radioDescription]];
    RVTRelationshipDescription *carToWheels   = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self carDescription] destinationObjectDescription:[self wheelsDescription]];
    
    RVTRelationshipDescription *wheelsToFrontLeftWheel  = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self wheelsDescription] destinationObjectDescription:[self frontLeftWheelDescription]];
    RVTRelationshipDescription *wheelsToFrontRightWheel = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self wheelsDescription] destinationObjectDescription:[self frontRightWheelDescription]];
    RVTRelationshipDescription *wheelsToRearLeftWheel   = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self wheelsDescription] destinationObjectDescription:[self rearLeftWheelDescription]];
    RVTRelationshipDescription *wheelsToRearRightWheel  = [RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:[self wheelsDescription] destinationObjectDescription:[self rearRightWheelDescription]];
    
    [objectModel addObjectDescription:[self carDescription]];
    [objectModel addObjectDescription:[self engineDescription]];
    [objectModel addObjectDescription:[self radioDescription]];
    [objectModel addObjectDescription:[self frontLeftWheelDescription]];
    [objectModel addObjectDescription:[self frontRightWheelDescription]];
    [objectModel addObjectDescription:[self rearLeftWheelDescription]];
    [objectModel addObjectDescription:[self rearRightWheelDescription]];
    [objectModel addObjectDescription:[self wheelsDescription]];
    
    [objectModel addRelationshipDescription:carToEngine];
    [objectModel addRelationshipDescription:carToRadio];
    [objectModel addRelationshipDescription:carToWheels];
    [objectModel addRelationshipDescription:wheelsToFrontLeftWheel];
    [objectModel addRelationshipDescription:wheelsToFrontRightWheel];
    [objectModel addRelationshipDescription:wheelsToRearLeftWheel];
    [objectModel addRelationshipDescription:wheelsToRearRightWheel];
    
    [[RVTRadioModule new] addToObjectModel:objectModel];
}

- (RVTObjectDescription *)carDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""];
}

- (RVTObjectDescription *)engineDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTEngine class] identifier:@""];
}

- (RVTObjectDescription *)radioDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTRadio class] identifier:@""];
}

- (RVTObjectDescription *)frontLeftWheelDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTWheel class] identifier:@"Front Left Wheel"];
}

- (RVTObjectDescription *)frontRightWheelDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTWheel class] identifier:@"Front Right Wheel"];
}

- (RVTObjectDescription *)rearLeftWheelDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTWheel class] identifier:@"Rear Left Wheel"];
}

- (RVTObjectDescription *)rearRightWheelDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[RVTWheel class] identifier:@"Rear Right Wheel"];
}

- (RVTObjectDescription *)wheelsDescription
{
    return [RVTObjectDescription objectDescriptionWithClass:[NSArray class] identifier:@"Wheels"];
}

@end
