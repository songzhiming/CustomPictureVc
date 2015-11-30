//
//  PhotoSelectViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "PhotoSelectViewController.h"
#import "PhotoSelectCollectionViewCell.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "MessageViewController.h"
#import "UIViewController+HUD.h"

@interface PhotoSelectViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;


@property (strong, nonatomic) NSMutableArray       *imageArray;
@property (strong, nonatomic) NSMutableArray       *assets;



@property (strong, nonatomic) NSMutableArray       *assetsArray;
@end

@implementation PhotoSelectViewController



- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibNameOrNil count:(int)maxCount
{
    self = [super initWithNibName:nibName bundle:nibNameOrNil];
    if (self) {
        max_select_count = maxCount;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择图片";
    self.assets =  [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.assetsArray = [[NSMutableArray alloc] init];
    [self setNavRightBtn];
    
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"PhotoSelectCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotoSelectCollectionViewCell"];
    self.photoCollectionView.allowsMultipleSelection = YES;
    
    UICollectionViewFlowLayout *categoryFlowLayout = (UICollectionViewFlowLayout *)self.photoCollectionView.collectionViewLayout;
    
    int width  = ([[UIScreen mainScreen] bounds].size.width-10)/4;
    int height = width;
    
    categoryFlowLayout.itemSize = CGSizeMake(width, height);
    categoryFlowLayout.minimumInteritemSpacing = 2 ;
    categoryFlowLayout.minimumLineSpacing = 2 ;
    [self reloadCollectionView];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)reloadCollectionView{
    [self.assetsGroups enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
            [self.photoCollectionView reloadData];
        }
    }];
}


//设置navigationbar 右边的button
- (void)setNavRightBtn{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(RightDown)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void) RightDown
{
    if (self.complete) {
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (NSIndexPath *indexItem in self.photoCollectionView.indexPathsForSelectedItems) {
            ALAsset *result = [self.assets objectAtIndex:indexItem.row];
            FLOG(@"result====%@", result);
            [_assetsArray addObject:result];
//            if (result !=nil) {
//                [imageArray addObject:result];
//            }
            ALAssetRepresentation *representation = result.defaultRepresentation;
            UIImage *resultImage = [UIImage imageWithCGImage:representation.fullResolutionImage];
            if (resultImage != nil) {
                [imageArray addObject:resultImage];
            }
        }
        self.completeAssets(_assetsArray);
        self.complete(imageArray);
    }
//    int count = self.navigationController.viewControllers.count;
//    MessageViewController *vc  = (MessageViewController *)[self.navigationController.viewControllers objectAtIndex:count - 3];
//    [self.navigationController popToViewController:vc animated:YES];
    NSLog(@"按下右边按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.assets.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoSelectCollectionViewCell *cell =(PhotoSelectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoSelectCollectionViewCell" forIndexPath:indexPath ];
    for (NSIndexPath *indexItem in collectionView.indexPathsForSelectedItems) {
        if (indexItem.row == indexPath.row) {
            [cell selectState];
            break;
        }else{
            [cell deselectState];
            break;
        }
    }
    [cell initData:[self.assets objectAtIndex:indexPath.row]];
    return cell;
};




- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.indexPathsForSelectedItems.count == max_select_count) {
        [self showHint:[NSString stringWithFormat:@"最多选%d张",max_select_count]];
    }
    return collectionView.indexPathsForSelectedItems.count < max_select_count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoSelectCollectionViewCell *cell = (PhotoSelectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell selectState];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoSelectCollectionViewCell *cell = (PhotoSelectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell deselectState];
}

@end
