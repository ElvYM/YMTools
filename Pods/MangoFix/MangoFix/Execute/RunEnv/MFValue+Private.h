//
//  MFValue+Private.h
//  MangoFix
//
//  Created by yongpengliang on 2019/3/28.
//  Copyright © 2019 yongpengliang. All rights reserved.
//

#import <MangoFix/MangoFix.h>

NS_ASSUME_NONNULL_BEGIN

@interface MFValue (Private)
@property (strong, nonatomic)MFTypeSpecifier *type;
- (void)assignFrom:(MFValue *)src;
- (void)assign2CValuePointer:(void *)cvaluePointer typeEncoding:(const char *)typeEncoding;
- (instancetype)initWithCValuePointer:(void *)cValuePointer typeEncoding:(const char *)typeEncoding bridgeTransfer:(BOOL)bridgeTransfer;

@end

NS_ASSUME_NONNULL_END
