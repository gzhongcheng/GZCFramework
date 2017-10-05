//
//  GZCAutoImagesView.m
//  JiuMei
//
//  Created by GuoZhongCheng on 16/4/11.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCAutoImagesView.h"
#import "GZCFramework.h"

@implementation GZCAutoImage

@end

@implementation GZCAutoImagesView{
    float imageWidth;
    float maxX,maxY;
    NSMutableDictionary *imageHeightDic;
    int loadedNumber;
    UIButton *addButton;
}

#define TAG_ADD 100

@synthesize imageViews;

-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame space:5];
}

-(instancetype)initWithFrame:(CGRect)frame space:(int)space{
    return [self initWithFrame:frame space:space type:GZCAutoImagesViewTypeNine];
}

-(instancetype)initWithFrame:(CGRect)frame space:(int)space type:(GZCAutoImagesViewType)type{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setTitle:@"＋" forState:UIControlStateNormal];
        [addButton setTitleColor:mainLightFontColor forState:UIControlStateNormal];
        [addButton setBackgroundColor:BG_COLOR];
        addButton.titleLabel.font = [UIFont systemFontOfSize:40];
        [addButton addTarget:self action:@selector(addButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        addButton.hidden = YES;
        self.contentSpace = space;
    }
    return self;
}

-(void)setType:(GZCAutoImagesViewType)type{
    _type = type;
    switch (type) {
        case GZCAutoImagesViewTypeNine:
        {
            float offX = 0,offY = 0;
            imageWidth = (WIDTH(self) - _contentSpace*2)/3;
            for (int i = 0; i<9 ; i++) {
                [self createImageViewWithFrame:CGRectMake(offX, offY, imageWidth, imageWidth) tag:i];
                offX += imageWidth+_contentSpace;
                if (i==2||i==5) {
                    offX = 0;
                    offY += imageWidth+_contentSpace;
                }
            }
            imageViews = self.subviews;
            break;
        }
        case GZCAutoImagesViewTypeVertical:{
            imageWidth = WIDTH(self);
            break;
        }
    }
}

-(void)setContentSpace:(int)contentSpace{
    _contentSpace = contentSpace;
    addButton.frame = CGRectMake(0, 0, (WIDTH(self) - _contentSpace*2)/3, (WIDTH(self) - _contentSpace*2)/3);
    
    switch (_type) {
        case GZCAutoImagesViewTypeNine:
        {
            float offX = 0,offY = 0;
            imageWidth = (WIDTH(self) - _contentSpace*2)/3;
            for (int i = 0; i<9 ; i++) {
                [self createImageViewWithFrame:CGRectMake(offX, offY, imageWidth, imageWidth) tag:i];
                offX += imageWidth+_contentSpace;
                if (i==2||i==5) {
                    offX = 0;
                    offY += imageWidth+_contentSpace;
                }
            }
            break;
        }
        case GZCAutoImagesViewTypeVertical:{
            break;
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(UIImageView *)createImageViewWithFrame:(CGRect)frame tag:(NSInteger)tag{
    UIImageView *view = [self viewWithTag:tag+TAG_ADD];
    if (view != nil) {
        view.frame = frame;
        return view;
    }
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:frame];
    imageV.tag = tag+TAG_ADD;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds = YES;
    imageV.backgroundColor = [UIColor grayColor];
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTaped:)];
    [imageV addGestureRecognizer:tap];
    UILongPressGestureRecognizer *lTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewLongPress:)];
    [imageV addGestureRecognizer:lTap];
    [self addSubview:imageV];
    return imageV;
}

-(void)setEnable:(BOOL)enable{
    _enable = enable;
    if (self.type == GZCAutoImagesViewTypeVertical) {
        return;
    }
    addButton.hidden = !enable;
}

-(void)setImageUrls:(NSArray<__kindof NSString *> *)imageUrls{
    _imageUrls = imageUrls;
    NSMutableArray *imgA = [NSMutableArray array];
    for (NSString *url in imageUrls) {
        GZCAutoImage *image = [GZCAutoImage new];
        image.imageUrl = url;
        [imgA addObject:image];
    }
    [self setImages:imgA];
}

+(float)getHeightWithImages:(NSArray<__kindof GZCAutoImage *> *)images space:(float)space type:(GZCAutoImagesViewType)type autoImagesViewWidth:(float)width{
    return [GZCAutoImagesView getHeightWithImages:images space:space type:type autoImagesViewWidth:width enable:NO];
}

+(float)getHeightWithImages:(NSArray<__kindof GZCAutoImage *> *)images space:(float)space type:(GZCAutoImagesViewType)type autoImagesViewWidth:(float)width enable:(BOOL)enable{
    float height = 0;
    switch (type) {
        case GZCAutoImagesViewTypeNine:{
            float imageWidth = (width - space*2)/3;
            NSInteger count =[images count];
            if (enable) {
                count ++;
            }
            height = imageWidth;
            if (count>3) {
                height = imageWidth*2+space;
            }else if(count>6){
                height = imageWidth*3+space*2;
            }
            break;
        }
        case GZCAutoImagesViewTypeVertical:{
            for (int i = 0;i<[images count];i++) {
                GZCAutoImage *image = images[i];
                float imageWidth = width;
                float scale = imageWidth/image.size.width;
                float imgHeight = image.size.height * scale;
                height += imgHeight;
                if (i<[images count]-1) {
                    height += space;
                }
            }
            break;
        }
    }
    return height;
}

