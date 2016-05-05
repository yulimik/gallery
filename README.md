#galleryDemo
左右滑动类型的一个画廊效果，可以点击查看，长按删除，通过UICollectionView来实现

#pragma mark - delete item
删除所选项（长按）

'- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Tissue" message:@"Do you want to delete?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alertView.delegate = self;
        [alertView show];
        self.picTag = recognizer.view.tag;
    }
}'

'- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.colorArr removeObjectAtIndex:self.picTag];
        [self.gallery reloadData];
    }
}'

#pragma mark - show picture
点击所选项
'- (void)handleSinglePress:(UITapGestureRecognizer *)recognizer
{
    self.lab.backgroundColor = [self.colorArr objectAtIndex:recognizer.view.tag];
}'

![image](http://cl.ly/1i0F2O1W3543/download/galleryDemo.png)