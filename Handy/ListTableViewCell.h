//
//  ListTableViewCell.h
//  Handy
//
//  Created by Elay Datika on 5/16/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;

@end
