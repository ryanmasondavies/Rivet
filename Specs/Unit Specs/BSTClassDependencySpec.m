#import "BSTCar.h"

SpecBegin(BSTClassDependency)

it(@"creates an instance of its class", ^{
    id<BSTDependency> dependency = [[BSTClassDependency alloc] initWithClass:[BSTCar class] initializer:@selector(initWithDriver:engine:wheels:) argumentProviders:nil];
    id product = [dependency resolve];
    [[@(product != nil) should] beTrue];
    [[product should] beKindOfClass:[BSTCar class]];
});

it(@"retrieves arguments from providers", PENDING);

SpecEnd
