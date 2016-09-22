//
//  SetCard.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (instancetype)initWithNumber:(SetNumber)number symbol:(SetSymbol)symbol shading:(SetShading)shading color:(SetColor)color {
    self = [super init];
    if (self) {
        _number = number;
        _symbol = symbol;
        _shading = shading;
        _color = color;
    }
    return [self isValid] ? self : nil;
}

- (BOOL)isValid {
    if (self.number < FirstNumber || self.number > LastNumber) return NO;
    if (self.symbol < FirstSymbol || self.symbol > LastSymbol) return NO;
    if (self.shading < FirstShading || self.shading > LastShading) return NO;
    if (self.color < FirstColor || self.color > LastColor) return NO;
    return YES;
}

- (int)match:(NSArray *)otherCards {
    if (otherCards.count == 2) {
        SetCard *cardA = otherCards.firstObject;
        SetCard *cardB = otherCards.lastObject;

        BOOL numberMatch = [SetCard areThreeEqualValues:self.number, cardA.number, cardB.number];
        BOOL symbolMatch = [SetCard areThreeEqualValues:self.symbol, cardA.symbol, cardB.symbol];
        BOOL shadingMatch = [SetCard areThreeEqualValues:self.shading, cardA.shading, cardB.shading];
        BOOL colorMatch = [SetCard areThreeEqualValues:self.color, cardA.color, cardB.color];

        int matchCount = numberMatch + symbolMatch + shadingMatch + colorMatch;
        if (matchCount != 1) {
            return 0;
        }
        
        BOOL numberDiff = [SetCard areThreeDifferentValues:self.number, cardA.number, cardB.number];
        BOOL symbolDiff = [SetCard areThreeDifferentValues:self.symbol, cardA.symbol, cardB.symbol];
        BOOL shadingDiff = [SetCard areThreeDifferentValues:self.shading, cardA.shading, cardB.shading];
        BOOL colorDiff = [SetCard areThreeDifferentValues:self.color, cardA.color, cardB.color];

        if (numberMatch && (symbolDiff + shadingDiff + colorDiff) == 3) return 1;
        if (symbolMatch && (numberDiff + shadingDiff + colorDiff) == 3) return 1;
        if (shadingMatch && (symbolDiff + numberDiff + colorDiff) == 3) return 1;
        if (colorMatch && (symbolDiff + shadingDiff + numberDiff) == 3) return 1;
    }
    return 0;
}

+ (BOOL) areThreeEqualValues:(NSInteger)first, ... {
    va_list args;
    va_start(args, first);
    
    NSInteger second = va_arg(args, NSInteger);
    NSInteger third = va_arg(args, NSInteger);
    
    va_end(args);
    
    return first == second && second == third;
}

+ (BOOL) areThreeDifferentValues:(NSInteger)first, ... {
    va_list args;
    va_start(args, first);
    
    NSInteger second = va_arg(args, NSInteger);
    NSInteger third = va_arg(args, NSInteger);
    
    va_end(args);
    
    return first != second && first != third && second != third;
}

@end
