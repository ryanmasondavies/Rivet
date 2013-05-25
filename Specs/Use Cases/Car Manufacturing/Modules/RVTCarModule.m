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
    [configuration setFactory:[RVTCarFactory    new] forDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar    class] identifier:@""]];
    [configuration setFactory:[RVTEngineFactory new] forDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTEngine class] identifier:@""]];
    [configuration setFactory:[RVTRadioFactory  new] forDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTRadio  class] identifier:@""]];
    [configuration setFactory:[RVTWheelFactory  new] forDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@""]];
    [configuration setFactory:[RVTWheelsFactory new] forDescription:[RVTObjectDescription objectDescriptionWithClass:[NSArray   class] identifier:@"Wheels"]];
    
    [[RVTRadioModule new] addToConfiguration:configuration];
}

- (void)addToObjectModel:(RVTObjectModel *)objectModel
{
    [objectModel addObjectDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar    class] identifier:@""]];
    [objectModel addObjectDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTEngine class] identifier:@""]];
    [objectModel addObjectDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTRadio  class] identifier:@""]];
    [objectModel addObjectDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTWheel  class] identifier:@""]];
    [objectModel addObjectDescription:[RVTObjectDescription objectDescriptionWithClass:[NSArray   class] identifier:@"Wheels"]];
    
    [[RVTRadioModule new] addToObjectModel:objectModel];
}

@end
