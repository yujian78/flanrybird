//
//  fail.m
//  Flanry Bird
//
//  Created by Pengsheng Guo on 16/03/14.
//  Copyright (c) 2014年 Pengsheng Guo. All rights reserved.
//

#import "fail.h"
#import "flanrybirdMyScene.h"

@implementation fail
-(id)initWithSize:(CGSize)size andPoint:(int)point {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.125 green:0.711 blue:0.766 alpha:1.0];
        
        
        SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Light"];
        
        myLabel2.text = @"restart";
        myLabel2.fontSize = 20;
        myLabel2.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
        myLabel2.name = @"enter";
        
        SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Light"];
        
        myLabel3.text = [NSString stringWithFormat:@"%d",point];
        myLabel3.fontSize = 25;
        myLabel3.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame) -  40);
        
        SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Light"];
        if (point < 10) {
            myLabel4.text = @"瞎了，还没玩到10你不羞愧么";
        }
        else if(point < 20){
            myLabel4.text = @"你已经打败全世界5%的人类";
        }
        else if(point < 30){
            myLabel4.text = @"不错哦，点个赞";
        }
        else if(point < 40){
            myLabel4.text = @"你已经逐渐接近人类的巅峰了";
        }
        else if(point < 50){
            myLabel4.text = @"我选你！你已经跟人类巅峰 -- GPS的记录一样了";
        }
        else{
            myLabel4.text = @"好吧，你牛逼你伟大";
        }
        
        
        
        myLabel4.fontSize = 20;
        myLabel4.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame) +  60);
        
        
        [self addChild:myLabel2];
        [self addChild:myLabel3];
        [self addChild:myLabel4];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"enter"]) {
        SKView *skView = (SKView *)self.view;
        SKScene *scence = [[flanrybirdMyScene alloc] initWithSize:self.frame.size andPoint:(float)0.0];
        scence.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scence];
    }
    
}



@end
