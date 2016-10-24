// Copyright (c) 2015 RAMBLER&Co
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
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UserObjectIndexer.h"

#import "DataBase+CoreDataModel.h"

#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <RamblerSpotlight/RamblerSpotlight.h>

@implementation UserObjectIndexer

#pragma mark - Overriden methods

- (BOOL)canIndexObjectWithType:(NSString *)objectType {
    return [objectType isEqualToString:NSStringFromClass([User class])];
}

- (CSSearchableItem *)searchableItemForObject:(User *)object {
    if (!object.name) {
        return nil;
    }
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeJSON];
    attributeSet.title = object.name;
    
    
    NSArray *keywords = [self generateKeywordsForUser:object];
    attributeSet.keywords = keywords;
    
    NSString *uniqueIdentifier = [self identifierForObject:object];
    NSString *domainIdentifier = NSStringFromClass([User class]);
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:uniqueIdentifier
                                                               domainIdentifier:domainIdentifier
                                                                   attributeSet:attributeSet];
    item.expirationDate = [NSDate distantFuture];
    return item;
}

#pragma mark - Private methods

- (NSArray *)generateKeywordsForUser:(User *)user {
    NSMutableArray *keywords = [NSMutableArray new];
    [keywords addObject:user.name];

    return [keywords copy];
}

@end
