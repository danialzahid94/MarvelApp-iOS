//
//  UIScrollView+UIScrollViewScrollingDirection.h
//
//  Created by Danial Zahid on 2015-04-27.
//  Copyright (c) 2013 Danial Zahid All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollDirection){
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy
};


@interface UIScrollView (UIScrollViewScrollingDirection)

- (ScrollDirection)scrollDirectionX;
- (ScrollDirection)scrollDirectionY;

- (CGPoint)lastContentOffset;
- (void)setLastContentOffset:(CGPoint)contentOffset;

@end
