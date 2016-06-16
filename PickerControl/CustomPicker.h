//
//  CustomPicker.h
//  PickerControl
//
//  Created by Sivakumar J on 27/03/16.
//  Copyright © 2016 Picker. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PickerMode) {
    PickerModeHour,
    PickerModeMinute,
    PickerModeMeridiem,
};


@protocol CustomPickerDelegate <NSObject>
@optional
-(void)scrollStopsWithValue:(NSString*)val ofType:(PickerMode)type;
@end

@interface CustomPicker : UIView
@property (nonatomic,assign)PickerMode type;
@property (nonatomic,weak)id<CustomPickerDelegate> delegate;
@end
