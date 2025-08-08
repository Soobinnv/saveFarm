package com.sp.app.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		boolean result = true;

		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			String cp = req.getContextPath();
			String uri = req.getRequestURI();
			String queryString = req.getQueryString();

			if (info == null) {
				result = false;

				if (isAjaxRequest(req)) {
					resp.sendError(401);
				} else {
					if (uri.indexOf(cp) == 0) {
						uri = uri.substring(cp.length());
					}
					
					if (queryString != null) {
						uri += "?" + queryString;
					}

					session.setAttribute("preLoginURI", uri);
					resp.sendRedirect(cp + "/member/login");
				}
			} else {
				if(uri.indexOf("admin") != -1 && info.getUserLevel() < 51) {
					result = false;
					resp.sendRedirect(cp + "/member/noAuthorized");
				}
			}
		} catch (Exception e) {
			log.info("pre: " + e.toString());
		}

		return result;
	}

	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse resp, Object handler, ModelAndView modelAndView)
			throws Exception {
	}


	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse resp, Object handler, Exception ex)
			throws Exception {
	}

	private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		return header != null && header.equals("true");
	}

}
