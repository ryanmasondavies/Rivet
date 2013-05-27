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

#import "RVTModule.h"
#import "RVTConfiguration.h"
#import "RVTObjectDescription.h"
#import "RVTObjectFactory.h"
#import "RVTObjectModel.h"
#import "RVTRelationshipDescription.h"

@interface RVTModule ()
@property (strong, nonatomic, readwrite) RVTObjectModel *objectModel;
@property (strong, nonatomic, readwrite) RVTConfiguration *configuration;
@end

@implementation RVTModule

- (id)initWithObjectModel:(RVTObjectModel *)objectModel configuration:(RVTConfiguration *)configuration
{
    if (self = [self init]) {
        self.objectModel = objectModel;
        self.configuration = configuration;
    }
    return self;
}

- (void)configure
{
}

- (void)define:(RVTObjectDescription *)objectDescription
{
    [[self objectModel] addObjectDescription:objectDescription];
}

- (void)declareThat:(RVTObjectDescription *)sourceObjectDescription dependsOn:(RVTObjectDescription *)destinationObjectDescription
{
    [self define:sourceObjectDescription];
    [self define:destinationObjectDescription];
    [[self objectModel] addRelationshipDescription:[RVTRelationshipDescription relationshipDescriptionWithSourceObjectDescription:sourceObjectDescription destinationObjectDescription:destinationObjectDescription]];
}

- (void)useFactory:(RVTObjectFactory *)factory toCreateInstancesOf:(RVTObjectDescription *)objectDescription
{
    [[self configuration] setFactory:factory forObjectDescription:objectDescription];
}

- (void)require:(Class)moduleClass
{
    [[[moduleClass alloc] initWithObjectModel:[self objectModel] configuration:[self configuration]] configure];
}

@end
