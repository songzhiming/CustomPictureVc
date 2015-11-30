//
//  PhotoSelectCollectionViewCell.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>




@interface PhotoSelectCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;


- (void)initData:(ALAsset *)asset;
- (void)selectState;
- (void)deselectState;
@end
