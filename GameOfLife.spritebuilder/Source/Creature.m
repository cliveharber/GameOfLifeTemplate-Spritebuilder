//
//  Creature.m
//  GameOfLife
//
//  Created by Clive on 13/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature
{
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)newState
{
    _isAlive = newState;
    
    self.visible = _isAlive;
}

@end
