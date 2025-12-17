//
//  HJAppleWalletManager.m
//  AppleWallet_band_App_card
//
//  Created by Bright on 12/16/25.
//

#import "HJAppleWalletManager.h"
#import <PassKit/PassKit.h>
//#import "WLApplePayDataModel.h"
//#import "WLApplePayProtocol.h"

@interface HJAppleWalletManager ()<PKAddPaymentPassViewControllerDelegate>



@end

@implementation HJAppleWalletManager


/**
// 设备是否支持applepay
// */
//+ (BOOL)isSupportApplePay {
//    BOOL isSurport = [PKAddPaymentPassViewController canAddPaymentPass];
//    return isSurport;
//}
//
///// 是否可以添加到apple wallet
//+ (void)canAddApplePlayWithProtocol:(id<WLApplePayProtocol>)cardDataProtocol compeleteBlock:(void(^)(WLApplePayDataModel *cardData, BOOL canAddApplePay))compeleteBlock {
//    if ([cardDataProtocol respondsToSelector:@selector(reuestFpanIdAndCardDataCompleteBlock:)]) {
//        [cardDataProtocol reuestFpanIdAndCardDataCompleteBlock:^(WLApplePayDataModel * _Nonnull cardDataModel) {
//            // 获取卡信息
//            [self determineCanAddCardData:cardDataModel compeleteBlock:compeleteBlock];
//        }];
//    }
//    
//}
//
//+ (void)determineCanAddCardData:(WLApplePayDataModel *)cardDataModel compeleteBlock:(void(^)(WLApplePayDataModel *cardData, BOOL canAddApplePay))compeleteBlock {
//    NSString *fPanId = cardDataModel.fPanId;
//    
//    // 获取苹果wallet里面所有的卡
//    PKPassLibrary *pk = [[PKPassLibrary alloc] init];
//    NSArray<PKPass *>* passTypeArr = [pk passesOfType:PKPassTypePayment];
//    
//    // 是否可以加入到apple pay
//    BOOL canAddApplePay = NO;
//    // 是否在钱包里
//    BOOL isInAppleWallet = NO;
//    for (PKPaymentPass *paymentPass in passTypeArr) {
//        // 判断卡片是否存在wallet里
//        
//        if ([paymentPass.primaryAccountIdentifier isEqualToString:fPanId]) {
//            isInAppleWallet = YES;
//            break;
//        }
//    }
//    
//    if (isInAppleWallet) {
//        canAddApplePay = [pk  canAddPaymentPassWithPrimaryAccountIdentifier:fPanId];
//    } else {
//        // 不在钱包里，则显示加入按钮
//        canAddApplePay = YES;
//    }
//    
//    compeleteBlock(cardDataModel, canAddApplePay);
//}
//
///* Certificates is an array of NSData, each a DER encoded X.509 certificate, with the leaf first and root last.
// * The continuation handler must be called within 20 seconds or an error will be displayed.
// * Subsequent to timeout, the continuation handler is invalid and invocations will be ignored.
// */
///*证书是一个NSData数组，每个都是DER编码的X.509证书，叶子在前，根在后。
//*必须在20秒内调用延续处理程序，否则将显示错误。超时后，延续处理程序无效，调用将被忽略。
//*/
//- (void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller
// generateRequestWithCertificateChain:(NSArray<NSData *> *)certificates
//                               nonce:(NSData *)nonce
//                      nonceSignature:(NSData *)nonceSignature
//                   completionHandler:(void(^)(PKAddPaymentPassRequest *request))handler {
//    
//    // 苹果服务器返回给wallet、wallet再返回给app的东西 -- certificates、nonce、nonceSignature。
//    // app需要将这个发送给issuer host 。
////    __weak typeof(self) weakSelf = self;
//    
//    [self exchangeInformWithIssuerHostWithCertificates:certificates nonce:nonce nonceSignature:nonceSignature completeBlock:^(WLApplePayDataModel * _Nonnull dataModel) {
//        // issuer返回三个传，app转成NSData再回传给apple。
//        PKAddPaymentPassRequest *request = [[PKAddPaymentPassRequest alloc] init];
//        // issuer host 返回的 encryptedPassData、ephemeralPublicKey、activationData
//        NSString *encryptedPassData = dataModel.encryptedPassData;
//        NSString *activationData = dataModel.activationData;
//        NSString *ephemeralPublicKey = dataModel.ephemeralPublicKey;
////        weakSelf.cardType = dataModel.cardType;
//    
//        request.encryptedPassData = [[NSData alloc] initWithBase64EncodedString:encryptedPassData options:0];
//        request.activationData = [[NSData alloc] initWithBase64EncodedString:activationData options:0];
//        request.ephemeralPublicKey = [[NSData alloc] initWithBase64EncodedString:ephemeralPublicKey options:0];
//        // 回传apple
//        handler(request);
//    }];
//}
//
//
//
//- (void)exchangeInformWithIssuerHostWithCertificates:(NSArray *)certificates nonce:(NSData *)nonce nonceSignature:(NSData *)nonceSignature completeBlock:(void (^)(WLApplePayDataModel * dataModel))completeBlcok {
//    NSMutableArray *certArr = [NSMutableArray array];
//    // 将证书放到数组里面，传给server
//    for (NSData *data in certificates) {
//        NSString *base64String = [data base64EncodedStringWithOptions:0];
//        [certArr addObject:base64String];
//    }
//    NSString *nonceBase64 = [nonce base64EncodedStringWithOptions:0];
//
//    NSString *nonceSignatureBase64 = [nonceSignature base64EncodedStringWithOptions:0];
//
//    
////    NSDictionary *bodyDic = @{
////        @"certificates":certArr,
////        @"nonce":nonceBase64,
////        @"nonceSignature":nonceSignatureBase64,
//////        @"cardId":self.cardId?:@""
////    };
////    ShowHUDInWindow;
////    [WLAFRequestAdaptor bochk_CallbackDataByApplePayWithParameters:bodyDic success:^(id task, WLRespondDataModel *respondModel) {
////        HiddenHUDInWindow;
////        if ([respondModel.errorCode isEqualToString:ERRORCODE_SUCCESS]) {
////            WLApplePayDataModel *model = [WLApplePayDataModel yy_modelWithDictionary:respondModel.respondData];
////            completeBlcok(model);
////        } else {
//////            [QHWAlertView showWithMessage:respondModel.errorMsg  oneHandlerTitle:WLLocalizedString(@"确认") handler:^() {
//////            }];
////                NotificationInformAlertView *view = [NotificationInformAlertView createFromXib];
////                [view showWithMessage:[NSString stringWithFormat:@"%@", respondModel.errorMsg]];
////
////        }
////        
////    } failure:^(id task, NSError *error) {
////        HiddenHUDInWindow;
////        [QHWAlertView showWithMessage:[WLRequestParamsTool reuqestErroMessage:error]  oneHandlerTitle:WLLocalizedString(@"确认") handler:^() {
////        }];
////    }];
//    
//}
//
///* Error parameter will use codes from the PKAddPaymentPassError enumeration, using the PKPassKitErrorDomain domain.
// */
///* Error参数将使用来自PKAddPaymentPassError枚举的代码，使用PKPassKitErrorDomain域。
//*/
//- (void)addPaymentPassViewController:(PKAddPaymentPassViewController *)controller didFinishAddingPaymentPass:(PKPaymentPass *)pass error:(NSError *)error {
//    NSLog(@"%@", error);
//    //    NotificationInformAlertView *view = [NotificationInformAlertView createFromXib];
//    //    [view showWithMessage:[NSString stringWithFormat:@"%@", error]];
//    
////    [UIApplication setStatusBarForLightContentWithAnimated:YES];
////    [controller dismissViewControllerAnimated:YES completion:nil];
////    // 取消和失败
////    if (pass != nil) {
////        if (self.applePayCompleteBlock) {
////            self.applePayCompleteBlock(YES, self.cardType);
////        }
////    } else {
////        if (self.applePayCompleteBlock) {
////            self.applePayCompleteBlock(NO, self.cardType);
////        }
////    }
//}
//
//
//
///// 通过pandId列表判断卡版本是否或者已经添加到applepay里面。YES，已添加到wallet，显示已添加。NO没添加，显示可添加
///// @param pandDataArray pandata列表，后台返回的fpandId. 一张卡可能会有多个fpandid，因为这张卡可能会在多个设备上绑定
//+ (BOOL)isExistInAppleWallet:(NSArray<WLCardPandDataModel *> *)pandDataArray {
//    
//    PKPassLibrary *pk = [[PKPassLibrary alloc] init];
//    // 获取苹果wallet里面所有的卡
//    NSArray<PKPass *>* passTypeArr = [pk passesOfType:PKPassTypePayment];
//    
//    // 遍历后台返回的fpandid
//    for (WLCardPandDataModel *panDataModel in pandDataArray) {
//        
//        // 遍历wallet里面的卡列表
//        for (PKPass *paymentPass in passTypeArr) {
//            // 通过fpandid找到对应的卡,
//            if ([paymentPass.paymentPass.primaryAccountIdentifier isEqualToString:panDataModel.spanId]) {
//                // 判断是否可加入
//                BOOL canAdd = [pk canAddPaymentPassWithPrimaryAccountIdentifier:panDataModel.spanId];
//                if (canAdd == NO) {
//                    // 不能再加了，就证明已经存在了。
//                    return YES;
//                }
//            }
//        }
//
//    }
//    
//    return NO;
//}
//


@end
