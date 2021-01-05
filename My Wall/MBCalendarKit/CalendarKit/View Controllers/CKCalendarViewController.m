//
//  CKViewController.m
//  MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarView.h"
#import "CKCalendarEvent.h"
#import "NSCalendarCategories.h"

#import "CKTableViewCell.h"

#import "CKCalendarViewController.h"
#import "CKCalenderCell.h"
#import "UIColor+HexString.h"

@interface CKCalendarViewController () <CKCalendarViewDataSource, CKCalendarViewDelegate, UITableViewDataSource, UITableViewDelegate>

/**
 The calendar view used in the view controller.
 */
@property (nonatomic, strong, nonnull) CKCalendarView *calendarView;

/**
 A control that allows users to choose between month, week, and day modes.
 */
@property (nonatomic, strong, nonnull) UISegmentedControl *modePicker;


/**
 The events to display in the calendar.
 */

@property (nonatomic, strong, nonnull) UIButton *bottomButton;
@property (nonatomic, strong, nonnull) NSDate *selectedDate;


@end

@implementation CKCalendarViewController

// MARK: Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commonInitializer];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        [self _commonInitializer];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInitializer];
    }
    return self;
}

// MARK: - Common Initialization

- (void)_commonInitializer
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"noDataCell"];
    UINib *nib = [UINib nibWithNibName:@"CKCalenderCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"CKCalenderCell"];
//    [_tableView registerClass:[CKCalenderCell class] forCellReuseIdentifier:@"CKCalenderCell"];

    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    NSArray *items = @[
                       NSLocalizedString(@"Day View", @"A title for the month view button."),
                       NSLocalizedString(@"Week View",@"A title for the week view button."),
                       NSLocalizedString(@"Month View", @"A title for the day view button.")];
    
    _modePicker = [[UISegmentedControl alloc] initWithItems:items];
    self.modePicker.selectedSegmentIndex = 0;
    self.modePicker.backgroundColor = [UIColor colorWithHexString:@"#273238"];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Helvetica-Bold" size:16], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                nil];
    [self.modePicker setTitleTextAttributes:attributes forState:UIControlStateNormal];

    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithHexString:@"#273238"] forKey:NSForegroundColorAttributeName];
    [self.modePicker setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    self.modePicker.layer.cornerRadius = 4.0;
    self.modePicker.clipsToBounds = true;
    self.modePicker.layer.borderWidth = 0.5;
    self.modePicker.layer.borderColor = [UIColor whiteColor].CGColor;
   
    if (@available(iOS 13.0, *)) {
        self.modePicker.selectedSegmentTintColor = [UIColor colorWithHexString:@"#f0eff4"];
    }else{
        [self.modePicker setTintColor:[UIColor colorWithHexString:@"#f0eff4"]];
    }
    [self.modePicker setImage:[UIImage imageNamed:@"calender"] forSegmentAtIndex:2];

    for (UIView *eachView in self.modePicker.subviews) {
        eachView.layer.borderWidth = 0.5;
        eachView.layer.borderColor = [UIColor colorWithHexString:@"#f0eff4"].CGColor;
    }
    
    [self.modePicker addTarget:self action:@selector(modeChangedUsingControl:) forControlEvents:UIControlEventValueChanged];

}


- (void)installToolbar
{
    if (![self.view.subviews containsObject:self.modePicker])
    {
        /* Set up the table */
        [self.view addSubview:self.modePicker];
        self.modePicker.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.modePicker
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeading
                                                                  multiplier:1.0
                                                                    constant:0.0];
        
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.modePicker
                                                                    attribute:NSLayoutAttributeTrailing
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeTrailing
                                                                   multiplier:1.0
                                                                     constant:0.0];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.modePicker
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.topLayoutGuide
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.modePicker
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0];
        
        
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.modePicker
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute: NSLayoutAttributeNotAnAttribute
                                                             multiplier:1
                                                               constant:44];

        
        [self.view addConstraints:@[leading, trailing, top, height]];
    }
}


