//
//  ViewController.m
//  ASJTagsViewExample
//
//  Created by sudeep on 11/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJTagsView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ASJTagsView *tagsView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (void)setup;
- (void)handleTagBlocks;
- (void)showAlertMessage:(NSString *)message;
- (IBAction)addTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self setup];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup
{
  [self handleTagBlocks];
  [_inputTextField becomeFirstResponder];
}

#pragma mark - Tag blocks

- (void)handleTagBlocks
{
  __weak typeof(self) weakSelf = self;
  [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
     [weakSelf showAlertMessage:message];
   }];
  
  [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You deleted: %@", tagText];
     [weakSelf showAlertMessage:message];
     [weakSelf.tagsView deleteTagAtIndex:idx];
   }];
}

- (void)showAlertMessage:(NSString *)message
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tap!" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:action];
  
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)addTapped:(id)sender
{
  [_tagsView addTag:_inputTextField.text];
  _inputTextField.text = nil;
}

- (IBAction)clearAllTapped:(id)sender
{
  [_tagsView deleteAllTags];
}

@end
