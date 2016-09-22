//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardMatchingGame.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad {
    [self updateUI];
}

- (CardMatchingGame *)createGame {
    return [[SetCardMatchingGame alloc] init];
}

- (void)drawCard:(Card *)card onButton:(UIButton *)button {
    UIImage *background = [UIImage imageNamed: (card.isChosen ? @"selectedcardfront" : @"cardfront")];
    [button setBackgroundImage:background forState:UIControlStateNormal];
    NSAttributedString *content = [self createContentForCard:(SetCard*)card];
    [button setAttributedTitle:content forState:UIControlStateNormal];
    button.enabled = !card.isMatched;
}

- (NSAttributedString *) createContentForCard:(SetCard *)card {
    NSString *str = [@"" stringByPaddingToLength:card.number withString: [self symbolForCard:card] startingAtIndex:0];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange(0, str.length);
    [astr setAttributes:[self attributesForCard:card] range:range];
    return astr;
}

- (NSDictionary *)attributesForCard:(SetCard *)card {
    NSMutableDictionary * attributes = [[NSMutableDictionary alloc] init];
    UIColor *color = [self colorForCard:card];
    
    if (card.shading == Open) {
        attributes[NSStrokeWidthAttributeName] = @-5;
        attributes[NSStrokeColorAttributeName] = color;
        attributes[NSForegroundColorAttributeName] = [color colorWithAlphaComponent:0];
    } else if (card.shading == Solid) {
        attributes[NSForegroundColorAttributeName] = color;
    } else {
        attributes[NSForegroundColorAttributeName] = [color colorWithAlphaComponent:0.25];
    }
    
    return attributes;
}

- (NSString *)symbolForCard:(SetCard *)card {
    if (card.symbol == Triangle) {
        return @"▲";
    } else if (card.symbol == Square) {
        return @"■";
    } else if (card.symbol == Circle) {
        return @"●";
    } else {
        return @"?";
    }
}

- (UIColor *)colorForCard:(SetCard *)card {
    UIColor *color = nil;
    if (card.color == Red) {
        color = [UIColor redColor];
    } else if (card.color == Green) {
        color = [UIColor greenColor];
    } else if (card.color == Purple) {
        color = [UIColor purpleColor];
    }
    return color;
}




@end
