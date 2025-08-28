package com.sp.app.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
	    HandlerInterceptor farmGuard = new HandlerInterceptor() {
	    	
	        @Override
	        public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object h) throws Exception {
	            HttpSession s = req.getSession(false);
	            if (s != null && s.getAttribute("farm") != null) return true;
	        res.sendRedirect(req.getContextPath() + "/farm/member/login");
	        return false;
	    }
	};
	
	registry.addInterceptor(farmGuard)
	        .addPathPatterns("/farm/**")      
	        .excludePathPatterns(
	                "/farm", "/farm/",    
	                
	                "/farm/guide",
	                
	                "/farm/FAQ/**",
	                "/farm/notice/**",
	                "/farm/inquiry",
	                
	                "/farm/member/login",
	                "/farm/member/account",
	                "/farm/member/idFind",
	                "/farm/member/pwdFind",
	                
	                "/dist/**", 
	                "/favicon.ico", "/error"
	        );
	}
}
