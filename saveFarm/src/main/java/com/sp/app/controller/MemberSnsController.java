package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.oauth.KakaoAuthService;
import com.sp.app.oauth.KakaoUser;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MemberSnsController {
	private final MemberService memberService;
	private final KakaoAuthService kakaoService;
	
	public static final String SNS_PROVIDER_KAKAO = "kakao";
	public static final String SNS_PROVIDER_NAVER = "naver";
	public static final String SNS_PROVIDER_GOOGLE = "google";

	@GetMapping("/oauth/kakao/callback")
	public void kakaoLogin(@RequestParam("code") String code, 
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		try {
			String accessToken = kakaoService.getAccessToken(code);
			KakaoUser kakaoUser = kakaoService.getUserInfo(accessToken);
			String sns_id = kakaoUser.getId().toString();
			String sns_provider = SNS_PROVIDER_KAKAO;
			
			Map<String, Object> map = new HashMap<>();
			map.put("sns_id", sns_id);
			map.put("sns_provider", sns_provider);
			
			Member dto = memberService.loginSnsMember(map);
			if(dto == null) {
				dto = new Member();
				
				dto.setSnsId(sns_id);
				dto.setSnsProvider(sns_provider);
				dto.setName(kakaoUser.getNickname());
				dto.setEmail(kakaoUser.getEmail());
				dto.setIpAddr(req.getRemoteAddr());
				
				memberService.insertSnsMember(dto);
			}
			
			// 세션에 로그인 정보 저장
			SessionInfo info = SessionInfo.builder()
					.memberId(dto.getMemberId())
					.loginId(dto.getSnsId())
					.name(dto.getName())
					.email(dto.getEmail())
					.userLevel(1)
					.login_type(dto.getSnsProvider())
					.build();
			
			// 세션 유지시간
			session.setMaxInactiveInterval(30 * 60); // 30분. 기본:30분
			
			// 세션에 로그인 정보 저장
			session.setAttribute("member", info);
			
		} catch (Exception e) {
			log.info("kakaoLogin : ", e);
		}
		
		String cp = req.getContextPath();
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = cp + "/";
		} else {
			uri = cp + uri;
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("window.opener.location.replace('" + uri + "');"); // 부모창
		sb.append("window.close();"); // 팝업창
		sb.append("</script>");

		// 팝업 창 닫기용 HTML
        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().println(sb.toString());
        resp.getWriter().flush();
	}
}

