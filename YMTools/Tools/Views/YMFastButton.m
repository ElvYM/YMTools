//
//  YMFastButton.m
//  YMTools
//
//  Created by longxian on 2018/7/27.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "YMFastButton.h"

@implementation YMFastButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    switch (self.imageDirection) {
        case ImageDirectionTop:
            {
                // 设置图片位置
                self.imageView.y = 0;
                self.imageView.centerX = self.width * 0.5;

                
                // 设置标题位置
                self.titleLabel.y = self.height - self.titleLabel.height;
                
                //计算文字宽度
                [self.titleLabel sizeToFit];
                
                // 居中
                self.titleLabel.centerX = self.width * 0.5;

            }
            break;
        case ImageDirectionBottom:
        {
    
            // 设置标题位置
            self.titleLabel.y = 0;
            
            //计算文字宽度
            [self.titleLabel sizeToFit];
            
            // 居中
            self.titleLabel.centerX = self.width * 0.5;
            
            // 设置图片位置
            self.imageView.y = self.titleLabel.height;
            self.imageView.centerX = self.width * 0.5;
            
        }
            break;
            
        default:
            break;
    }
    
    
}


@end
