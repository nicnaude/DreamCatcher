//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by Nicholas Naudé on 05/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    self.textView.text = self.descriptionString;
}

@end
