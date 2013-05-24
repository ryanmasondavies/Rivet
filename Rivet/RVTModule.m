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
#import "RVTFactory.h"
#import "RVTModule.h"
#import "RVTProduct.h"

@interface RVTModule ()
@property (strong, nonatomic, readwrite) NSMutableArray *modules;
@property (strong, nonatomic, readwrite) NSMutableDictionary *factoryMap;
@end

@implementation RVTModule

- (NSMutableArray *)modules
{
    if (_modules) return _modules;
    _modules = [[NSMutableArray alloc] init];
    [self declareModules];
    return _modules;
}

- (NSMutableDictionary *)factoryMap
{
    if (_factoryMap) return _factoryMap;
    _factoryMap = [[NSMutableDictionary alloc] init];
    [self declareFactories];
    return _factoryMap;
}

- (void)declareModules
{
}

- (void)declareFactories
{
}

- (void)addModule:(RVTModule *)module
{
    [[self modules] addObject:module];
}

- (void)setFactory:(RVTFactory *)factory forProduct:(RVTProduct *)product
{
    [[self factoryMap] setObject:factory forKey:product];
}

- (RVTFactory *)factoryForProduct:(RVTProduct *)product
{
    RVTFactory *factory = nil;
    
    NSLog(@"Find factory in %@", [self factoryMap]);
    
    // look for one in the factory map
    for (RVTProduct *potential in [[self factoryMap] allKeys]) {
        if ([potential isApplicableToProduct:product]) {
            factory = [[self factoryMap] objectForKey:potential];
        }
    }
    
    // look for one in the submodules
    if (!factory) {
        for (RVTModule *module in [self modules]) {
            factory = [module factoryForProduct:product];
        }
    }
    
    return factory;
}

- (id)supplyProduct:(RVTProduct *)product
{
    RVTFactory *factory = [self factoryForProduct:product];
    if (!factory) {
        NSString *reason = [NSString stringWithFormat:@"No factory for %@", product];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
    }
    return [factory supplyProduct:product inModule:self];
}

@end
