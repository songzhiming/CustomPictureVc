//
//  AlbumViewController.m
//  DoctorPlatForm
//
//  Created by 宋志明 on 15-4-24.
//  Copyright (c) 2015年 songzm. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumTableViewCell.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>



#import "PhotoSelectViewController.h"


@interface AlbumViewController ()

@property (weak, nonatomic) IBOutlet UITableView *albumTableView;
@property (strong, nonatomic) NSMutableArray        *assetsGroups;
@property (strong, nonatomic) ALAssetsLibrary       *assetsLibrary;

@end

@implementation AlbumViewController


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibNameOrNil count:(int)maxCount
{
    self = [super initWithNibName:nibName bundle:nibNameOrNil];
    if (self) {
        count = maxCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assetsGroups = [[NSMutableArray alloc] init];
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    self.title = @"我的相册";
    [self setNavRightBtn];
    self.navigationItem.leftBarButtonItem = nil;
    UInt32 type = ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream | ALAssetsGroupSavedPhotos ;
    [self.assetsLibrary enumerateGroupsWithTypes:type usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (group.numberOfAssets > 0) {
                [self.assetsGroups addObject:group];
                [self.albumTableView reloadData];
            }
        }
    } failureBlock:^(NSError *error) {
        FLOG(@"error%@", error);
    }];
}


//设置navigationbar 右边的button
- (void)setNavRightBtn{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(RightDown)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void) RightDown
{
    if (self.backImagesArray) {
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        self.backImagesArray(imageArray);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - TableViewDelegate & TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.assetsGroups.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumTableViewCell"];
    if (cell ==NULL){
        cell = (AlbumTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"AlbumTableViewCell" owner:self options:nil] lastObject];
    }
    [cell initData:[self.assetsGroups objectAtIndex:indexPath.row]];
    return cell;
}
//设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PhotoSelectViewController *photoSelectViewController = [[PhotoSelectViewController alloc]initWithNibName:@"PhotoSelectViewController" bundle:nil count:count];
    photoSelectViewController.assetsGroups = [self.assetsGroups objectAtIndex:indexPath.row];
//    self.backImagesArray = photoSelectViewController.complete;
    
    photoSelectViewController.complete = ^(NSArray *arr){
        self.backImagesArray(arr);
//        [self dismissViewControllerAnimated:YES completion:Nil];
    };
    photoSelectViewController.completeAssets = ^(NSArray *arr){
        FLOG(@"===%@", arr);
//        self.backAssetsArray(arr);
    };

    [self.navigationController pushViewController:photoSelectViewController animated:YES];
    
    
}



@end
