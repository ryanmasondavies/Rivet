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

#import "RVTObjectGraphFactory.h"
#import "RVTConfiguration.h"
#import "RVTObjectDescription.h"
#import "RVTObjectFactory.h"
#import "RVTObjectModel.h"
#import "RVTObjectPool.h"
#import "RVTRelationshipDescription.h"

@interface RVTObjectGraphFactory ()
@property (strong, nonatomic, readwrite) RVTConfiguration *configuration;
@property (strong, nonatomic, readwrite) RVTObjectModel   *objectModel;
@end

@implementation RVTObjectGraphFactory

+ (id)objectGraphFactoryWithConfiguration:(RVTConfiguration *)configuration objectModel:(RVTObjectModel *)objectModel
{
    return [[self alloc] initWithConfiguration:configuration objectModel:objectModel];
}

- (id)initWithConfiguration:(RVTConfiguration *)configuration objectModel:(RVTObjectModel *)objectModel
{
    if (self = [self init]) {
        self.configuration = configuration;
        self.objectModel   = objectModel;
    }
    return self;
}

- (id)createObjectWithDescription:(RVTObjectDescription *)objectDescription pool:(RVTObjectPool *)pool
{
    NSMutableDictionary *dependencies = [NSMutableDictionary dictionary];
    for (RVTRelationshipDescription *relationship in [[self objectModel] relationshipDescriptionsWithSourceObjectDescription:objectDescription]) {
        RVTObjectDescription *dependencyDescription = [relationship destinationObjectDescription];
        dependencies[dependencyDescription] = [pool objectWithDescription:dependencyDescription];
    }
    
    RVTObjectFactory *factory = [[self configuration] factoryForObjectDescription:objectDescription];
    return [factory createObjectWithDescription:objectDescription dependencies:dependencies];
}

@end
