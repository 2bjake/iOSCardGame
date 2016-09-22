//
//  SetCard.h
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSInteger, SetSymbol) {
    FirstSymbol = 0,
    
    Triangle = FirstSymbol,
    Circle,
    Square,
    
    LastSymbol = Square
};

typedef NS_ENUM(NSInteger, SetColor) {
    FirstColor = 0,
    
    Red = FirstColor,
    Green,
    Purple,
    
    LastColor = Purple
};

typedef NS_ENUM(NSInteger, SetShading) {
    FirstShading = 0,
    
    Solid = FirstShading,
    Striped,
    Open,
    
    LastShading = Open
};

typedef NS_ENUM(NSInteger, SetNumber) {
    FirstNumber = 1,
    
    ONE = FirstNumber,
    TWO,
    THREE,
    
    LastNumber = THREE
};

@interface SetCard : Card

@property (nonatomic, readonly) SetNumber number;
@property (nonatomic, readonly) SetSymbol symbol;
@property (nonatomic, readonly) SetShading shading;
@property (nonatomic, readonly) SetColor color;

- (instancetype)initWithNumber:(SetNumber)number symbol:(SetSymbol)symbol shading:(SetShading)shading color:(SetColor)color;

@end
