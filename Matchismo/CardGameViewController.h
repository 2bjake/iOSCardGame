//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deck;

@interface CardGameViewController : UIViewController
- (Deck *)createDeck; //abstract, subclass must implement
@end

