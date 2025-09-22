#import "PreferencesController.h"

#import "MainController.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@implementation PreferencesController
- (void)windowWillClose:(NSNotification *)notification
{
    // to be sure remove the focus from the filename field in order to trigger it binding the new value
    [[_csvFilenameField window] makeFirstResponder:[_csvFilenameField window]];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    return [self init];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
}

- (IBAction) pickOutputFileClicked:(id) sender {
    NSSavePanel *sp;
    NSInteger savePanelResult;
    
    sp = [NSSavePanel savePanel];
    
    [sp setTitle:@"Autosave CSV"];
    [sp setNameFieldLabel:@"Filename:"];
    [sp setPrompt:@"Save"];
    
    UTType *type = [UTType typeWithFilenameExtension:@"csv"];
    [sp setAllowedContentTypes:@[type]];
    
    savePanelResult = [sp runModal];
    
    if (savePanelResult == NSModalResponseOK) {
        [_mainController setAutosaveCsvFilename:[sp URL]];
    }
}
@end