// MARK: - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if(!self.title)
    {
        [self setTitle:NSLocalizedString(@"Calendar", @"A title for the calendar view.")];
    }
    
    /* Prepare the events array */
    self.selectedDate = [NSDate date];
    self.events = [NSMutableArray new];
    [self installToolbar];
    [self installCalendarView];
    [self installTableView];
    [self installBottomButton];

    
}

-(void)buttonClickedCreateMeeting {
    if ([self.delegate respondsToSelector:@selector(calendarViewCreateMeeting:didSelectDate:)]) {
        [self.delegate calendarViewCreateMeeting:_calendarView didSelectDate:self.selectedDate];
    }
}
-(void)installBottomButton{
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:self.bottomButton];
    [self.view bringSubviewToFront:self.bottomButton];
    self.bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomButton addTarget:self action:@selector(buttonClickedCreateMeeting) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomButton setBackgroundImage:[[UIImage imageNamed:@"PlusBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.bottomButton.tintColor = [UIColor colorWithRed:0 green:0.5019607843 blue:0 alpha:1];
    
    UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
    [self.bottomButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-15].active = YES;
    [self.bottomButton.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor constant:-130].active = YES;
    [self.bottomButton.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.bottomButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.bottomButton layoutIfNeeded];

    self.bottomButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bottomButton.layer.shadowOffset = CGSizeMake(0, 1.0f);
    self.bottomButton.layer.shadowOpacity = 0.5;
    self.bottomButton.layer.shadowRadius = 3;
    self.bottomButton.layer.masksToBounds = NO;
    self.bottomButton.layer.cornerRadius = 25;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Configure Calendar View

- (void)installCalendarView
{
    self.calendarView = [[CKCalendarView alloc] init];
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
//    [self installShadow];
    [self.view addSubview:self.calendarView];
    [self layoutCalendar];
}

/**
 This method sets up constraints on the calendar view.
 */

- (void)layoutCalendar
{
    self.calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.calendarView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.modePicker
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:5];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.calendarView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0
                                                                constant:0.0];
    
    [self.view addConstraints:@[top, centerX]];
    
}


// MARK: - Install Table View

- (void)installTableView
{
    if (![self.view.subviews containsObject:self.tableView])
    {
//        /* Set up the table */
//        self.tableView.rowHeight = 120;
        self.tableView.estimatedRowHeight = 300;

        [self.view addSubview:self.tableView];
        [self.view bringSubviewToFront:self.calendarView];
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeading
                                                                  multiplier:1.0
                                                                    constant:0.0];
        
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                    attribute:NSLayoutAttributeTrailing
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeTrailing
                                                                   multiplier:1.0
                                                                     constant:0.0];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.calendarView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:5];
        
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:0.0];
        
        [self.view addConstraints:@[leading, trailing, top, bottom]];
        
        
        UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
        [self.tableView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor constant:-50].active = YES;
        [self.tableView layoutIfNeeded];

    }
}



// MARK: - Allows Users to Install The Shadows

/**
 Install the shadow on the calendar.
 */
- (void)installShadow
{
    (self.calendarView.layer).shadowOpacity = 1.0;
    (self.calendarView.layer).shadowColor = UIColor.darkGrayColor.CGColor;
    (self.calendarView.layer).shadowOffset = CGSizeMake(0, 3);
}


// MARK: - Installing Toolbar

//- (void)installToolbar
//{
//    NSString *todayTitle = NSLocalizedString(@"Today", @"A button which sets the calendar to today.");
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.modePicker];
//    [self setToolbarItems:@[item] animated:NO];
//    [self.navigationController setToolbarHidden:NO animated:NO];
//}

// MARK: - Toolbar Items

- (void)modeChangedUsingControl:(UISegmentedControl *)sender
{
    self.calendarView.displayMode = (CKCalendarViewDisplayMode)self.modePicker.selectedSegmentIndex;
    if (sender.tag == CKCalendarViewDisplayModeDay) {
        [self updateCacheWithSortedEvents];
        [self.tableView reloadData];
    }
}

- (void)todayButtonTapped:(id)sender
{
    [self.calendarView setDate:[NSDate date] animated:NO];
}

