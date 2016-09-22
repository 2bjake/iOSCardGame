//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardMatchingGame;
@class Card;


@interface CardGameViewController : UIViewController

@property (nonatomic, readonly) NSUInteger cardCount;

- (CardMatchingGame *)createGame; //abstract, subclass must implement
- (void)drawCard:(Card *)card onButton:(UIButton *)button; //abstract, subclass must implement
- (void)updateUI;

@end

