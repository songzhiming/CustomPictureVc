//
//  AlbumViewController.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "BasicViewController.h"



typedef void (^backImagesArray) (NSArray*);
typedef void (^backAssetsArray) (NSArray*);
@interface AlbumViewController : BasicViewController
{
    int count;
}



@property (copy,nonatomic)backImagesArray backImagesArray;
@property (copy,nonatomic)backAssetsArray backAssetsArray;
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle count:(int)maxCount;

@end
