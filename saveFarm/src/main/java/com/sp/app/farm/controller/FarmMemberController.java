package com.sp.app.farm.controller;

import java.util.HashMap;
import java.util.Map;

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

import com.sp.app.farm.model.Farm;
import com.sp.app.farm.model.SessionInfo;
import com.sp.app.farm.service.FarmMemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/farm/member/*")
public class FarmMemberController {

	private final FarmMemberService service;
	
	@GetMapping("login")
	public String loginForm() {
		return "farm/member/login";
	}
	
	@PostMapping("login")
	public String loginSubmit(
			@RequestParam(name = "farmerId") String farmerId,
			@RequestParam(name = "farmerPwd") String farmerPwd,
			Model model,
			HttpSession session
			){
	    Map<String,Object> map = new HashMap<>();
	    map.put("farmerId", farmerId);
	    map.put("farmerPwd", farmerPwd);

	    Farm dto = service.loginMember(map);

	    // ① dto 널 체크
	    if (dto == null) {
	        model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
	        return "farm/member/login";
	    }

	    // ② farmNum 널 가드 (정상이라면 쿼리에서 채워짐)
	    Long farmNum = dto.getFarmNum();
	    if (farmNum == null) {
	        model.addAttribute("message", "계정 정보가 올바르지 않습니다.(farmNum 누락)");
	        return "farm/member/login";
	    }

	    SessionInfo info = SessionInfo.builder()
	        .farmNum(farmNum)
	        .farmName(dto.getFarmName())
	        .businessNumber(dto.getBusinessNumber())
	        .farmerId(dto.getFarmerId())
	        .farmerName(dto.getFarmerName())
	        .farmerTel(dto.getFarmerTel())
	        .build();

	    session.setMaxInactiveInterval(30 * 60);
	    session.setAttribute("farm", info);

	    String uri = (String) session.getAttribute("preLoginURI");
	    session.removeAttribute("preLoginURI");
	    return (uri == null) ? "redirect:/farm" : "redirect:" + uri;
	}

	/*
	@PostMapping("login")
	public String loginSubmit(
			@RequestParam(name = "farmerId") String farmerId,
			@RequestParam(name = "farmerPwd") String farmerPwd,
			Model model,
			HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("farmerId", farmerId);
		map.put("farmerPwd", farmerPwd);
		
		Farm dto = service.loginMember(map);
		
		Long farmNum = dto.getFarmNum();
		if(farmNum == null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "farm/member/login";
		}
		
		SessionInfo info = SessionInfo.builder()
			    .farmNum(farmNum)
			    .businessNumber(dto.getBusinessNumber())
			    .farmerId(dto.getFarmerId())
			    .farmerName(dto.getFarmerName())
			    .farmerTel(dto.getFarmerTel())
			    .build();
		
		session.setMaxInactiveInterval(30 * 60); // 30분. 기본:30분
		
		session.setAttribute("farm", info); // farmer 로 세션에 저장이름 지정
		
		String uri = (String) session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if (uri == null) {
			uri = "redirect:/farm";
		} else {
			uri = "redirect:" + uri;
		}
		return uri;
	}
	*/
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("farm");
		session.invalidate();
		return "redirect:/farm";
	}
	
	
	@GetMapping("account")
	public String memberForm(Model model) {
		model.addAttribute("mode", "account");
		
		return "farm/member/member";
	}
	
	@PostMapping("account")
	public String memberSubmit(
			Farm dto, 
			final RedirectAttributes reAttr,
			Model model, 
			HttpServletRequest req) {
		
		try {
			service.insertFarm(dto);
			
			StringBuilder sb = new StringBuilder();
			sb.append(dto.getFarmerName() + "님의 회원 가입이 정상신청되었습니다.<br>");
			sb.append("관리자의 승인 이후 이용 가능합니다.<br>");
			
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("title", "회원 가입");

			return "redirect:/farm/member/complete";
			
		} catch (DuplicateKeyException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "이미 존재하는 아이디 또는 사업자등록번호로 회원가입이 실패했습니다.");
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
		} catch (Exception e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "회원가입이 실패했습니다.");
		}
		
		return "farm/member/member";
	}
	
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {
		if (message == null || message.isBlank()) {
			return "redirect:/farm";
		}

		return "farm/member/complete";
	}
	
	@ResponseBody
	@PostMapping("userIdCheck")
	public Map<String, ?> idCheck(@RequestParam(name = "farmerId", required = false) String farmerId)throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String p = "false";
		try {
			Farm dto = service.findByFarmerId(farmerId);
			if(dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		model.put("passed", p);
		
		return model;
	}
	
	@ResponseBody
	@PostMapping("userBusinessNumberCheck")
	public Map<String, ?> businessNumberheck(
			@RequestParam(name = "businessNumber") String businessNumber) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		String p = "false";
		String digits = businessNumber.replaceAll("\\D", "");
		
		try {
			Farm dto = service.findByBusinessNumber(digits);
			if(dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		model.put("passed", p);
		
		return model;
	}	
	
	/*
	@ResponseBody
	@PostMapping("businessNumberIdCheck")
	public Map<String, ?> businessNumberCheck(@RequestParam(name = "businessNumber") String businessNumber)throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		int p = 1;
		try {
			p = service.existsBusinessNumber(businessNumber);
		} catch (Exception e) {
		}
		model.put("passed", p);
		
		return model;
	}
	*/
	
	@GetMapping("pwd")
	public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout, 
			Model model) {

		if (dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}

		return "farm/member/pwd";
	}
	
	@PostMapping("pwd")
	public String pwdSubmit(
			@RequestParam (name = "password") String password,
			@RequestParam(name = "mode") String mode, 
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) {
		
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			if (info == null) {
	            reAttr.addFlashAttribute("message", "세션이 만료되었습니다. 다시 로그인해주세요.");
	            return "redirect:/farm/member/login";
			}
	            
			Farm dto = service.findByFarmerId(info.getFarmerId());
			
			if(! dto.getFarmerPwd().equals(password)) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");
				
				return "farm/member/pwd";
			}
			

			if (mode.equals("dropout")) {
				dto.setStatus(4);
				 service.updateStatus(dto, dto.getFarmNum());
				
				StringBuilder sb = new StringBuilder();
				sb.append(dto.getFarmName() + "(농가)의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

				reAttr.addFlashAttribute("title", "회원 탈퇴");
				reAttr.addFlashAttribute("message", sb.toString());

				session.invalidate();
				
				return "redirect:/farm/member/complete";
			}
			
			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			// 회원정보수정폼
			return "farm/member/member";
		} catch (NullPointerException e) {
			session.invalidate();
		} catch (Exception e) {
		}
		
		return "redirect:/farm";
	}
	
	
	@GetMapping("update")
	public String updateForm(HttpSession session, RedirectAttributes reAttr) {
		if (session.getAttribute("farm") == null) {
	        reAttr.addFlashAttribute("message", "로그인이 필요합니다.");
	        return "redirect:/farm/member/login";
	    }
	return "redirect:/farm/member/pwd";
	}
	
	@PostMapping("update")
	public String updateSubmit(
			Farm dto,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) {

		StringBuilder sb = new StringBuilder();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			dto.setFarmerId(info.getFarmerId());
			
			service.updateFarm(dto);
			
			sb.append(dto.getFarmName() + "(농가)의 회원정보가 정상적으로 변경되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		} catch (Exception e) {
			sb.append(dto.getFarmName()+ "(농가)의 회원정보 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
		}

		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/farm/member/complete";
	}
	
	// 패스워드 찾기
	@GetMapping("pwdFind")
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("farm");
		
		if(info != null) {
			return "redirect:/farm";
		}
		
		return "farm/member/pwdFind";
	}
	
	@PostMapping("pwdFind")
	public String pwdFindSubmit(
			@RequestParam(name = "farmerId") String farmerId,
			RedirectAttributes reAttr,
			HttpSession session,
			Model model) throws Exception {
		
		Farm dto = service.findByFarmerId(farmerId);
		try {
			if(dto == null || dto.getStatus() != 3) {
				model.addAttribute("message", "등록된 아이디가 아닙니다.");
				
				return "farm/member/pwdFind";
			}
			
			service.generatePwd(dto);
			
			session.setAttribute("pwdFindFarmerId", dto.getFarmerId());
			
			StringBuilder sb = new StringBuilder();
			sb.append("비밀번호가 임시비밀번호로 바뀌었습니다.<br>");
			sb.append("새비밀번호로 변경하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "비밀번호 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("mode", "pwdFind");
			reAttr.addFlashAttribute("farmerId", farmerId);
			
			return "redirect:/farm/member/complete";
		} catch (Exception e) {
			log.info("pwdFindSubmit : ",  e);
			model.addAttribute("message", "처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
		}
		
		return "farm/member/pwdFind";
	}
	
	@GetMapping("pwdChange")
	public String pwdChangeForm(
			HttpSession session,
			RedirectAttributes reAttr, 
			Model model) {
		 String farmerId = (String) session.getAttribute("pwdFindFarmerId");
		
		 if (farmerId == null) {
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info != null) {
	            farmerId = info.getFarmerId();
	        }
	    }
		 
		 if (farmerId == null) {
	        reAttr.addFlashAttribute("message", "비밀번호 변경 절차를 다시 시작해 주세요.");
	        return "redirect:/farm/member/pwdFind";
	    }

        // 뷰에서 히든으로 사용할 수 있도록 모델에 실어줌(선택)
        model.addAttribute("farmerId", farmerId);
        return "farm/member/pwdChange";
	}
	
	@PostMapping("pwdChange")
	public String pwdChangeSubmit(
			@RequestParam(name = "password") String password,
            RedirectAttributes reAttr,
            HttpSession session,
			Model model) throws Exception {
		
		String farmerId = (String) session.getAttribute("pwdFindFarmerId");
	    if (farmerId == null) {
	        SessionInfo info = (SessionInfo) session.getAttribute("farm");
	        if (info != null) {
	            farmerId = info.getFarmerId();
	        }
	    }
	    if (farmerId == null) {
	        reAttr.addFlashAttribute("message", "비밀번호 변경 절차를 다시 시작해 주세요.");
	        return "redirect:/farm/member/pwdFind";
	    }
		
	    StringBuilder sb = new StringBuilder();
	    Farm dto = service.findByFarmerId(farmerId);
		try {
			if(dto == null || dto.getStatus() != 3) {
				model.addAttribute("message", "등록된 아이디가 아닙니다.");
				
				return "farm/member/pwdFind";
			}
			
			dto.setFarmerPwd(password);
			service.updatePassword(dto);
			
			session.removeAttribute("pwdFindFarmerId");
			
			sb.append(dto.getFarmName() + "(농가)의 비밀번호의 변경이 정상적으로 변경되었습니다.<br>");
			sb.append("성공적으로 변경되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "비밀번호 변경");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/farm/member/complete";
		} catch (Exception e) {
			sb.append(dto.getFarmName()+ "(농가)의 비밀번호의 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
			reAttr.addFlashAttribute("message", sb.toString());
		}
		
		return "farm/member/pwdChange";
	}
	
	@GetMapping("idFind")
	public String idFindForm (HttpSession session) {
		SessionInfo info = (SessionInfo)session.getAttribute("farm");
		
		if(info != null) {
			return "redirect:/farm";
		}
		
		return "farm/member/idFind";
	}
	
	@PostMapping("idFind")
	public String idFindSubmit(
			@RequestParam(name = "businessNumber") String businessNumber,
			@RequestParam(name = "farmerName") String farmerName,
			@RequestParam(name = "farmerTel") String farmerTel,
			RedirectAttributes reAttr,
			Model model) throws Exception {
		
		try {
			Farm dto = service.findFarmerId(businessNumber, farmerName, farmerTel);
			if(dto == null || dto.getStatus() != 3) {
				model.addAttribute("message", "존재하는 아이디가 아닙니다.");
				
				return "farm/member/idFind";
			}
			
			StringBuilder sb = new StringBuilder();
			sb.append( dto.getFarmName() + "농가의 아이디는 " + dto.getFarmerId() + "입니다.<br>");
			sb.append("서비스를 이용하시길 원한다면 로그인해주시길 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "아이디 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/farm/member/complete";
		} catch (Exception e) {
			log.info("idFindSubmit : ",  e);
		}
		
		return "farm/member/idFind";
	}
	
	@ResponseBody
	@PostMapping("ExsistedUserCheck")
	public Map<String, ?> ExsistedUserCheck(
			@RequestParam(name = "businessNumber") String businessNumber,
			@RequestParam(name = "farmerName", required = false) String farmerName,
			@RequestParam(name = "farmerTel", required = false) String farmerTel,
			HttpSession session)throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		int passedBN = 0;
		String passedFRN = null;
		
		try {
			if(service.existsBusinessNumber(businessNumber) != 0) {
				passedBN = service.existsBusinessNumber(businessNumber);
			}
			
			SessionInfo info = (SessionInfo) session.getAttribute("farm");
			if (info != null) {
	            Farm dto = service.findByFarmerId(info.getFarmerId());
	            if (dto != null) {
	                if (farmerName != null && !dto.getFarmerName().equals(farmerName)) {
	                    model.put("message", "이름이 일치하지 않습니다.");
	                }
	                if (farmerTel != null && !dto.getFarmerTel().equals(farmerTel)) {
	                    model.put("message", "전화번호가 일치하지 않습니다.");
	                }
	            }
	        }
			/*
			Farm dto = Objects.requireNonNull(service.findByFarmerId(info.getFarmerId()));
			if(! dto.getFarmerName().equals(farmerName)) {
				model.put("message", "이름이 일치하지 않습니다.");
			}
			if(! dto.getFarmerTel().equals(farmerTel)) {
				model.put("message", "전화번호가 일치하지 않습니다.");
			}
			*/
		} catch (Exception e) {
		}

		model.put("passedBN", passedBN);
		
		return model;
	}
	
	@GetMapping("noAuthorized")
	public String noAuthorized(Model model) {
		return "farm/member/noAuthorized";
	}
}
