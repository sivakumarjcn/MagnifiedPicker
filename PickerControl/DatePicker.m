//
//  DatePicker.m
//  PickerControl
//
//  Created by Sivakumar J on 27/03/16.
//  Copyright © 2016 Picker. All rights reserved.
//

#import "DatePicker.h"
#import "CustomPicker.h"

@interface DatePicker()<CustomPickerDelegate>
@property(nonatomic,strong)NSString *hour;
@property(nonatomic,strong)NSString *minute;
@property(nonatomic,strong)NSString *meridiam;
@end

@implementation DatePicker

-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup {
    
    self.hour = @"1";
    self.minute = @"00";
    self.meridiam = @"am";
    
    CustomPicker *hourPicker = [[CustomPicker alloc] initWithFrame:CGRectMake(0,20, self.bounds.size.width/2.5, self.bounds.size.height-40)];
    [hourPicker setType:PickerModeHour];
    [hourPicker setDelegate:self];
    [self addSubview:hourPicker];
    
    UILabel *colonLabel = [[UILabel alloc] initWithFrame:CGRectMake(hourPicker.frame.size.width-10, 20, 16, hourPicker.frame.size.height)];
    [colonLabel setTextColor:[UIColor whiteColor]];
    [colonLabel setBackgroundColor:[UIColor blackColor]];
    [colonLabel setText:@":"];
    [colonLabel setTextAlignment:NSTextAlignmentCenter];
    [colonLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:colonLabel.frame.size.height/4]];
  
    
    CustomPicker *mintutePick = [[CustomPicker alloc] initWithFrame:CGRectMake(hourPicker.frame.origin.x+hourPicker.frame.size.width, hourPicker.frame.origin.y, hourPicker.frame.size.width , hourPicker.frame.size.height)];
    [mintutePick setType:PickerModeMinute];
    [mintutePick setDelegate:self];
    [self addSubview:mintutePick];
    
    CGFloat width = self.bounds.size.width - (hourPicker.frame.size.width+mintutePick.frame.size.width);
    
    CustomPicker *meridiamPick = [[CustomPicker alloc] initWithFrame:CGRectMake(mintutePick.frame.origin.x+mintutePick.frame.size.width/1.5,  (self.bounds.size.height - (width*2))/2, hourPicker.frame.size.width/2, width*2)];
    [meridiamPick setType:PickerModeMeridiem];
    [meridiamPick setDelegate:self];
    [self addSubview:meridiamPick];
    
    [self addSubview:colonLabel];
   
}

-(void)scrollStopsWithValue:(NSString *)val ofType:(PickerMode)type {
    
    if (type == PickerModeHour) {
        self.hour = val;
    }else if(type == PickerModeMinute) {
        self.minute = val;
    }else if(type == PickerModeMeridiem) {
        self.meridiam = val;
    }
    
     NSString *dateString = [NSString stringWithFormat:@"%@:%@ %@",self.hour, self.minute, self.meridiam];
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"h:mm a"];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
   
    //NSDate * date = [dateFormatter dateFromString:dateString];
    
    if ([self.delegate respondsToSelector:@selector(timeChanged:)]) {
        [self.delegate timeChanged:dateString];
    }
}

@end
