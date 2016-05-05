//
//  ViewController.m
//  galleryDemo
//
//  Created by 周伟 on 16/5/5.
//  Copyright © 2016年 yulimik. All rights reserved.
//

#import "ViewController.h"
#import "LineLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableArray *colorArr;
@property (nonatomic,assign) NSInteger picTag;
@property (nonatomic,strong) UILabel *lab;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorArr = [[NSMutableArray alloc]init];
    NSArray *littleArr = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor greenColor], nil];
    for (int i = 0; i < 10; i++) {
        for (UIColor *objColor in littleArr) {
            [self.colorArr addObject:objColor];
        }
    }
    LineLayout *lineLayout = [[LineLayout alloc]init];
    [lineLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.gallery = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100) collectionViewLayout:lineLayout];
    self.gallery.dataSource=self;
    self.gallery.delegate=self;
    self.gallery.backgroundColor = [UIColor grayColor];
    [self.gallery registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.gallery];
    
    self.lab = [[UILabel alloc]init];
    [self.view addSubview:self.lab];
    self.lab.frame = CGRectMake(0, 450,self.view.frame.size.width ,30);
    self.lab.backgroundColor = [UIColor blackColor];

}

#pragma mark -- UICollectionView DataSource
//UICollectionViewCell number
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colorArr.count;
}

//Section number
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//uicollectioncell content
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UITapGestureRecognizer *singlePressRecognizer = [[UITapGestureRecognizer alloc]init];
    [singlePressRecognizer addTarget:self action:@selector(handleSinglePress:)];
    [cell addGestureRecognizer:singlePressRecognizer];
    singlePressRecognizer.delegate = self;
    singlePressRecognizer.view.tag = indexPath.row;
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc]init];
    [longPressRecognizer addTarget:self action:@selector(handleLongPress:)];
    [cell addGestureRecognizer:longPressRecognizer];
    longPressRecognizer.minimumPressDuration = 1.0;
    longPressRecognizer.delegate = self;
    longPressRecognizer.view.tag = indexPath.row;

    cell.backgroundColor = [self.colorArr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - delete item
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Tissue" message:@"Do you want to delete?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alertView.delegate = self;
        [alertView show];
        self.picTag = recognizer.view.tag;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.colorArr removeObjectAtIndex:self.picTag];
        [self.gallery reloadData];
    }
}

#pragma mark - show picture
- (void)handleSinglePress:(UITapGestureRecognizer *)recognizer
{
    self.lab.backgroundColor = [self.colorArr objectAtIndex:recognizer.view.tag];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//Item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(60, 60);
}

//section distance
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}

//UICollectionView  margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGSize size = self.view.bounds.size;
    return UIEdgeInsetsMake(0, size.width/2.5, 0, size.width/2.5);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView didselect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
