//
//  DatePicker.h
//  PickerControl
//
//  Created by Sivakumar J on 27/03/16.
//  Copyright © 2016 Picker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerDelegate <NSObject>
@optional
-(void)timeChanged:(NSString*)time;
@end

@interface DatePicker : UIView
@property(nonatomic,weak)id<DatePickerDelegate>delegate;
@end
