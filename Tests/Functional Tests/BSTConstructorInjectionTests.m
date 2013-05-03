//
//  BestowTests.m
//  BestowTests
//
//  Created by Ryan Davies on 01/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

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
