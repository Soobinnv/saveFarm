package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.sp.app.common.StorageService;
import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;
import com.sp.app.service.MyShoppingService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {

	private final MemberService service;
	private final StorageService storageService;
	private final MyShoppingService shoppingService;
	
	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/member");		
	}
	
	@GetMapping("login")
	public String loginForm() {
		return "member/login";
	}
	
	@PostMapping("login")
	public String loginSubmit(@RequestParam(name = "loginId") String loginId,
			@RequestParam(name = "password") String password,
			Model model,
			HttpSession session) {

		Map<String, Object> map = new HashMap<>();
		map.put("loginId", loginId);
		map.put("password", password);
		
		System.out.println(loginId);
		System.out.println(password);
		
		Member dto = service.loginMember(map);
		if (dto == null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "member/login";
		}
		
		int cartSize = shoppingService.getCartSize(dto.getMemberId());
		
		SessionInfo info = SessionInfo.builder()
				.memberId(dto.getMemberId())
				.loginId(dto.getLoginId())
				.name(dto.getName())
				.email(dto.getEmail())
				.userLevel(dto.getUserLevel())
				.avatar(dto.getProfilePhoto())
				.login_type("local")
				.cartSize(cartSize)
				.build();
		
		session.setMaxInactiveInterval(30 * 60); // 30분. 기본:30분
		
		session.setAttribute("member", info);
		
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = "redirect:/";
			System.out.println("312313");
		} else {
			uri = "redirect:" + uri;
			System.out.println("엥엥");
		}

		return uri;
	}

	@GetMapping("logout")
	public String logout(HttpSession session) {

		session.removeAttribute("member");

		session.invalidate();

		return "redirect:/";
	}

	@GetMapping("account")
	public String memberForm(Model model) {
		model.addAttribute("mode", "account");
		
		return "member/member";
	}

	@PostMapping("account")
	public String memberSubmit(Member dto,
			final RedirectAttributes reAttr,
			Model model,
			HttpServletRequest req) {

		try {
			dto.setIpAddr(req.getRemoteAddr());
			
			service.insertMember(dto, uploadPath);
			
			StringBuilder sb = new StringBuilder();
			sb.append(dto.getName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("title", "회원 가입");

			return "redirect:/member/complete";
			
		} catch (DuplicateKeyException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
		} catch (Exception e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "회원가입이 실패했습니다.");
		}

		return "member/member";
	}


	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		if (message == null || message.isBlank()) {
			return "redirect:/";
		}

		return "member/complete";
	}

	@ResponseBody
	@PostMapping("userIdCheck")
	public Map<String, ?> idCheck(@RequestParam(name = "login_id") String login_id) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String p = "false";
		try {
			Member dto = service.findById(login_id);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		
		model.put("passed", p);
		
		return model;
	}
	
	@GetMapping("pwd")
	public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout, 
			Model model) {

		if (dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}

		return "member/pwd";
	}

	@PostMapping("pwd")
	public String pwdSubmit(@RequestParam(name = "password") String password,
			@RequestParam(name = "mode") String mode, 
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Member dto = Objects.requireNonNull(service.findById(info.getMemberId()));

			if (! dto.getPassword().equals(password)) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");
				
				return "member/pwd";
			}

			if (mode.equals("dropout")) {

				// 세션 정보 삭제
				session.removeAttribute("member");
				session.invalidate();

				StringBuilder sb = new StringBuilder();
				sb.append(dto.getName() + "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

				reAttr.addFlashAttribute("title", "회원 탈퇴");
				reAttr.addFlashAttribute("message", sb.toString());

				return "redirect:/member/complete";
			}

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			// 회원정보수정폼
			return "member/member";
			
		} catch (NullPointerException e) {
			session.invalidate();
		} catch (Exception e) {
		}
		
		return "redirect:/";
	}

	@PostMapping("update")
	public String updateSubmit(Member dto,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) {

		StringBuilder sb = new StringBuilder();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.updateMember(dto, uploadPath);
			
			// 세션의 profile photo 변경
			info.setAvatar(dto.getProfilePhoto());
			
			sb.append(dto.getName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		} catch (Exception e) {
			sb.append(dto.getName() + "님의 회원정보 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
		}

		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}

	// 패스워드 찾기
	@GetMapping("pwdFind")
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info != null) {
			return "redirect:/";
		}
		
		return "member/pwdFind";
	}
	
	@PostMapping("pwdFind")
	public String pwdFindSubmit(@RequestParam(name = "login_id") String login_id,
			RedirectAttributes reAttr,
			Model model) throws Exception {
		
		try {
			Member dto = service.findById(login_id);
			if(dto == null || dto.getEmail() == null || dto.getUserLevel() == 0 || dto.getEnabled() == 0) {
				model.addAttribute("message", "등록된 아이디가 아닙니다.");
				
				return "member/pwdFind";
			}
			
			service.generatePwd(dto);
			
			StringBuilder sb = new StringBuilder();
			sb.append("회원님의 이메일로 임시 비밀번호를 전송했습니다.<br>");
			sb.append("로그인 후 비밀번호를 변경하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "패스워드 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/member/complete";
			
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
		}
		
		return "member/pwdFind";
	}
	
	@ResponseBody
	@PostMapping("deleteProfile")
	public Map<String, ?> deleteProfilePhoto(@RequestParam(name = "profile_photo") String profile_photo,
			HttpSession session) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		String state = "false";
		try {
			if(! profile_photo.isBlank()) {
				Map<String, Object> map = new HashMap<>();
				map.put("member_id", info.getMemberId());
				map.put("filename", info.getAvatar());
				
				service.deleteProfilePhoto(map, uploadPath);
				
				info.setAvatar("");
				state = "true";
			}
		} catch (Exception e) {
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@GetMapping("noAuthorized")
	public String noAuthorized(Model model) {
		return "member/noAuthorized";
	}
	
}