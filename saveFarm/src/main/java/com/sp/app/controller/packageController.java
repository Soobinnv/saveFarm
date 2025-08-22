package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.PackageOrder;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.packageReview;
import com.sp.app.service.PackageReviewService;
import com.sp.app.service.packageService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/package/*")
public class packageController {

	private final packageService packageService;
	private final StorageService storageService;
	private final PackageReviewService packageReviewService;
	private final PaginateUtil paginateUtil;

	private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/PackageReview");
	}

	@GetMapping("main")
	public String mainForm() {
		return "package/main";
	}

	@GetMapping("homepackage")
	public String homepackage(Model model) throws Exception {

		model.addAttribute("mode", "homePackage");
		model.addAttribute("price", 18000);

		return "package/packageCart";
	}

	@GetMapping("saladpackage")
	public String salpackage(Model model) throws Exception {

		model.addAttribute("mode", "saladPackage");
		model.addAttribute("price", 20000);
		return "package/packageCart";
	}

	@PostMapping("payForm")
	public String packageSubmit(PackageOrder dto, HttpSession session, final RedirectAttributes reAttr)
			throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			dto.setMemberId(info.getMemberId());
			dto.setSubNum(packageService.subPackageNumber());
			dto.setSubMonth(1);
			
			packageService.insertPackageOrder(dto);

			StringBuilder sb = new StringBuilder();
			sb.append(info.getName() + "님 상품을 구매해 주셔서 감사 합니다.<br>");
			sb.append("주문하신 상품은 매달" + "일에 결제 됩니다 .<br>");
			sb.append("결제 금액 : <label class='fs-5 fw-bold text-primary'>" + dto.getTotalPay() + "</label>원");

			reAttr.addFlashAttribute("title", "정기 구독 완료");
			reAttr.addFlashAttribute("message", sb.toString());

			return "redirect:/package/complete";

		} catch (Exception e) {
			log.info("packageSubmit :", e);
		}

		return "redirect:/";
	}

	@GetMapping("complete")
	public String complete(@ModelAttribute("title") String title, @ModelAttribute("message") String message)
			throws Exception {

		if (message == null || message.isBlank()) {
			return "redirect:/";
		}

		return "order/complete";
	}

	@GetMapping("reviewWriteForm")
	public String reviewWriteForm() throws Exception {

		return "package/reviewwrite";
	}

	@PostMapping("reviewSubmit")
	public String reviewSubmit(packageReview dto) throws Exception {

		packageReviewService.insertPackageReview(dto, uploadPath);

		return "redirect:/";
	}

	@GetMapping("reviewList")
	public String reviewList() throws Exception {

		return "package/reviewList";
	}
	
	@ResponseBody
	@GetMapping("list")
	public Map<String, ?> list(@RequestParam(name = "pageNo", defaultValue = "1") int current_page, HttpSession session)
			throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();

		try {
			
			int size = 9;
			int dataCount = packageReviewService.countReview();

			int total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("offset", offset);
			map.put("size", size);

			List<packageReview> list = packageReviewService.listReview(map);
			/*
			 * 삭제 짜면 if(info != null) { for(packageReview dto : list) {
			 * if(info.getMember_id() == info.getMember_id()) { dto.setDeletePermit(true); }
			 * } }
			 */

			String paging = paginateUtil.pagingMethod(current_page, total_page, "listReview");

			model.put("list", list);
			model.put("dataCount", dataCount);
			model.put("size", size);
			model.put("pageNo", current_page);
			model.put("paging", paging);
			model.put("total_page", total_page);

		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("list : ", e);
		}
		return model;

	}

}
