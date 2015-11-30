//
//  PhotoSelectViewController.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "BasicViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>



typedef void (^complete) (NSArray*);
typedef void (^completeAssets) (NSArray*);
@interface PhotoSelectViewController : BasicViewController{
    int max_select_count;
}
@property (strong, nonatomic) ALAssetsGroup        *assetsGroups;
@property (copy, nonatomic) complete complete;
@property (copy, nonatomic) completeAssets completeAssets;
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle count:(int)maxCount;
@end
