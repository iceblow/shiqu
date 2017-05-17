package com.daoshun.shiqu.controller.shop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.daoshun.shiqu.common.CommonUtils;


/**
 * 处理session超时的拦截器
 * @author shenyj
 *
 */
public class SessionInterceptorAction extends HandlerInterceptorAdapter{
	
	public String[] allowUrls;
	
	public void setAllowUrls(String[] allowUrls) {  
		 this.allowUrls = allowUrls;
	}
	
	@Override 
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception{
		String requestUrl = request.getRequestURI().replace(request.getContextPath(), "");
		if(null != allowUrls && allowUrls.length>=1)  
            for(String url : allowUrls) {
            	if(requestUrl.contains(url)){
            		return true;
            	}
            }
		long storeuserid = CommonUtils.parseInt(String.valueOf(request.getSession().getAttribute("storeuserid")), 0) ;  
        if(storeuserid == 0) {    
        	// 未登录  跳转到登录页面  
        	
        	response.getWriter().write( " <script> top.window.location.href= './index' </script> ");
        	return false;
        }else{
        	return true;
        }
      
	}
	
	 
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {  
    }  
  
    @Override  
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {  
    }  
}
