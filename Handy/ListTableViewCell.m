//
//  ListTableViewCell.m
//  Handy
//
//  Created by Elay Datika on 5/16/14.
//  Copyright (c) 2014 elaydatika. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell
@synthesize cellImage, typeLabel, nameLabel, decLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
