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


#import "UserObjectTransformer.h"

#import "DataBase+CoreDataModel.h"
#import <RamblerSpotlight/RamblerSpotlight.h>

@implementation UserObjectTransformer

#pragma mark - <ObjectTransformer>

- (NSString *)identifierForObject:(User *)object {
    NSString *objectType = NSStringFromClass([User class]);
    NSString *userName = object.name;
    NSString *identifier = [NSString stringWithFormat:@"%@%@%@", objectType, RSIdentifierSeparator, userName];
    return identifier;
}

- (User *)objectForIdentifier:(NSString *)identifier {
    NSString *userName = [[identifier componentsSeparatedByString:RSIdentifierSeparator] lastObject];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", userName]];
    NSArray *results = [self.context executeFetchRequest:request
                                              error:nil];
    if ([results count] == 0) {
        return nil;
    }
    User *user = [results firstObject];
    
    return user;
}

- (BOOL)isCorrectIdentifier:(NSString *)identifier {
    NSString *objectType = NSStringFromClass([User class]);
    
    BOOL hasCorrectObjectType = [identifier rangeOfString:objectType].location != NSNotFound;
    
    BOOL hasSeparator = [identifier rangeOfString:RSIdentifierSeparator].location != NSNotFound;
    
    NSUInteger userIdLocation = objectType.length + 1; // 1 for . symbol
    NSInteger userIdLength = identifier.length - userIdLocation;
    BOOL hasUserId = userIdLength > 0;
    
    return hasCorrectObjectType && hasSeparator && hasUserId;
}


@end
