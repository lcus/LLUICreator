//
//  LLPhotoPiker.m
//  SubProject
//
//  Created by lcus on 2018/5/25.
//  Copyright © 2018年 lcus. All rights reserved.
// 设置中截面 info.plist Localized resources can be mixed 设置为YES

#import "LLPhotoPiker.h"

@interface LLPhotoPiker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak) UIViewController * controller;
@property(nonatomic,copy) void(^selectedImage)(UIImage *image);
@property(nonatomic,strong) UIImagePickerController * imgPicker;
@property(nonatomic,copy) void(^releaseClock)(void);

@end

@implementation LLPhotoPiker


- (instancetype)initWithPresetndViewContorller:(UIViewController *)viewContorller selected:(void (^)(UIImage *))selected
{
    self = [super init];
    if (self) {
        self.controller = viewContorller;
        self.selectedImage = selected;
        self.imgPicker =[[UIImagePickerController alloc]init];
        self.imgPicker.delegate =self;
        self.imgPicker.allowsEditing = YES;
    }
    return self;
}

-(void)show {
    
    
    
   __block UIAlertController *sheet =[UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    sheet.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
    
    
    self.releaseClock = ^{
        sheet = nil;
    };

    UIAlertAction *camer =[UIAlertAction actionWithTitle:@"使用摄像头拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imgPicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            _imgPicker.showsCameraControls = YES;
            [self.controller presentViewController:_imgPicker animated:YES completion:nil];

        }
        else
        {
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"手机不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action =[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                [alert dismissViewControllerAnimated:YES completion:nil];
                [self.imgPicker dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            
            [self.controller presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    UIAlertAction *photoLibrary=[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.controller presentViewController:_imgPicker animated:YES completion:nil];
    }];
    
    LLWeakSelf(self)
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        weakself.releaseClock();
    }];
    [sheet addAction:camer];
    [sheet addAction:photoLibrary];
    [sheet addAction:cancel];
    
    
    
    
    [self.controller presentViewController:sheet animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
//
    UIImage * receiveImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
//    UIImage * receiveImage = [info objectForKey: UIImagePickerControllerEditedImage];
    
    CGSize imageSize=receiveImage.size;
    receiveImage=[self imageWithImage:receiveImage scaledToSize:imageSize];
    NSData *imageData=UIImageJPEGRepresentation(receiveImage, 0.00001);
    UIImage *selectImage=[UIImage imageWithData:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.selectedImage?self.selectedImage(selectImage):nil;
        self.releaseClock();
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
    
        self.releaseClock();
    }];
    
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
