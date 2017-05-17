/**
 * 
 */
package com.daoshun.shiqu.common;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;

/**
 * 客户端的推送类
 * 
 * @author qiuch
 *
 */
public class JpushClientUtil {

	private static final String appKey = "ecbf2d3819a3c763fe7082d2";
	private static final String masterSecret = "31f172e9b7c15b6519cdc631";
	private JPushClient jpushClient;

	public JpushClientUtil() {
		jpushClient = new JPushClient(masterSecret, appKey, 3);
	}

	/**
	 * 个人（商家发送的）消息
	 * 
	 * @param title
	 * @param content
	 * @param registrationID
	 */
	public void sendMsgPush(String registrationID) {
		try {
			PushResult result = jpushClient.sendMessageWithRegistrationID("您有一条新消息", "{\"message\":\"有商家给您发了消息\",\"type\":1}", registrationID);
			System.out.println(result.toString());
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			System.out.println("HTTP Status: " + e.getStatus() + "Error Code: " + e.getErrorCode() + "Error Message: " + e.getErrorMessage() + "Msg ID: " + e.getMsgId());
		}
	}

	/**
	 * 优惠券（商家发送的）消息
	 * 
	 * @param title
	 * @param content
	 * @param registrationID
	 */
	public void sendCouponPush(String registrationID) {
		try {
			PushResult result = jpushClient.sendMessageWithRegistrationID("您有一条新消息", "{\"message\":\"有商家给你发送了优惠券\",\"type\":2}", registrationID);
			System.out.println(result.toString());
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			System.out.println("HTTP Status: " + e.getStatus() + "Error Code: " + e.getErrorCode() + "Error Message: " + e.getErrorMessage() + "Msg ID: " + e.getMsgId());
		}
	}

	/**
	 * 发公告
	 * 
	 * @param alert
	 */
	public void sendPush2All(String alert) {
		try {
			PushResult result = jpushClient.sendNotificationAll(alert);
			System.out.println(result.toString());
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			System.out.println("HTTP Status: " + e.getStatus() + "Error Code: " + e.getErrorCode() + "Error Message: " + e.getErrorMessage() + "Msg ID: " + e.getMsgId());
		}
	}
}
