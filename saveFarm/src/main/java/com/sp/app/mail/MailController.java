package com.sp.app.mail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mail/*")
public class MailController {
	private final MailSender mailSender;
	
	@GetMapping("send")
	public String sendForm(Model model) throws Exception {

		return "mail/send";
	}

	@PostMapping("send")
	public String sendSubmit(Mail dto, 
			final RedirectAttributes reAttr) throws Exception {

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		boolean b = mailSender.mailSend(dto);
		
		String msg = "<span style='color:blue;'>" + dto.getReceiverEmail() + "</span> 님에게<br>";
		if( b ) {
			msg += "메일을 성공적으로 전송 했습니다.";
		} else {
			msg += "메일을 전송하는데 실패했습니다.";
		}
		
		reAttr.addFlashAttribute("message", msg);
		
		return "redirect:/mail/complete";
	}
	
	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다. 
		// F5를 눌러 새로 고침을 하면 null이 된다.
		
		if(message == null || message.length() == 0) // F5를 누른 경우
			return "redirect:/";
		
		return "mail/complete";
	}
}
