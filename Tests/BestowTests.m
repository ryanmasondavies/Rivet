//
//  BestowTests.m
//  BestowTests
//
//  Created by Ryan Davies on 01/05/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

#import "BestowTests.h"

@class Car, Driver, Engine, Wheel;

@interface Car : NSObject
- (id)initWithDriver:(Driver *)driver engine:(Engine *)engine wheels:(NSArray *)wheels;
@end

@implementation Car

- (id)initWithDriver:(Driver *)driver engine:(Engine *)engine wheels:(NSArray *)wheels
{
    if (self = [self init]) {
        NSLog(@"Car initialized with %@, %@, %@", driver, engine, wheels);
    }
    return self;
}

@end

@interface Driver : NSObject; @end
@implementation Driver; @end

@interface Engine : NSObject; @end
@implementation Engine; @end

@interface Wheel : NSObject; @end
@implementation Wheel; @end

@protocol Provider <NSObject>
- (id)get;
@end

@interface CarProvider : NSObject <Provider>

- (id)initWithDriver:(Driver *)driver engine:(Engine *)engine wheels:(NSArray *)wheels;

@property (strong, nonatomic) Driver *driver;
@property (strong, nonatomic) Engine *engine;
@property (strong, nonatomic) NSArray *wheels;

@end

@implementation CarProvider

- (id)initWithDriver:(Driver *)driver engine:(Engine *)engine wheels:(NSArray *)wheels
{
    if (self = [self init]) {
        NSLog(@"Car provider initialized with %@, %@, %@", driver, engine, wheels);
        self.driver = driver;
        self.engine = engine;
        self.wheels = wheels;
    }
    return self;
}

- (id)get
{
    return [[Car alloc] initWithDriver:[self driver] engine:[self engine] wheels:[self wheels]];
}

@end

@interface DriverProvider : NSObject <Provider>

- (id)initWithName:(NSString *)name;

@end

@implementation DriverProvider

- (id)initWithName:(NSString *)name
{
    if (self = [self init]) {
        NSLog(@"Driver provider with %@", [name substringFromIndex:0]);
    }
    return self;
}

- (id)get
{
    return [[Driver alloc] init];
}

@end

@interface Injector : NSObject
@property (strong, nonatomic) NSMutableDictionary *definitions;
@end

@implementation Injector

- (id)init
{
    if (self = [super init]) {
        self.definitions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)createInstancesOf:(Class)klass usingProvider:(Class)providerClass
{
    __block Injector *injector = self;
    self.definitions[NSStringFromClass(klass)] = ^{
        return [[injector createInstanceOf:providerClass] get];
    };
}

- (void)createInstancesOf:(Class)klass usingInitializer:(SEL)initializer withInstancesOf:(NSArray *)argumentClasses
{
    __block Injector *injector = self;
    self.definitions[NSStringFromClass(klass)] = ^{
        NSMutableArray *arguments = [[NSMutableArray alloc] init];
        for (Class argumentClass in argumentClasses) {
            [arguments addObject:[injector createInstanceOf:argumentClass]];
        }
        
        NSMethodSignature *methodSignature = [klass instanceMethodSignatureForSelector:initializer];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setSelector:initializer];
        for (NSUInteger index = 0; index < [arguments count]; index ++) {
            id argument = arguments[index];
            [invocation setArgument:&argument atIndex:index + 2];
        }
        [invocation retainArguments];
        
        id instance = [klass alloc];
        [invocation invokeWithTarget:instance];
        
        id returnValue = nil;
        [invocation getReturnValue:&returnValue];
        
        return returnValue;
    };
}

- (void)createInstancesOf:(Class)klass usingInitializer:(SEL)initializer withValues:(NSArray *)values
{
    self.definitions[NSStringFromClass(klass)] = ^{
        NSMethodSignature *methodSignature = [klass instanceMethodSignatureForSelector:initializer];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setSelector:initializer];
        for (NSUInteger index = 0; index < [values count]; index ++) {
            id value = values[index];
            [invocation setArgument:&value atIndex:index + 2];
        }
        [invocation retainArguments];
        
        id instance = [klass alloc];
        [invocation invokeWithTarget:instance];
        
        id returnValue = nil;
        [invocation getReturnValue:&returnValue];
        
        return returnValue;
    };
}

- (id)createInstanceOf:(Class)klass
{
    id(^construction)(void) = [self definitions][NSStringFromClass(klass)];
    if (construction) {
        return construction();
    } else {
        return [[klass alloc] init];
    }
}

@end

@implementation BestowTests

- (void)test
{
    Injector *injector = [[Injector alloc] init];
    
    [injector createInstancesOf:[CarProvider class] usingInitializer:@selector(initWithDriver:engine:wheels:) withInstancesOf:@[[Driver class], [Engine class], [NSArray class]]];
    [injector createInstancesOf:[DriverProvider class] usingInitializer:@selector(initWithName:) withValues:@[@"John Smith"]];
    [injector createInstancesOf:[Car class] usingProvider:[CarProvider class]];
    [injector createInstancesOf:[Driver class] usingProvider:[DriverProvider class]];
    
    [injector createInstanceOf:[Car class]];
}

@end
