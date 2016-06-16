//
//  ViewController.m
//  PickerControl
//
//  Created by Sivakumar J on 27/03/16.
//  Copyright © 2016 Picker. All rights reserved.
//

#import "ViewController.h"
#import "DatePicker.h"

@interface ViewController () <DatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGFloat width = self.view.bounds.size.width - 20;
    
    DatePicker *datePicker = [[DatePicker alloc] initWithFrame:CGRectMake(10, 100,width, width*0.6)];
    [datePicker setDelegate:self];
    //[datePicker.layer setBorderWidth:1];
    //[datePicker.layer setBorderColor:[UIColor whiteColor].CGColor];
    [datePicker setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:datePicker];
    
    
}

-(void)timeChanged:(NSString *)time {
    
    NSLog(@"Time: %@",time);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
