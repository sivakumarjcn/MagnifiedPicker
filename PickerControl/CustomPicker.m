//
//  CustomPicker.m
//  PickerControl
//
//  Created by Sivakumar J on 27/03/16.
//  Copyright © 2016 Picker. All rights reserved.
//

#import "CustomPicker.h"


@interface CustomPicker()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *pickView;
    UITableView *topTimer;
    UITableView *bottomTimer;
    UIScrollView *pickerScrollView;
}
@property(nonatomic,strong)NSMutableArray *datasource;
@end

@implementation CustomPicker


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

-(void)loadData {
    self.datasource = [NSMutableArray array];
    if (self.type == PickerModeHour) {
        for (int i = 1; i <= 12; i++) {
            [self.datasource addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else if(self.type == PickerModeMinute){
        for (int i = 0; i <= 59; i++) {
            [self.datasource addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else if (self.type == PickerModeMeridiem) {
        [self.datasource addObject:@"am"];
        [self.datasource addObject:@"pm"];
    }
    
    [self.datasource addObjectsFromArray:self.datasource];
    
    [topTimer reloadData];
    [bottomTimer reloadData];
    [pickView reloadData];

}

-(void)setup {
    
    [self setBackgroundColor:[UIColor blackColor]];
    CGSize size = self.bounds.size;
    topTimer = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width,size.height/3) style:UITableViewStylePlain];
    [topTimer setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [topTimer registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    topTimer.dataSource = self;
    topTimer.delegate = self;
    
    bottomTimer = [[UITableView alloc] initWithFrame:CGRectMake(0, size.height*2.2/3,size.width , size.height/3.75) style:UITableViewStylePlain];
    [bottomTimer registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [bottomTimer setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    bottomTimer.dataSource = self;
    bottomTimer.delegate = self;
    
    
    pickView = [[UITableView alloc] initWithFrame:CGRectMake(0, size.height/4, size.width, size.height/2) style:UITableViewStylePlain];
    [pickView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [pickView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    pickView.dataSource = self;
    pickView.delegate = self;
    
    topTimer.userInteractionEnabled = NO;
    bottomTimer.userInteractionEnabled = NO;
    pickView.userInteractionEnabled = NO;
    
    pickerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [pickerScrollView setShowsHorizontalScrollIndicator:NO];
    [pickerScrollView setShowsVerticalScrollIndicator:NO];
    [pickerScrollView setDelegate:self];
    
    [topTimer setBackgroundColor:[UIColor blackColor]];
    [bottomTimer setBackgroundColor:[UIColor blackColor]];
    [pickView setBackgroundColor:[UIColor blackColor]];
    
    [self addSubview:topTimer];
    [self addSubview:bottomTimer];
    [self addSubview:pickView];
    [self addSubview:pickerScrollView];
    
    [self loadData];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    [pickerScrollView setContentSize:CGSizeMake(pickerScrollView.bounds.size.width, pickView.contentSize.height*2)];
    //[pickerScrollView setContentOffset:CGPointMake(0, pickerScrollView.contentSize.height/3)];
    [self scrollViewDidScroll:pickerScrollView];
    
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGSize size = frame.size;
    [topTimer setFrame:CGRectMake(0, 0, size.width,size.height/3)];
    [bottomTimer setFrame:CGRectMake(0, size.height * 2.2/3,size.width , size.height/3.75)];
    [pickView setFrame:CGRectMake(0, size.height/4, size.width, size.height/2)];
    [pickerScrollView setFrame:CGRectMake(0, 0, size.width, size.height)];
    [topTimer reloadData];
    [bottomTimer reloadData];
    [pickView reloadData];
    
}



-(void)setType:(PickerMode)type {
    _type = type;
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *displayLabel = [cell.contentView viewWithTag:122];
    if (!displayLabel) {
        displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width-20, tableView.bounds.size.height)];
        [displayLabel setBackgroundColor:[UIColor blackColor]];
        [displayLabel setMinimumScaleFactor:0.5];
        [displayLabel setTextAlignment:NSTextAlignmentLeft];
        [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
        [cell.contentView addSubview:displayLabel];
        
    }
    if (![tableView isEqual:pickView]) {
        [displayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:self.bounds.size.width/4]];
        [displayLabel setTextColor:[UIColor colorWithWhite:0.8 alpha:1.0]];
    
    }else  {
        [displayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:self.bounds.size.width/2]];
        [displayLabel setTextColor:[UIColor whiteColor]];
    }
    
  
    [displayLabel setText:self.datasource[indexPath.row]];
    
    if (self.type == PickerModeHour) {
        [displayLabel setTextAlignment:NSTextAlignmentRight];
    }else if(self.type == PickerModeMeridiem) {
         [displayLabel setTextAlignment:NSTextAlignmentLeft];
    }
   
    [cell setBackgroundColor:[UIColor blackColor]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![tableView isEqual:pickView]) {
        return self.bounds.size.height / 4;
    }else {
        return self.bounds.size.height / 2;
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:pickerScrollView]) {
        
        CGFloat currentOffsetX = pickerScrollView.contentOffset.x;
        CGFloat currentOffSetY = pickerScrollView.contentOffset.y;
        CGFloat contentHeight = pickerScrollView.contentSize.height;
        
        if (currentOffSetY < (contentHeight / 8.0)) {
            pickerScrollView.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY + (contentHeight/2)));
        }
        if (currentOffSetY > ((contentHeight * 6)/ 8.0)) {
            pickerScrollView.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY - (contentHeight/2)));
        }
      
        [pickView setContentOffset:CGPointMake(0, pickerScrollView.contentOffset.y/2)];
        [topTimer setContentOffset:CGPointMake(0, pickView.contentOffset.y/2 - (self.bounds.size.height/4))];
        [bottomTimer setContentOffset:CGPointMake(0,pickView.contentOffset.y/2 + (self.bounds.size.height/4))];
        
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([scrollView isEqual:pickerScrollView]) {
        CGFloat height = [self tableView:pickView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGFloat index = targetContentOffset->y/(height*2);
        
        if(velocity.y > 0)
            index = ceil(index);
        else if(velocity.y < 0)
            index = floor(index);
        else
            index = round(index);
        
        targetContentOffset->y = index * (height*2);
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:pickerScrollView]) {
       [self stoppedScrolling];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    
    if (!decelerate) {
        if ([scrollView isEqual:pickerScrollView]) {
            [self stoppedScrolling];
        }
        
    }
}

- (void)stoppedScrolling
{
    NSLog(@"stopped");
   
    if ([self.delegate respondsToSelector:@selector(scrollStopsWithValue:ofType:)]) {
        CGFloat height = [self tableView:pickView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger index = round(pickerScrollView.contentOffset.y/(height*2));
        
        [self.delegate scrollStopsWithValue:[self.datasource objectAtIndex:index] ofType:self.type];
    }

 
}

@end
