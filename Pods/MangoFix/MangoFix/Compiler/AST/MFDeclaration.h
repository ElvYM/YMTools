//
//  MFDeclaration.h
//  MangoFix
//
//  Created by jerry.yong on 2017/11/20.
//  Copyright © 2017年 yongpengliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFDeclarationModifier.h"
@class MFTypeSpecifier;
@class MFExpression;

NS_ASSUME_NONNULL_BEGIN

@interface MFDeclaration: NSObject

@property (assign, nonatomic) NSUInteger lineNumber;
@property (strong, nonatomic) MFTypeSpecifier *type;
@property (assign,nonatomic) MFDeclarationModifier modifier;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic,nullable) MFExpression *initializer;
//@property (assign, nonatomic,getter=isParam) BOOL param;

@end

NS_ASSUME_NONNULL_END
