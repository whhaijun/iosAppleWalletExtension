//
//  ViewController.m
//  AppleWallet_band_App_card
//
//  Created by Bright on 12/16/25.
//

#import "ViewController.h"
#import "AppGroupShared.h"
#import "ProvisioningCredential.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self saveMockPaymentPassCredentials];
    
    
}

// 在 AppGroupShared.m 中实现方法
- (void)saveMockPaymentPassCredentials {
    NSMutableDictionary<NSString *, ProvisioningCredential *> *mockCredentials = [NSMutableDictionary dictionary];
    
    // 创建模拟的银行卡数据1
    ProvisioningCredential *card1 = [[ProvisioningCredential alloc]
        initWithPrimaryAccountIdentifier:@"acct_1234567890"
                                   label:@"我的金卡"
                               assetName:@"gold_card"
                isAvailableForProvisioning:YES
                         cardholderName:@"张三"
                   localizedDescription:@"个人信用卡 - 金卡"
                    primaryAccountSuffix:@"4321"
                             expiration:@"12/25"];
    
    // 创建模拟的银行卡数据2
    ProvisioningCredential *card2 = [[ProvisioningCredential alloc]
        initWithPrimaryAccountIdentifier:@"acct_9876543210"
                                   label:@"白金信用卡"
                               assetName:@"platinum_card"
                isAvailableForProvisioning:YES
                         cardholderName:@"李四"
                   localizedDescription:@"企业白金信用卡"
                    primaryAccountSuffix:@"8765"
                             expiration:@"06/26"];
    
    // 创建模拟的银行卡数据3（不可用于配置）
    ProvisioningCredential *card3 = [[ProvisioningCredential alloc]
        initWithPrimaryAccountIdentifier:@"acct_5555555555"
                                   label:@"借记卡"
                               assetName:@"debit_card"
                isAvailableForProvisioning:NO  // 标记为不可配置
                         cardholderName:@"王五"
                   localizedDescription:@"个人借记卡"
                    primaryAccountSuffix:@"1234"
                             expiration:@"09/24"];
    
    // 将凭据添加到字典中，使用主账户标识符作为键
    mockCredentials[card1.primaryAccountIdentifier] = card1;
    mockCredentials[card2.primaryAccountIdentifier] = card2;
    mockCredentials[card3.primaryAccountIdentifier] = card3;
    
    // 将字典转换为NSData进行存储
    NSError *error = nil;
    NSData *credentialsData = [NSKeyedArchiver archivedDataWithRootObject:mockCredentials
                                                     requiringSecureCoding:YES
                                                                     error:&error];
    
    if (error) {
        NSLog(@"归档凭据数据时出错: %@", error.localizedDescription);
        return;
    }
    
    if (credentialsData) {
        // 保存到App Group共享的UserDefaults
        [AppGroupShared.appGroupSharedDefaults setObject:credentialsData forKey:@"PaymentPassCredentials"];
        
        // 同时设置认证要求标志
        [AppGroupShared.appGroupSharedDefaults setBool:YES forKey:@"ShouldRequireAuthenticationForAppleWallet"];
        
        // 强制立即保存
        [AppGroupShared.appGroupSharedDefaults synchronize];
        
        NSLog(@"成功保存 %lu 张模拟银行卡凭据", (unsigned long)mockCredentials.count);
        NSLog(@"保存的数据大小: %lu 字节", (unsigned long)credentialsData.length);
    }
}


@end
