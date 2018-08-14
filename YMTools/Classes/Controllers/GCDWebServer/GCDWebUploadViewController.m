//
//  GCDWebUploadViewController.m
//  YMTools
//
//  Created by longxian on 2018/5/3.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "GCDWebUploadViewController.h"
#import <GCDWebUploader.h>
#import "SJXCSMIPHelper.h"

#import <TZImagePickerController.h>

@interface GCDWebUploadViewController ()<GCDWebUploaderDelegate, UITableViewDelegate, UITableViewDataSource ,TZImagePickerControllerDelegate>
{
    GCDWebUploader * _webServer;
}
/* 显示ip地址 */
@property (nonatomic, weak) UILabel *showIpLabel;
/* fileTableView */
@property (nonatomic, weak) UITableView *fileTableView;
/* fileArray */
@property (nonatomic, strong) NSMutableArray *fileArray;

/** imageView */
@property (nonatomic, strong) UIImageView *showImgV;

/** ChoosePicBtn */
@property (nonatomic, strong) UIButton *chooseBtn;

@end

@implementation GCDWebUploadViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.chooseBtn];
    
    [self buildUploadServer];
}

-(void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [_webServer stop];
//    _webServer = nil;
}

#pragma mark - private methods
- (void)buildUploadServer {
    
    // 文件存储位置
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"文件存储位置：%@", documentsPath);
    
    // 创建webServer, 设置根目录
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    
    // 设置代理
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    
    // 限制文件上传类型
    _webServer.allowedFileExtensions = @[@"doc", @"docx", @"xls", @"xlsx", @"txt", @"pdf", @"png", @"jpeg", @"jpg"];
    
    // 设置网页标题
    _webServer.title = @"YM的demo";
    
    // 设置展示在网页上的文字(开场白)
    _webServer.prologue = @"欢迎使用WIFI管理平台";
    
    // 设置展示在网页上的文字()
    _webServer.epilogue = @"YM制作";
    
    if ([_webServer start]) {
        self.showIpLabel.hidden = NO;
        self.showIpLabel.text = [NSString stringWithFormat:@"请在网页上输入地址：http://%@:%zd/", [SJXCSMIPHelper deviceIPAdress], _webServer.port];
    }
    else {
        self.showIpLabel.text = NSLocalizedString(@"GCDWebServer not runing", nil);
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.fileArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:string error:nil]];
    
    NSString *fileName = self.fileArray[indexPath.row];
//    if ([fileName containsString:@".png"] || [fileName containsString:@".JPG"] || [fileName containsString:@"JPEG"]) {
        NSString *fileUrl = [NSString stringWithFormat:@"%@/%@",string,self.fileArray[indexPath.row]];
        self.showImgV.image = [UIImage imageWithContentsOfFile:fileUrl];
//    }
}


#pragma mark - CustomDelegate -<GCDWebUploaderDelegate>
-(void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path {
    NSLog(@"[UPLOAD] %@", path);
    
    self.showIpLabel.hidden = YES;
    
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:string error:nil]];
    
    [self.fileTableView reloadData];
}

-(void)webUploader:(GCDWebUploader *)uploader didMoveItemFromPath:(NSString *)fromPath toPath:(NSString *)toPath {
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    NSLog(@"[DELETE] %@", path);
    
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileArray = [NSMutableArray arrayWithArray:[fileManager contentsOfDirectoryAtPath:string error:nil]];
    
    [self.fileTableView reloadData];
}

- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    NSLog(@"[CREATE] %@", path);
}

#pragma mark - event response
- (void)choosePicBtnClick {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:NSIntegerMax delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto)
    {
        for (int i = 0; i < photos.count; i++) {
            // 获取图片信息(PHAsset)
            NSString *fileName = [assets[i] valueForKey:@"filename"];
            NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *fileUrl = [NSString stringWithFormat:@"%@/%@",string,fileName];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isSuccess = [fileManager createFileAtPath:fileUrl contents:UIImagePNGRepresentation(photos[i]) attributes:nil];
            if (isSuccess) {
                NSLog(@"创建成功:%@",fileName);
            }
            else {
                NSLog(@"创建失败:%@",fileName);
            }
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - getters and setters
- (UILabel *)showIpLabel {
    if (!_showIpLabel) {
        UILabel *lb = [[UILabel alloc] init];
        
        lb.bounds = CGRectMake(0, 0, kWidth, 200);
        lb.center = CGPointMake(kWidth * 0.5, kHeight * 0.5);
        lb.textColor = [UIColor darkGrayColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:13.0];
        lb.numberOfLines = 0;
        
        [self.view addSubview:lb];
        _showIpLabel = lb;
    }
    return _showIpLabel;
}

- (UITableView *)fileTableView {
    if (!_fileTableView) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        
        // 设置代理
        tv.delegate = self;
        // 设置数据源
        tv.dataSource = self;
        // 清除表格底部多余的cell
        tv.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.view addSubview:tv];
        _fileTableView = tv;
    }
    return _fileTableView;
}

- (NSMutableArray<NSString *> *)fileArray {
    if (!_fileArray) {
        _fileArray = [NSMutableArray array];
    }
    return _fileArray;
}

-(UIImageView *)showImgV {
    if (!_showImgV) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(kWidth - 100, kHeight - 200, 80, 80);
        [self.view addSubview:imageView];
        
        _showImgV = imageView;
    }
    return _showImgV;
}

-(UIButton *)chooseBtn {
    if (!_chooseBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor cyanColor]];
        [button setTitleColor:[UIColor whiteColor].flatten forState:UIControlStateNormal];
        [button setTitle:@"点我选择图片" forState:UIControlStateNormal];
        button.frame = CGRectMake(kWidth - 60, 20, 50, 44);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.backgroundColor = FlatBlue;
        [button addTarget:self action:@selector(choosePicBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _chooseBtn = button;
    }
    return _chooseBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
