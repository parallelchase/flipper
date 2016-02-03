//
//  SignUpViewController.m
//  flipper
//
//  Created by Mayur Joshi on 30/01/16.
//  Copyright © 2016 Mayur Joshi. All rights reserved.
//

#import "SignUpViewController.h"
#import "IntroHeaderView.h"
#import "IntroTextView.h"

#define kOFFSET_FOR_KEYBOARD 180.0

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet IntroHeaderView *signUpHeaderView;

@property (weak, nonatomic) IBOutlet IntroTextView *textViewName;
@property (weak, nonatomic) IBOutlet IntroTextView *textViewEmail;
@property (weak, nonatomic) IBOutlet IntroTextView *textViewPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewSignUp;

@property (weak, nonatomic) IBOutlet UIView *viewSignUp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewSignUpBottomConstraint;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_signUpHeaderView.labelHeaderTitle setText:@"Sign Up"];
    [_signUpHeaderView.buttonHeader setImage:[UIImage imageNamed:@"iconBack"] forState:UIControlStateNormal];
    [_signUpHeaderView.buttonHeader addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_textViewName.textField setPlaceholder:@"Name"];
    [_textViewName.imageView setImage:[UIImage imageNamed:@"iconName"]];
    
    [_textViewEmail.textField setPlaceholder:@"Email"];
    [_textViewEmail.imageView setImage:[UIImage imageNamed:@"iconEmail"]];
    
    [_textViewPassword.textField setPlaceholder:@"Password"];
    [_textViewPassword.textField setSecureTextEntry:YES];
    [_textViewPassword.imageView setImage:[UIImage imageNamed:@"iconPassword"]];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (_viewSignUpBottomConstraint.constant < kOFFSET_FOR_KEYBOARD)
    {
        [self moveScrollViewUp:YES];
    }
}

-(void)keyboardWillHide {
    if (_viewSignUpBottomConstraint.constant >= kOFFSET_FOR_KEYBOARD)
    {
        [self moveScrollViewUp:NO];
    }
//    else if (_viewSignUpBottomConstraint.constant < kOFFSET_FOR_KEYBOARD)
//    {
//        [self moveScrollViewUp:YES];
//    }
}

-(void)moveScrollViewUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = _viewSignUp.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        _viewSignUpBottomConstraint.constant += kOFFSET_FOR_KEYBOARD;
        [_scrollViewSignUp setContentOffset:CGPointMake(0, kOFFSET_FOR_KEYBOARD) animated:YES];
//        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
//        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        _viewSignUpBottomConstraint.constant -= kOFFSET_FOR_KEYBOARD;
//        rect.origin.y += kOFFSET_FOR_KEYBOARD;
//        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    _viewSignUp.frame = rect;
    NSLog(@"Frame:%@",_viewSignUp);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (IBAction)loginClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
