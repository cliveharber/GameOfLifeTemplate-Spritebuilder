//
//  Grid.m
//  GameOfLife
//
//  Created by Clive on 13/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid
{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter
{
    [super onEnter];
    [self setupGrid];
    
    self.userInteractionEnabled = YES;
}

-(void)setupGrid
{
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j =0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x, y);
            
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            
            //creature.isAlive = YES;
            
            x+= _cellWidth;
        }
        
        y += _cellHeight;
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];
}

-(void)evolveStep
{
    [self countNeighbours];
    
    [self updateCreatures];
    
    _generation++;
}

-(void)countNeighbours
{
    for (int i = 0; i < [_gridArray count]; i++) {
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            currentCreature.livingNeighbours = 0;
            
            for (int x = (i-1); x <= (i+1); x++) {
                for (int y = (j-1); y <= (j+1); y++) {
                    BOOL isIndexValid;
                    
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    if (!((x == i) && (y == j)) && isIndexValid) {
                        Creature *neighbour = _gridArray[x][y];
                        if (neighbour.isAlive) {
                            currentCreature.livingNeighbours += 1;
                        }
                    }
                }
            }
        }
    }
}

-(BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        isIndexValid = NO;
    }
    return isIndexValid;
}

-(void)updateCreatures
{
    int numAlive = 0;
    
    for (int i = 0; i < [_gridArray count]; i++) {
        for (int j = 0; j < [_gridArray[i] count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            if (3 == currentCreature.livingNeighbours) {
                currentCreature.isAlive = YES;
            } else {
                if (currentCreature.livingNeighbours <= 1 || currentCreature.livingNeighbours >= 4) {
                    currentCreature.isAlive = NO;
                }
            }
            if (currentCreature.isAlive) {
                numAlive += 1;
            }
        }
    }
    _totalAlive = numAlive;
}

@end
