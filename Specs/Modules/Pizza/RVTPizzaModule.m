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

#import "RVTPizzaModule.h"
#import "RVTAnchovies.h"
#import "RVTCheese.h"
#import "RVTIngredientsProvider.h"
#import "RVTPepperoni.h"
#import "RVTPineapple.h"
#import "RVTPizza.h"

@interface RVTPizzaModule ()
@property (strong, nonatomic) id<RVTScope> noScope;
@end

@implementation RVTPizzaModule

- (id)init
{
    if (self = [super init]) {
        self.noScope = [[RVTNoScope alloc] init];
    }
    return self;
}

- (RVTDependencyMap *)dependencies
{
    RVTDependencyMap *dependencies = [[RVTDependencyMap alloc] init];
    dependencies[[RVTPizza class]] = [self pizza];
    return dependencies;
}

- (RVTDependency *)anchovies
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTAnchovies class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)cheese
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTCheese class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)pepperoni
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTPepperoni class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)pineapple
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTPineapple class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)ingredientsProvider
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithAnchovies:cheese:pepperoni:pineapple:) dependencies:@[[self anchovies], [self cheese], [self pepperoni], [self pineapple]]];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTIngredientsProvider class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)ingredients
{
    id<RVTProvider> provider = [[RVTResolver alloc] initWithDependency:[self ingredientsProvider]];
    provider = [[RVTExtractor alloc] initWithProvider:provider];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)pizza
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithIngredients:) dependencies:@[[self ingredients]]];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTPizza class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

@end
