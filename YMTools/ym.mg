class MangoFixUsageViewController:UIViewController {

- (void)setupUI{

   self.view.backgroundColor = UIColor.redColor;

   UIView *view = UIView.alloc().initWithFrame:(CGRectMake(50, 100, 100, 100));
   view.backgroundColor = UIColor.blackColor();
   self.view.addSubview:(view);

}

}
