//
//  NSString+Help.h
//  Rent
//
//  Created by TTc on 14-10-11.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(size)
+(CGFloat)getNeedHeight:(NSString *)text font:(UIFont*)font;
+(CGFloat)getNeedWidth:(NSString *)text font:(UIFont*)font;
@end



@interface NSString(Help)
//检测输入的全部是数字
+(BOOL) validateNumber: (NSString *) number;
//检测邮箱的格式
+(BOOL)validateEmail: (NSString *) candidate;
//只支持中英文下划线数字
+(BOOL)validateNick: (NSString *) candidate;
//只支持英文数字
+(BOOL)validatePassW: (NSString *) candidate;
// 第一个字符小写
- (NSString *)lowercaseFirstCharacter;
+ (NSInteger)StringToInt:(NSString*)str;
- (NSString *)uppercaseFirstCharacter;
+ (int)convertToInt:(NSString*)strtemp;

+(CGSize )getStringSizeWithFont:(NSString *)text  font:(UIFont*)font;
+(BOOL) isMobileNumber:(NSString *)mobileNum;

// 判断字符串是否为含有空格
- (BOOL)isEmpty;
-(NSString *) md5HexDigest;
+(NSString *) parseByte2HexString:(Byte *) bytes;

+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

+(NSString *)filterTheForeAndAftWhitespaceAndLineBreaks:(NSString *)string;
+(NSString *)UUID;
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+(NSString*)stringByFloat:(CGFloat)num;
@end
