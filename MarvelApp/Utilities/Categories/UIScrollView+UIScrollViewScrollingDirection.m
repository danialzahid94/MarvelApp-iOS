//
//  UIScrollView+UIScrollViewScrollingDirection.m
//
//  Created by Danial Zahid on 2015-04-27.
//  Copyright (c) 2013 Danial Zahid All rights reserved.
//

#import "UIScrollView+UIScrollViewScrollingDirection.h"
#import <objc/runtime.h> 

static char const * const lastContentOffsetXKey = "lastContentOffsetX";
static char const * const lastContentOffsetYKey = "lastContentOffsetY";

@implementation UIScrollView (UIScrollViewScrollingDirection)

#pragma mark - Obj-c Runtime stack

- (ScrollDirection)scrollDirectionX
{
  CGPoint lastContentOffset = [self lastContentOffset];
  
  if (lastContentOffset.x > self.contentOffset.x) {
    return ScrollDirectionRight;
  } else if (lastContentOffset.x < self.contentOffset.x) {
    return ScrollDirectionLeft;
  } else {
    return ScrollDirectionNone;
  }
}

- (ScrollDirection)scrollDirectionY
{
  CGPoint lastContentOffset = [self lastContentOffset];
  
  if (lastContentOffset.y > self.contentOffset.y) {
    return ScrollDirectionDown;
  } else if (lastContentOffset.y < self.contentOffset.y) {
    return ScrollDirectionUp;
  } else {
    return ScrollDirectionNone;
  }
}

- (CGPoint)lastContentOffset
{
  CGPoint lastContentOffset = CGPointMake([objc_getAssociatedObject(self, &lastContentOffsetXKey) doubleValue],
                                          [objc_getAssociatedObject(self, &lastContentOffsetYKey) doubleValue]);
  return lastContentOffset;
}

- (void)setLastContentOffset:(CGPoint)contentOffset
{
  objc_setAssociatedObject(self, &lastContentOffsetXKey, @(contentOffset.x), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  objc_setAssociatedObject(self, &lastContentOffsetYKey, @(contentOffset.y), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
