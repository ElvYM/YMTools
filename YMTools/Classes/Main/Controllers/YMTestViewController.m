//
//  YMTestViewController.m
//  YMTools
//
//  Created by jike on 17/8/2.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "YMTestViewController.h"
#import "UIImage+YMImage.h"
#import "EVNCarouselView.h"
#import <Masonry.h>
#import "YMCustomBtn.h"
#import "MultiThreadViewController.h"
#import "ReadOnlyTestModel.h"
#import "UnReadBubbleView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <SDImageCache.h>
#import "Fast.h"

@interface YMTestViewController ()
{
    UnReadBubbleView *bv;
    UnReadBubbleView *bv2;
    UnReadBubbleView *bv3;
    UnReadBubbleView *bv4;
}
@property (strong, nonatomic)UITableView * tableView;
@property (strong, nonatomic)UILabel * testLabel;
/** 注释 */
@property (strong, nonatomic)UISearchController *searchController;

/**  */
@property (nonatomic, strong) NSString *height;
/**  */
@property (nonatomic, strong) NSString *str;
/**  */
@property (copy, nonatomic)NSString *str2;
@end

@implementation YMTestViewController

- (void)test {
    NSLog(@"别戳我...");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 关键词为什么使用copy
    NSMutableString *str = [NSMutableString stringWithString:@"123"];
    self.str = str;
    self.str2 = str;
    [str appendString:@"456"];
    
    NSLog(@"%@ -- %@",self.str, self.str2);
    NSLog(@"%p-%p-%p",str,self.str,self.str2);
    
    
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleRadial withFrame:self.view.frame andColors:@[FlatBlue, FlatPink]];

    
    // SDImageCache探究
    NSInteger size = [SDImageCache sharedImageCache].getSize;

//    [UIColor colorWithRandomColorInArray:@[FlatWhite, FlatRed, FlatBlue]];
    [self jsCoreTest];
    [self defaultTest];
//    [self tempTest];
//    [self SDWebImageTest];
//    [self MBProgressUsageTest];
//    [self showHint:@"33412"];
//    [self redLabelTest];
    
    //中文转拼音
    NSString *pinYinStr = [self transformPinYinWithChineseString:@"中文转拼音测试"];
    NSLog(@"%@",pinYinStr);
    
    
    //首行缩进
    [self.view addSubview:self.testLabel];
    NSDictionary *dic = [self settingAttributesWithLineSpacing:3 FirstLineHeadIndent:150 Font:[UIFont systemFontOfSize:17] TextColor:[UIColor blueColor]];
    self.testLabel.attributedText = [[NSAttributedString alloc] initWithString:@"容易实现的它不是梦想,轻言放弃的它不是诺言,要想成功就得敢于挑战,有了梦想才有美好的明天!容易实现的它不是梦想,轻言放弃的它不是诺言,要想成功就得敢于挑战,有了梦想才有美好的明天!" attributes:dic];
}

/**
 常用测试
 */
- (void)defaultTest {
    UIView *View = [UIView new];
    [self.view addSubview:View];
    [View mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    //空字符串处理，返回@""
    NSString *str1;
    NSString *str2 = nil;
    NSString *str3 = @"";
    NSString *str4 = @"null";
    NSLog(@"-1-:%@,%@,%@",[NSString safeString:str1],[NSString safeString:str2],[NSString safeString:str4]);

    //空对象判断
    UIButton *nullBtn;
    NSArray *arr;
    NSArray *arr1 = @[@""];
    NSLog(@"1:%d---2:%d--3:%d--4:%d--5:%d--6:%d",YMIsEmpty(str1),YMIsEmpty(str2),YMIsEmpty(str3),YMIsEmpty(nullBtn),YMIsEmpty(arr),YMIsEmpty(arr1));
    
    
    //.轮播图
    CGFloat loopViewH = 200;
    NSArray *imageArray = @[@"10.png", @"11.png", @"12.png", @"13"];
    EVNCarouselView *loopView = [[EVNCarouselView alloc] initWithImageArray:imageArray];
    loopView.frame = CGRectMake(0, kNavigationBarHeight, kWidth, loopViewH);
    [self.view addSubview:loopView];
    
    //自定义按钮（上下左右）
    YMCustomBtn *customBtn = [[YMCustomBtn alloc] initWithFrame:CGRectMake(0, 300, 300, 50)
                                                       ImgFrame:CGRectMake(10, 10, 30, 30)
                                                     TitleFrame:CGRectMake(40, 10, 100, 30)
                                                        ImgName:@"logo180"
                                                          Title:@"我是按钮啊"
                                                      TitleFont:13
                                                     TitleColor:[UIColor greenColor]];
    [customBtn setBackgroundColor:[UIColor grayColor]];
    [customBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:customBtn];
    
    
    //日期相关
    NSInteger year = [NSDate getCurrentYear];
    NSInteger mounth = [NSDate getCurrentMounth];
    NSInteger day = [NSDate getCurrentDay];
    NSInteger hour = [NSDate getCurrentHour];
    NSInteger minute = [NSDate getCurrentMinute];
    NSInteger second = [NSDate getCurrentSecond];
    NSInteger weekDay = [NSDate getCurrentWeekday];
    NSDateComponents * dateDetail = [NSDate getCurrentDateDetail];
    NSLog(@"%ld-%ld-%ld-%ld-%ld%ld-%ld-%@",year,mounth,day,hour,minute,second,weekDay,dateDetail);
}


- (void)redLabelTest {
    bv=[[UnReadBubbleView alloc] initWithFrame:CGRectMake(60, 60, 25, 25)];
    bv.bubbleColor = [UIColor redColor];
    
    bv2=[[UnReadBubbleView alloc] initWithFrame:CGRectMake(88, 88, 40, 40)];
    bv2.bubbleColor = [UIColor greenColor];
    
    bv3=[[UnReadBubbleView alloc] initWithFrame:CGRectMake(140, 140, 50, 50)];
    bv3.viscosity = 30;
    bv3.bubbleColor = [UIColor purpleColor];
    
    bv4=[[UnReadBubbleView alloc] initWithFrame:CGRectMake(250, 259, 60, 60)];
    bv4.bubbleColor = [UIColor yellowColor];
    
    UIButton *btnAdd=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame=CGRectMake(50, [UIScreen mainScreen].bounds.size.height-100, [UIScreen mainScreen].bounds.size.width-100, 60);
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
}

-(void)btnAddClick{
    [self.view addSubview:bv];
    [self.view addSubview:bv2];
    [self.view addSubview:bv3];
    [self.view addSubview:bv4];
}

/**
 MBProgressHUD Usage Test
 */
- (void)MBProgressUsageTest {
    [MBProgressHUD showCustomHud:self.view];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideCustomHud:self.view];
            });
        });
    });
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
    
}

