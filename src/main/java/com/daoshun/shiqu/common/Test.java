/**
 * 
 */
package com.daoshun.shiqu.common;

/**
 * @author qiuch
 *
 */
public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(CommonUtils.sendSms("13625812725", "测试短信验证码"));
		// new JpushShopUtil().sendPush("xxx桌xxx号", "010ab66485e");
		// System.out.println(CommonUtils.sendOrderPrint("815500519", "wtW8MYSz", "", ""+1));
		// new JpushClientUtil().sendMsgPush("070ef5ee82a");
		// new JpushClientUtil().sendPush2All("xxxxxxxxxxx");
	}
}