-(void)setImages:(NSArray<__kindof GZCAutoImage *> *)images{
    _images = images;
    maxX = 0;
    maxY = 0;
    switch (_type) {
        case GZCAutoImagesViewTypeNine:
        {
            for (UIImageView *imageV in imageViews) {
                imageV.image = nil;
                imageV.hidden = YES;
            }
            if ([_images count]==4&&!_enable) {
                imageViews[0].hidden = NO;
                imageViews[1].hidden = NO;
                imageViews[3].hidden = NO;
                imageViews[4].hidden = NO;
                [imageViews[0] setWebImage:images[0].imageUrl];
                [imageViews[1] setWebImage:images[1].imageUrl];
                [imageViews[3] setWebImage:images[2].imageUrl];
                [imageViews[4] setWebImage:images[3].imageUrl];
                maxX = MaxX(((UIImageView*)imageViews[4]));
                maxY = MaxY(((UIImageView*)imageViews[4]));
            }else{
                for (int i = 0 ; i<[images count]; i++) {
                    if (i>8) {
                        return;
                    }
                    imageViews[i].hidden = NO;
                    [imageViews[i] setWebImage:images[i].imageUrl placeholderImage:images[i].image];
                    maxX = MAX(MaxX(imageViews[i]), maxX);
                    maxY = MAX(MaxY(imageViews[i]), maxY);
                }
                if (_enable&&[_images count]<9) {
                    addButton.hidden = NO;
                    int index = (int)[_images count];
                    addButton.frame = imageViews[index].frame;
                    maxX = MAX(MaxX(imageViews[index]), maxX);
                    maxY = MAX(MaxY(imageViews[index]), maxY);
                }else{
                    addButton.hidden = YES;
                }
            }
            [self changedSize];
            break;
        }
        case GZCAutoImagesViewTypeVertical:{
            imageHeightDic = [NSMutableDictionary dictionary];
            float offY = 0;
            for (int i = 0;i<[images count];i++) {
                GZCAutoImage *imageM = images[i];
                float scale = imageWidth/imageM.size.width;
                float imgHeight = imageM.size.height * scale;
                UIImageView *imageV = [self createImageViewWithFrame:CGRectMake(0, offY, imageWidth, imgHeight) tag:i];
                [imageV setWebImage:imageM.imageUrl];
                offY += imgHeight +_contentSpace;
                maxX = MAX(MaxX(imageV), maxX);
                maxY = MAX(MaxY(imageV), maxY);
            }
            [self changedSize];
            break;
        }
    }
    
}

-(void)addImage:(GZCAutoImage *)image{
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:_images];
    [newArr addObject:image];
    self.images = newArr;
}

-(void)addImages:(NSArray<__kindof GZCAutoImage *> *)images{
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:_images];
    [newArr addObjectsFromArray:images];
    self.images = newArr;
}

-(void)reSizeImageViews{
    
    float offY = 0;
//    GZCLog(@"resize %d",(int)[imageViews count]);
    for (int i = 0; i < [imageViews count]; i++) {
//        GZCLog(@"resize %d",i);
        UIImageView *imageView = imageViews[i];
        imageView.frame = CGRectMake(MinX(imageView), offY, WIDTH(imageView), HEIGHT(imageView));
        offY += HEIGHT(imageView) + _contentSpace;
        maxX = MAX(MaxX(imageViews[i]), maxX);
        maxY = MAX(MaxY(imageViews[i]), maxY);
    }
    [self changedSize];
}

-(CGSize)getSize{
    switch (_type) {
        case GZCAutoImagesViewTypeNine:
        {
            NSInteger count = 0;//[_imageUrls count];
            if (_images!=nil) {
                 count = [_images count];
            }
            if (_enable) {
                count ++;
            }
            if (count==4) {
                maxX = MaxX(imageViews[4]);
                maxY = MaxY(imageViews[4]);
            }else{
                if (count>3) {
                    maxX = MaxX(imageViews[2]);
                }
                if (count>9) {
                    count = 9;
                }
                maxX = MAX(MaxX(imageViews[count-1]), maxX);
                maxY = MAX(MaxY(imageViews[count-1]), maxY);
            }
            return CGSizeMake(maxX, maxY);
        }
        case GZCAutoImagesViewTypeVertical:{
            return CGSizeMake(maxX, maxY);
        }
    }
}

-(void)changedSize{
    self.frame = CGRectMake(MinX(self), MinY(self), maxX, maxY);
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoImagesView:sizeChanged:)]) {
        [self.delegate autoImagesView:self sizeChanged:[self getSize]];
    }
}

-(void)imageViewTaped:(UITapGestureRecognizer *)taprecognizer{
    NSInteger index = taprecognizer.view.tag-TAG_ADD;
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoImagesView:imageTaped:atIndex:)]) {
        GZCAutoImage *tapImage = nil;
        tapImage = _images[index];
        [self.delegate autoImagesView:self imageTaped:tapImage atIndex:index];
    }
}

-(void)imageViewLongPress:(UILongPressGestureRecognizer *)longRecognizer{
    NSInteger index = longRecognizer.view.tag-TAG_ADD;
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoImagesView:imageLongTaped:atIndex:)]) {
        GZCAutoImage *tapImage = nil;
        tapImage = _images[index];
        [self.delegate autoImagesView:self imageLongTaped:tapImage atIndex:index];
    }
}

-(void)addButtonTaped{
    if ([self.delegate respondsToSelector:@selector(autoImagesViewAddTaped:)]) {
        [self.delegate autoImagesViewAddTaped:self];
    }
}

@end
