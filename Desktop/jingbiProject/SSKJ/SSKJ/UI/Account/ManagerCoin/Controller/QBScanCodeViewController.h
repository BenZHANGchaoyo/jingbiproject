//
//  QBScanCodeViewController.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/5/8.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBScanCodeViewController : UIViewController
@property(nonatomic,copy)void(^codeScaningString)(NSString *string);
@end
