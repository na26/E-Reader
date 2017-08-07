//  Na'eem Auckburally ID: 201011641
//  AppDelegate.m
//  assignment3
//
//  Created by Na'Eem Auckburally on 06/05/2016.
//  Copyright © 2016 Na'Eem Auckburally. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
{NSInteger pageNumber;
    NSArray *myArray;
}
/*
Method when application launches
it sets up the array, and makes all fields
apart from the load button disabled
*/
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    //Disable focus of textfield and disable the ability to edit
    [self.textField.window makeFirstResponder:nil];
    self.textField.editable = NO;
    
    //Integer variable to track page number
    pageNumber =0;
    //Create new array
    myArray = [NSMutableArray array];
    //[self.textField setStringValue: myArray[0]];
    
    [self.pageNum setStringValue: @"1"];
    self.prevButton.enabled = NO;
    self.nextButton.enabled = NO;   //Disable buttons and fields until a file is loaded
    self.pageNum.enabled = NO;
    self.textField.enabled = NO;
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

/*
 When the next button is clicked, the next page in the book
 is loaded, and the other fields and buttons are loaded.
*/
- (IBAction)nextPage:(id)sender
{
    self.prevButton.enabled = YES;
    
    pageNumber++;
    if(pageNumber == 9)                 //Set enabling and disabling of buttons
    {                                   //Based on what page is open
        self.nextButton.enabled = NO;
    }
    if(pageNumber !=0)
    {                                   //Hide front image if not on first page
        self.imageView.hidden = YES;
    }
    //Update the text field with corresponding page
    [self.textField setStringValue: myArray[pageNumber]];
    
    NSString* stringPageNum = [NSString stringWithFormat:@"%li", pageNumber +1];
    //Update the slider and page text box
    [self.pageNum setStringValue: stringPageNum];
    [self.pageSlider setIntegerValue: pageNumber];
    
    
    
}

/*
 When the previous button is clicked, the previous page in the book
 is loaded, and the other fields and buttons are loaded.
 */
- (IBAction)previousPage:(id)sender
{
    pageNumber--;
    if(pageNumber == 0)
    {
        self.prevButton.enabled = NO;               //Disable previous as 0
        self.imageView.hidden = NO;                 //Show the front cover
    }
    if(pageNumber != 9)
    {
        self.nextButton.enabled = YES;
    }
    //Update textfield with the corresponding page
    //Update slider and text box
    [self.textField setStringValue: myArray[pageNumber]];
    NSString* stringPageNum = [NSString stringWithFormat:@"%li", pageNumber +1];
    [self.pageNum setStringValue: stringPageNum];
    [self.pageSlider setIntegerValue: pageNumber];  //changed from + 1
}
/*
 When the enter button is pressed, the value in the field
 is validated and if valid, the corresponding page will be loaded
 and the other fields and buttons are updated.
 */

- (IBAction)textEnter:(id)sender
{
    int numberEnter;
    NSString *number;
    number = self.pageNum.stringValue;
    numberEnter = [number intValue];
    numberEnter--;
    
    //Validate the number entered, show error message if number invalid
    if(numberEnter > 9 || numberEnter < 0)
    {
        //Error message box
        NSAlert *alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Invalid page number!\nEnter a valid number."];
        [alert runModal];
        [self.pageNum setStringValue: @""];
    }
    else
        pageNumber = numberEnter;
    {
    if(pageNumber == 0)
    {
        self.prevButton.enabled = NO;           //Conditions for enabling/disabling
        self.imageView.hidden = NO;             //buttons based on current page number
    }
    if(pageNumber!=0)
    {
        self.prevButton.enabled = YES;
        self.imageView.hidden = YES;
    }
    if(pageNumber !=9)
    {
        self.nextButton.enabled = YES;
    }
    if(pageNumber==9 && pageNumber !=0)
    {
        self.nextButton.enabled = NO;
    }
    if(pageNumber != 0 && pageNumber !=9)
    {
        self.nextButton.enabled = YES;
    }
    
    //Update page and slider
    [self.textField setStringValue: myArray[pageNumber]];
    [self.pageSlider setIntegerValue: pageNumber];
        
    }
}

/*
 When slider is moved, the page is updated with the corresponding page
 and the fields and buttons are updated.
*/
- (IBAction)pageSliderAction:(id)sender
{
    //Update the page with the sliders number
    [self.textField setStringValue: myArray[self.pageSlider.integerValue]];
    pageNumber= self.pageSlider.integerValue;
    NSString* stringPageNum = [NSString stringWithFormat:@"%li", pageNumber + 1];
    [self.pageNum setStringValue: stringPageNum];
    
    if(pageNumber == 0)
    {
        self.prevButton.enabled = NO;
        self.imageView.hidden = NO;
    }
    if(pageNumber!=0)
    {
        self.prevButton.enabled = YES;
        self.imageView.hidden = YES;        //Conditions for enabling/disabling
    }                                       //buttons based on current page number
    if(pageNumber !=9)
    {
        self.nextButton.enabled = YES;
    }
    if(pageNumber==9 && pageNumber !=0)
    {
        self.nextButton.enabled = NO;
    }
    if(pageNumber != 0 && pageNumber !=9)
    {
        self.nextButton.enabled = YES;
    }

}

//When load buttons is clicked, prompt user to click file
//and load this into the array and display the front page with image
- (IBAction)loadButton:(id)sender
{
    //Create a new panel
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    //Wait until file is selected
    if ([panel runModal] == NSFileHandlingPanelOKButton)
    {
        //Get url of selected file
        NSURL *bookURL = [panel URL];
        //Get contents of file into a string
        NSString *contents = [NSString stringWithContentsOfURL: bookURL encoding: NSASCIIStringEncoding error: NULL];
        
        //Split the contents into pages by using the page splitter and assign into
        //each element of the array
        myArray = [contents componentsSeparatedByString:@"#NP#"];
        //Assign the first page
        [self.textField setStringValue: myArray[0]];
        
        
        //Change url to image file
        bookURL = [bookURL URLByAppendingPathExtension:@"jpg"];
        //Set image on front page
        NSImage *cover = [[NSImage alloc] initWithContentsOfURL: bookURL];
        [self.imageView setImage: cover];
        self.imageView.hidden = NO;
        self.nextButton.enabled = YES;  //Re-enable buttons and fields
        self.pageNum.enabled = YES;
        self.textField.enabled = YES;
        
        
    }
    
    
    
}

@end
