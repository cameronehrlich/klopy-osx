//
//  KLViewController.m
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "KLViewController.h"
#import "KLModel.h"


@interface KLViewController ()

@property (weak, nonatomic) IBOutlet NSTableView *tableView;

- (IBAction)add:(id)sender;

@end


@implementation KLViewController

-(void)awakeFromNib
{
    [[[KLModel sharedInstance] api] setDelegate:self];
    [[[KLModel sharedInstance] api] update];

}



-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[[[KLModel sharedInstance] api] clippings] count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField *result = [tableView makeViewWithIdentifier:@"cellView" owner:self];
    
    if (!result) {

        result = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];

        result.identifier = @"cellView";
    }
    
    KLClipping *clipping = [[[[KLModel sharedInstance] api] clippings] objectAtIndex:row];
    result.stringValue = clipping.content;

    return result;

}

-(void)api:(KLAPI *)api didReceiveUpdate:(NSDictionary *)info{
    [self.tableView reloadData];
}


- (IBAction)add:(id)sender {
    [[[KLModel sharedInstance] api] add:[[NSPasteboard generalPasteboard] stringForType:NSPasteboardTypeString]];
}
@end
