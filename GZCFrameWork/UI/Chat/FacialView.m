//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacialView.h"
#import "UIImage+Resize.h"

@implementation FacialView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        faces=[EmojiEmoticons allEmoticons];
        faces=[Emoji allEmoji];
//        faces=[EmojiPictographs allPictographs];
    }
    return self;
}

-(void)loadFacialView:(int)page size:(CGSize)size
{
	//row number
    float offx = 0;
    float offy = 0;
    float spaceX = (self.frame.size.width - size.width*9)/8;
    for (int i=0; i<36; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setFrame:CGRectMake(offx, offy, size.width, size.height)];
        button.imageView.contentMode = UIViewContentModeCenter;
        if (i==35) {
            [button setImage:[[UIImage imageNamed:@"faceDelete"] reSizeToSize:CGSizeMake(size.width, size.width*0.6)] forState:UIControlStateNormal];
            button.tag=10000;
        }else{
            [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
            [button setTitle: [faces objectAtIndex:i+(page*19)]forState:UIControlStateNormal];
            button.tag=i+(page*19);
        }
        offx += size.width + spaceX ;
        if (offx>self.frame.size.width) {
            offx = 0;
            offy += size.height;
        }
        [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
//	for (int i=0; i<4; i++) {
//		//column numer
//		for (int y=0; y<9; y++) {
//			UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//            [button setBackgroundColor:[UIColor clearColor]];
//            [button setFrame:CGRectMake(y*size.width, i*size.height, size.width, size.height)];
//            if (i==3&&y==8) {
//                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
//                button.tag=10000;
//                
//            }else{
//                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
//                [button setTitle: [faces objectAtIndex:i*3+y+(page*19)]forState:UIControlStateNormal];
//                button.tag=i*3+y+(page*19);
//            }
//			[button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
//			[self addSubview:button];
//		}
//	}
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag==10000) {
//        NSLog(@"点击删除");
        [delegate selectedFacialView:@"删除"];
    }else{
        NSString *str=[faces objectAtIndex:bt.tag];
//        NSLog(@"点击其他%@",str);
        [delegate selectedFacialView:str];
    }	
}
@end
