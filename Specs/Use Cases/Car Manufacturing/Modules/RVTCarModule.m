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
    RVTObjectDescription *carDescription             = [RVTObjectDescription objectDescriptionWithClass:[RVTCar    class] identifier:@""];
    RVTObjectDescription *engineDescription          = [RVTObjectDescription objectDescriptionWithClass:[RVTEngine class] identifier:@""];
    RVTObjectDescription *radioDescription           = [RVTObjectDescription objectDescriptionWithClass:[RVTRadio  class] identifier:@""];
    RVTObjectDescription *frontLeftWheelDescription  = [RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@"Front Left Wheel"];
    RVTObjectDescription *frontRightWheelDescription = [RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@"Front Right Wheel"];
    RVTObjectDescription *rearLeftWheelDescription   = [RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@"Rear Left Wheel"];
    RVTObjectDescription *rearRightWheelDescription  = [RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@"Rear Right Wheel"];
    RVTObjectDescription *wheelsDescription          = [RVTObjectDescription objectDescriptionWithClass:[NSArray   class] identifier:@"Wheels"];
    
    [self declareThat:carDescription dependsOn:engineDescription];
    [self declareThat:carDescription dependsOn:radioDescription];
    [self declareThat:carDescription dependsOn:wheelsDescription];
    
    [self useFactory:[RVTCarFactory    new] toCreateInstancesOf:carDescription];
    [self useFactory:[RVTEngineFactory new] toCreateInstancesOf:engineDescription];
    [self useFactory:[RVTRadioFactory  new] toCreateInstancesOf:radioDescription];
    [self useFactory:[RVTWheelFactory  new] toCreateInstancesOf:frontLeftWheelDescription];
    [self useFactory:[RVTWheelFactory  new] toCreateInstancesOf:frontRightWheelDescription];
    [self useFactory:[RVTWheelFactory  new] toCreateInstancesOf:rearLeftWheelDescription];
    [self useFactory:[RVTWheelFactory  new] toCreateInstancesOf:rearRightWheelDescription];
    [self useFactory:[RVTWheelsFactory new] toCreateInstancesOf:wheelsDescription];
    
    [self require:[RVTRadioModule class]];
}

@end
