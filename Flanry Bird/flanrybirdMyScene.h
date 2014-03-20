//
//  flanrybirdMyScene.h
//  Flanry Bird
//

//  Copyright (c) 2014年 Pengsheng Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface flanrybirdMyScene : SKScene{
    SKSpriteNode *plane;
    SKSpriteNode *ground;
    SKSpriteNode *bg;
    SKSpriteNode *pipe1_up;
    SKSpriteNode *pipe1_down;
    SKSpriteNode *pipe2_up;
    SKSpriteNode *pipe2_down;
    SKSpriteNode *pipe3_up;
    SKSpriteNode *pipe3_down;
    
    SKLabelNode *no_label;
    
    float currentY;
    float changeY;
    int radNo1;
    int radNo2;
    int radNo3;
    
    BOOL isGoingUp;
    
    float slowdown;
    float speedup;
    float angleup;
    float angledown;
    float angledownspeedup;
}

-(id)initWithSize:(CGSize)size andPoint: (float)angle;

@end
