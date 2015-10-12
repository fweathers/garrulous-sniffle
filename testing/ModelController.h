//
//  ModelController.h
//  testing
//
//  Created by Felicia Weathers on 10/11/15.
//  Copyright © 2015 Felicia Weathers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

