package com.daoshun.shiqu.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daoshun.shiqu.common.CommonUtils;
import com.daoshun.shiqu.common.JpushClientUtil;
import com.daoshun.shiqu.pojo.MessageInfo;
import com.daoshun.shiqu.pojo.PushInfo;
import com.daoshun.shiqu.pojo.UserInfo;
import com.daoshun.shiqu.service.UserService;
import com.daoshun.shiqu.service.manage.MaCommonService;
import com.daoshun.shiqu.service.manage.MaNoticeService;

@Controller
public class ManageNoticeController extends ManageBaseController{

	@Resource(name = "maNoticeService")
	private MaNoticeService maNoticeService;

	@Resource(name = "maCommonService")
	private MaCommonService maCommonService;

	@Resource(name = "userService")
	UserService userService;

	@RequestMapping("/notice")
	public ModelAndView index(String phone, String password) {
		ModelAndView mov = new ModelAndView();
		mov.addObject("is_add", false);
		mov.setViewName("/manage/notice");
		return mov;
	}
	
	@RequestMapping("/addnotice")
	public ModelAndView addNotice(String title,String content) {
		ModelAndView mov = new ModelAndView();
		mov.addObject("is_add", true);
		//maNoticeService.addNotice(title,content);
		new JpushClientUtil().sendPush2All(content);
		mov.setViewName("/manage/notice");
		return mov;
	}

	@RequestMapping("/searchuser")
	public ModelAndView searchUser(String title, String content) {
		ModelAndView mov = new ModelAndView();
		List<UserInfo> userlist = maCommonService.getUserInfoList();
		mov.addObject("title", title);
		mov.addObject("content", content);
		mov.addObject("userlist", userlist);
		mov.setViewName("/manage/searchuser");
		return mov;
	}
	
	@RequestMapping("/message")
	public ModelAndView message(){
		ModelAndView mov = new ModelAndView();
		mov.addObject("pushtype", 1);
		mov.addObject("length", 0);
		mov.setViewName("/manage/message");
		return mov;
	}
	
	@RequestMapping("/sureSelectUser")
	public ModelAndView sureSelectUser(String user_id, String title, String content){
		ModelAndView mov = new ModelAndView();
		if(!CommonUtils.isEmptyString(user_id)){
			String[] list = user_id.split(",");
			mov.addObject("length", list.length);
		}else{
			mov.addObject("length", 0);
		}
		mov.addObject("user_ids", user_id);
		mov.addObject("title", title);
		mov.addObject("content", content);
		mov.addObject("pushtype", 2);
		mov.setViewName("/manage/message");
		return mov;
	}
	
	@RequestMapping("/addmessage")
	public void addmessage(int pushtype, String user_ids, String title, String content, HttpServletResponse response, HttpSession session){
		HashMap<String,Object> result = new HashMap<String,Object>();
		String message = "";
		if(pushtype == 2){
			if(!CommonUtils.isEmptyString(user_ids)){
				String[] idlist = user_ids.split(",");
				if(idlist != null && idlist.length > 0){
					for (String idstr : idlist) {
						UserInfo userinfo = userService.getUserInfo(CommonUtils.parseLong(idstr, 0));
						if(userinfo != null){
							PushInfo pushinfo = userService.getPushInfoByUser(userinfo.getUser_id());
							if(pushinfo != null){
								if(pushinfo.getIs_receive() == 0){
									JpushClientUtil jPushClientUtil = new JpushClientUtil();
									jPushClientUtil.sendMsgPush(pushinfo.getClient_id());
								}
							}
						}
					}
					MessageInfo messageinfo = new MessageInfo();
					messageinfo.setContent(content);
					messageinfo.setTitle(title);
					messageinfo.setStore_id(0);
					messageinfo.setUser_ids(user_ids);
					messageinfo.setAddtime(new Date());
					userService.addMessageInfo(messageinfo);
				}
			}
		}else{
			List<UserInfo> birthUserList = userService.getBirthUserList();
			String user_id = "";
			if(birthUserList != null && birthUserList.size() > 0){
				for (UserInfo userInfo : birthUserList) {
					if(userInfo != null){
						PushInfo pushinfo = userService.getPushInfoByUser(userInfo.getUser_id());
						if(pushinfo != null){
							if(pushinfo.getIs_receive() == 0){
								JpushClientUtil jPushClientUtil = new JpushClientUtil();
								jPushClientUtil.sendMsgPush(pushinfo.getClient_id());
							}
						}
						if(CommonUtils.isEmptyString(user_id)){
							user_id = userInfo.getUser_id()+"";
						}else{
							user_id = user_id + ","+userInfo.getUser_id();
						}
					}
				}
			}
			MessageInfo messageinfo = new MessageInfo();
			messageinfo.setContent(content);
			messageinfo.setTitle(title);
			messageinfo.setStore_id(0);
			messageinfo.setUser_ids(user_id);
			messageinfo.setAddtime(new Date());
			userService.addMessageInfo(messageinfo);
		}
		result.put("code", 1);
		message = "发送成功";
		result.put("message", message);
		CommonUtils.setMaptoJson(response, result);
	}
}
