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

#import "RVTRelationshipDescription.h"
#import "RVTObjectDescription.h"

@interface RVTRelationshipDescription ()
@property (strong, nonatomic, readwrite) RVTObjectDescription *sourceObjectDescription;
@property (strong, nonatomic, readwrite) RVTObjectDescription *destinationObjectDescription;
@end

@implementation RVTRelationshipDescription

+ (id)relationshipDescriptionWithSourceObjectDescription:(RVTObjectDescription *)sourceObjectDescription destinationObjectDescription:(RVTObjectDescription *)destinationObjectDescription
{
    return [[self alloc] initWithSourceObjectDescription:sourceObjectDescription destinationObjectDescription:destinationObjectDescription];
}

- (id)initWithSourceObjectDescription:(RVTObjectDescription *)sourceObjectDescription destinationObjectDescription:(RVTObjectDescription *)destinationObjectDescription
{
    if (self = [self init]) {
        self.sourceObjectDescription = sourceObjectDescription;
        self.destinationObjectDescription = destinationObjectDescription;
    }
    return self;
}

@end