- (void)testButtonClick:(UIButton *)sender {
    [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
//    [UIAlertView alertWithTitle:@"Title" message:@"Message" buttonIndex:^(NSInteger index) {
//        if (index == 1) {
//            NSLog(@"Sure");
//        }else {
//            NSLog(@"Cancel");
//        }
//    } cancelButtonTitle:@"Cancel" otherButtonTitles:@"确定"];
//    [self MBProgressUsageTest];
//
//    MultiThreadViewController *multiThteadVC = [[MultiThreadViewController alloc] init];
//    [self.navigationController pushViewController:multiThteadVC animated:YES];
}

/**
 临时测试
 */
- (void)tempTest __deprecated_msg("It's a deprecated message!") {
    NSArray *anArray = @[@1,@2,@3];
    [anArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    UIImageView *testImageV = [[UIImageView alloc] init];
    [testImageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    

    SEL s1 = @selector(MBProgressUsageTest);
    SEL s2 = NSSelectorFromString(@"MBProgressUsageTest");
    
    //.
    ReadOnlyTestModel *model = [[ReadOnlyTestModel alloc] init];
    [model addData];
    
}

/**
 中文转拼音

 @param chinese chinese description
 @return return value description
 */
- (NSString *)transformPinYinWithChineseString:(NSString *)chinese
{
    NSString  * pinYinStr = [NSString string];
    if (chinese.length){
        NSMutableString * pinYin = [[NSMutableString alloc]initWithString:chinese];
        //1.先转换为带声调的拼音
        if(CFStringTransform((__bridge CFMutableStringRef)pinYin, NULL, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"带声调的pinyin: %@", pinYin);
        }
        //2.再转换为不带声调的拼音
        if (CFStringTransform((__bridge CFMutableStringRef)pinYin, NULL, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"不带声调的pinyin: %@", pinYin);
        }
        //3.去除掉首尾的空白字符和换行字符
        pinYinStr = [pinYin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //4.去除掉其它位置的空白字符和换行字符
        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"去掉空白字符和换行字符的pinyin: %@", pinYinStr);
        [pinYinStr capitalizedString];
        
    }
    return pinYinStr;
}

//- MARK: SDWebImageTest
- (void)SDWebImageTest {
    UIImageView *imageV = [UIImageView new];
    [imageV sd_setImageWithURL:[NSURL URLWithString:@"pic.png"] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageV.image = image;
        NSLog(@"图片加载完成");
    }];
}

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 370, kWidth - 20, 250)];
        _testLabel.textAlignment = NSTextAlignmentCenter;
        _testLabel.font = [UIFont systemFontOfSize:17];
        _testLabel.textColor = [UIColor blueColor];
        _testLabel.numberOfLines = 0;
    }
    return _testLabel;
}


/**
 首行缩进

 @param lineSpacing lineSpacing description
 @param firstLineHeadIndent firstLineHeadIndent description
 @param font font description
 @param textColor textColor description
 @return return value description
 */
- (NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor{
    //分段样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    //富文本样式
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : font,
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : textColor
                                   };
    return attributeDic;
}


/**
 JSCore 执行JS
 */
- (void)jsCoreTest {
    // 在 iOS 里面执行 JS
    JSContext *jsContext = [[JSContext alloc] init];
    [jsContext evaluateScript:@"var num = 500"];
    [jsContext evaluateScript:@"var computePrice = function(value) { return value * 2 }"];
     JSValue *value = [jsContext evaluateScript:@"computePrice(num)"];
     int  intVal = [value  toInt32];
     NSLog(@"计算结果为 %d", intVal);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


// 自己计算缓存大小
- (void)getFileSize {
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径，就能获得文件属性
    // 把所有文件尺寸加起来
    
    // 获取cache文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 获取default文件路径
    NSString *defaultPath = [cachePath stringByAppendingString:@"default"];
    
    // 遍历文件夹所有文件，累加
    
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径
    NSArray *subPaths = [mgr subpathsAtPath:defaultPath];
    
    // 获取文件属性
    NSDictionary *attr = [mgr attributesOfItemAtPath:defaultPath error:nil];
    
    // default尺寸
    NSInteger fileSize = [attr fileSize];
}

@end
