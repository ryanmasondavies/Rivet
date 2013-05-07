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

#import "RVTCar.h"
#import "RVTDriver.h"
#import "RVTEngine.h"
#import "RVTWheel.h"
#import "RVTWheelsProvider.h"

@interface RVTConstructorInjectionTests : SenTestCase
@end

@implementation RVTConstructorInjectionTests

//- (id<RVTProvider>)carWithInjector:(RVTInjector *)injector
//{
//    NSMutableArray *providers = [[NSMutableArray alloc] init];
//    providers[0] = [[RVTInjectionProvider alloc] initWithClass:[RVTDriver class] injector:injector];
//    providers[1] = [[RVTInjectionProvider alloc] initWithClass:[RVTEngine class] injector:injector];
//    providers[2] = [[RVTRecursiveProvider alloc] initWithProvider:[[RVTInjectionProvider alloc] initWithClass:[RVTWheelsProvider class] injector:injector] recursions:2];
//    return [[RVTInitializedObjectProvider alloc] initWithClass:[RVTCar class] selector:@selector(initWithDriver:engine:wheels:) providers:providers];
//}
//
//- (id<RVTProvider>)driverWithInjector:(RVTInjector *)injector
//{
//    NSMutableArray *providers = [[NSMutableArray alloc] init];
//    providers[0] = [[RVTValueProvider alloc] initWithValue:@"John Smith"];
//    return [[RVTInitializedObjectProvider alloc] initWithClass:[RVTDriver class] selector:@selector(initWithName:) providers:providers];
//}
//
//- (id<RVTProvider>)engineWithInjector:(RVTInjector *)injector
//{
//    return [[RVTInitializedObjectProvider alloc] initWithClass:[RVTEngine class] selector:@selector(init) providers:nil];
//}
//
//- (id<RVTProvider>)wheelsProviderWithInjector:(RVTInjector *)injector
//{
//    NSMutableArray *providers = [[NSMutableArray alloc] init];
//    providers[0] = [[RVTValueProvider alloc] initWithValue:[[RVTInjectionProvider alloc] initWithClass:[RVTWheel class] injector:injector]];
//    return [[RVTInitializedObjectProvider alloc] initWithClass:[RVTWheelsProvider class] selector:@selector(initWithWheelProvider:) providers:providers];
//}
//
//- (id<RVTProvider>)wheelWithInjector:(RVTInjector *)injector
//{
//    return [[RVTInitializedObjectProvider alloc] initWithClass:[RVTWheel class] selector:@selector(init) providers:nil];
//}
//
//- (void)test
//{
//    NSMutableDictionary *providers = [[NSMutableDictionary alloc] init];
//    RVTModule *module = [[RVTModule alloc] initWithProviders:providers];
//    RVTInjector *injector = [[RVTInjector alloc] initWithModule:module];
//    
//    module[[RVTCar    class]] = [self carWithInjector:injector];
//    module[[RVTDriver class]] = [self driverWithInjector:injector];
//    module[[RVTEngine class]] = [self engineWithInjector:injector];
//    module[[RVTWheel  class]] = [self wheelWithInjector:injector];
//    module[[RVTWheelsProvider class]] = [self wheelsProviderWithInjector:injector];
//    
//    NSLog(@"Injected car:    %@", [injector instanceOf:[RVTCar    class]]);
//    NSLog(@"Injected driver: %@", [injector instanceOf:[RVTDriver class]]);
//    NSLog(@"Injected engine: %@", [injector instanceOf:[RVTEngine class]]);
//    NSLog(@"Injected wheel:  %@", [injector instanceOf:[RVTWheel  class]]);
//}

@end
