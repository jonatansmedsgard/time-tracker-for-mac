//
//  TaskEditorController.m
//
//  Created by Rainer Burgstaller on 02.07.10.
//  Copyright 2010 N/A. All rights reserved.
//

#import "TaskEditorController.h"
#import "TProject.h"

@implementation TaskEditorController

@synthesize task = _task;
@synthesize taskName = _taskName;
@synthesize completed = _completed;


// ============================
#pragma mark -
#pragma mark public API 
// ============================

- (IBAction)openSheet:(id)sender forWindow:(NSWindow*) parentWindow withTask:(TTask*)task
{
	self.task = task;
	if (task.name != nil) {
		self.taskName = task.name;
	} else {
		self.taskName = @"";
	}
	self.completed = task.closed;
	
	NSWindow *sheet = [self window];

	[sheet setAlphaValue:1];
	[parentWindow beginSheet:sheet completionHandler:^(NSModalResponse returnCode) {
        // No-op: previous code did not use a completion callback.
        // If needed later, handle returnCode here.
    }];
}


- (IBAction)closeSheet:(id)sender
{
	NSWindow *sheet = [self window];
	[sheet orderOut:nil];
    NSWindow *parent = [sheet sheetParent];
    if (parent) {
        [parent endSheet:sheet];
    }
}

// ============================
#pragma mark -
#pragma mark Action handlers
// ============================

- (IBAction)applyAndClose:(id) sender {
    if (![self.task.name isEqualToString:self.taskName]) {
        // the name was changed
        if ([self.task.parentProject doesTaskNameExist:self.taskName]) {
            // Use NSAlert instead of deprecated NSRunAlertPanel
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"A Task with that name already exists";
            alert.informativeText = @"Please choose a different name";
            [alert addButtonWithTitle:@"OK"];
            
            // Prefer showing as a sheet attached to our window (or its parent)
            NSWindow *sheet = [self window];
            NSWindow *parent = sheet.sheetParent ?: sheet;
            [alert beginSheetModalForWindow:parent completionHandler:^(NSModalResponse returnCode) {
                // No-op; user just acknowledges.
            }];
            // Do not apply changes if duplicate exists
            return;
        }
    }
	self.task.name = self.taskName;
	self.task.closed = self.completed;
	NSLog(@"applying new name: %@, completd %d",self.task.name, self.task.closed);
	[self closeSheet:sender];
}

// ============================
#pragma mark -
#pragma mark Property accessors 
// ============================

/* For some unkown reasons automatic implementation of the setter is bogus. */

-(void) setTaskName:(NSString*)name {
	if (name == _taskName) {
		return;
	}
	_taskName = name;
}

@end
