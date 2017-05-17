/**
 * 
 */
package com.daoshun.shiqu.common;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;

/**
 * 商户端的推送类
 * 
 * @author qiuch
 *
 */
public class JpushShopUtil {

	private static final String appKey = "582fb8df8cc78face56cf292";
	private static final String masterSecret = "dd32386df819ae9689a33a91";
	private JPushClient jpushClient;

	public JpushShopUtil() {
		jpushClient = new JPushClient(masterSecret, appKey, 3);
	}

	public void sendPush(String tableNum, String registrationID) {
		try {
			PushResult result = jpushClient.sendAndroidNotificationWithRegistrationID("呼叫服务", tableNum + "呼叫服务", null, registrationID);
			System.out.println(result.toString());
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			System.out.println("HTTP Status: " + e.getStatus() + "Error Code: " + e.getErrorCode() + "Error Message: " + e.getErrorMessage() + "Msg ID: " + e.getMsgId());
		}
	}
}
