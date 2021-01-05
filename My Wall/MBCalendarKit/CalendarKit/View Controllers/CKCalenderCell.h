//
//  CKCalenderCell.h
//  CalenderEvents
//
//  Created by surendra on 29/11/20.
//

#import <UIKit/UIKit.h>


@interface CKCalenderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ckEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *statusDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ckEventPlace;

@end

