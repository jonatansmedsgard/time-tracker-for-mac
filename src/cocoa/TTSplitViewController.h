//
//  TTSplitViewController.h
//  Time Tracker
//
//  Created by Jonatan Smedsgård on 2026-03-07.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTSplitViewController : NSSplitViewController
@property  IBOutlet NSViewController *leftController;
@property  IBOutlet NSViewController *rightController;
@end

NS_ASSUME_NONNULL_END
