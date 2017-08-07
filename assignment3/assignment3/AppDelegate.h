//  Na'eem Auckburally ID: 201011641
//  AppDelegate.h
//  assignment3
//
//  Created by Na'Eem Auckburally on 06/05/2016.
//  Copyright © 2016 Na'Eem Auckburally. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

//Declare outlets and action methods.
@property (weak) IBOutlet NSTextField *textField;
- (IBAction)nextPage:(id)sender;
- (IBAction)previousPage:(id)sender;
@property (weak) IBOutlet NSButton *nextButton;
@property (weak) IBOutlet NSButton *prevButton;
@property (weak) IBOutlet NSTextField *pageNum;
- (IBAction)textEnter:(id)sender;
@property (weak) IBOutlet NSSlider *pageSlider;
- (IBAction)pageSliderAction:(id)sender;
- (IBAction)loadButton:(id)sender;
@property (weak) IBOutlet NSImageView *imageView;

@end

