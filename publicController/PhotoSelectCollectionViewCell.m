//
//  PhotoSelectCollectionViewCell.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "PhotoSelectCollectionViewCell.h"

@implementation PhotoSelectCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)initData:(ALAsset *)asset{
    self.photoImage.image = [UIImage imageWithCGImage:asset.thumbnail];
}
- (void)selectState{
    self.photoImage.alpha = 0.4;
    self.selectImage.hidden = NO;
}
- (void)deselectState{
    self.photoImage.alpha = 1;
    self.selectImage.hidden = YES;
}
@end
