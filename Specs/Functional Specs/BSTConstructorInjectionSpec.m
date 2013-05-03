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

#import "BSTCar.h"
#import "BSTDriver.h"
#import "BSTEngine.h"

@interface BSTConstructorInjectionTests : NSObject
@end

@implementation BSTConstructorInjectionTests

- (void)test
{
//    id<BSTAnnotation> wheelsAnnotation = [[BSTArgumentAnnotation alloc] initWithName:@"Wheels" selector:@selector(initWithDriver:engine:wheels:) argument:2];
//    id<BSTDefinition> carDefinition = [[BSTClassDefinition alloc] initWithClass:[BSTCar class] initializer:@selector(initWithDriver:engine:wheels:) arguments:@[[BSTDriver class], [BSTEngine class], [NSString class]]];
//    id<BSTBinding> driverBinding = [[BSTClassBinding alloc] initWithInterfaceClass:[BSTEngine class] implementationClass:[BSTV6Engine class]];
//    
//    // argument annotations, used to inject specific values
//    NSArray *annotations = @[wheelsAnnotation];
//    
//    // which implementation classes to construct for interfaces
//    NSArray *bindings = @[driverBinding];
//    
//    // dependency list for classes
//    NSArray *definitions = @[carDefinition];
//    
//    BSTInjector *injector = [[BSTInjector alloc] initWithAnnotations:annotations bindings:bindings definitions:definitions];
//    NSLog(@"Created car %@", [injector getInstanceOf:[Car class]]);
}

@end