// MARK: - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    if ([self.dataSource respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        return [self.dataSource calendarView:calendarView eventsForDate:date];
    }
    return nil;
}

// MARK: - Setting the Data Source

/**
 Sets the data source. Setting this also causes the cache to reload, and the table view to reload as well.

 @param dataSource The data source for the calendar view controller.
 */
- (void)setDataSource:(id<CKCalendarViewDataSource>)dataSource
{
    _dataSource = dataSource;
    self.calendarView.dataSource = dataSource;

    [self updateCacheWithSortedEvents];
    [self.tableView reloadData];
}

/**
 Asks the data source for events for a given date. 
 Then, sorts the events by date and caches them locally.
 */
- (void)updateCacheWithSortedEvents
{
    /**
     *  Sort & cache the events for the current date.
     */
    
    if ([self.dataSource respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        NSArray *sortedArray = [[self.dataSource calendarView:self.calendarView eventsForDate:self.calendarView.date] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDate *d1 = [obj1 date];
            NSDate *d2 = [obj2 date];
            
            return [d1 compare:d2];
        }];
        
        self.events = sortedArray;
    }
}

// MARK: - CKCalendarViewDelegate

// Called before the selected date changes
- (void)calendarView:(CKCalendarView *)calendarView willSelectDate:(NSDate *)date
{
    if ([self isEqual:self.delegate])
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarView:willSelectDate:)]) {
        [self.delegate calendarView:calendarView willSelectDate:date];
    }
}

// Called after the selected date changes
- (void)calendarView:(CKCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    self.selectedDate = date;
    [self updateCacheWithSortedEvents];
    [self.tableView reloadData];

    if ([self isEqual:self.delegate])
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [self.delegate calendarView:calendarView didSelectDate:date];
    }
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)calendarView didSelectEvent:(CKCalendarEvent *)event
{
    if ([self isEqual:self.delegate])
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectEvent:)]) {
        [self.delegate calendarView:calendarView didSelectEvent:event];
    }
}

#pragma mark - Calendar View

- (CKCalendarView *)calendarView
{
    return _calendarView;
}

#pragma mark - Orientation Support

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.calendarView reloadAnimated:NO];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.events.count;
    
    if (count == 0) {
        count = 2;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger count = self.events.count;
    
    if (count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noDataCell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#273238"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row == 1) {
            [cell.textLabel setText:NSLocalizedString(@"No Meetings Found", @"A label for a table with no events.")];
        }
        else
        {
            cell.textLabel.text = @"";
        }
        return cell;
    }
    
//    CKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    CKCalenderCell *cell = (CKCalenderCell *)[tableView dequeueReusableCellWithIdentifier:@"CKCalenderCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CKCalenderCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    CKCalendarEvent *event = self.events[indexPath.row];
    cell.ckEventTitle.text = event.title;
    cell.statusDescLabel.text = [event.info objectForKey:@"status"];
    cell.startTimeLabel.text = [event.info objectForKey:@"startTime"];
    cell.endTimeLabel.text = [event.info objectForKey:@"endTime"];
    cell.ckEventPlace.text = [event.info objectForKey:@"address"];
    cell.ckEventPlace.adjustsFontSizeToFitWidth = YES;
    
    NSString *status = [event.info objectForKey:@"status"];
    if ([status  containsString:@"Attended"] || [status  containsString:@"Committed"]) {
        cell.statusDescLabel.textColor = [UIColor colorWithHexString:@"#4CAF50"];
    }
    else if ([status  containsString:@"Rescheduled"] || [status  containsString:@"Scheduled"]) {
        cell.statusDescLabel.textColor = [UIColor colorWithHexString:@"#FF3F51B5"];
    }else{
        cell.statusDescLabel.textColor = [UIColor colorWithHexString:@"#F44336"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.events.count == 0) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectEvent:)]) {
        [self.delegate calendarView:self.calendarView didSelectEvent:self.events[indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
//{
//    return UITableViewAutomaticDimension;
//}

@end
