//
//  TTSplitViewController.m
//  Time Tracker
//
//  Created by Jonatan Smedsgård on 2026-03-07.
//

#import "TTSplitViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TTSplitViewController

- (void) viewDidLoad {
    self.splitView.wantsLayer = YES; // I think this is required if you use a left sidebar with vibrancy (which I do  below). Otherwise appkit complains and forces the use of CA layers anyway
    NSSplitViewItem *left =[NSSplitViewItem sidebarWithViewController:self.leftController];
    [self addSplitViewItem:left];

    
    NSSplitViewItem *right =[NSSplitViewItem splitViewItemWithViewController:self.rightController];
    right.minimumThickness = 420;
    [self addSplitViewItem:right];
    
    [super viewDidLoad];
}

@end

NS_ASSUME_NONNULL_END
