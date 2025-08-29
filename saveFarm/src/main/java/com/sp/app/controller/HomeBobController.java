package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.HomeBob;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.HomeBobService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/homebob/*")
public class HomeBobController {
	private final HomeBobService service;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;
	
	private String uploadPath;

	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/homebob");	
	}
	
	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req,
			HttpSession session) throws Exception {

		try {
			int size = 6;
			int total_page;
			int dataCount;

			kwd = myUtil.decodeUrl(kwd);

			// 전체 페이지 수
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<HomeBob> list = service.listHomeBob(map);

			String cp = req.getContextPath();
			String query = "";
			String listUrl = cp + "/homebob/list";
			String articleUrl = cp + "/homebob/article?page=" + current_page;
			
			if (! kwd.isBlank()) {
				query = "kwd=" + myUtil.encodeUrl(kwd);
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("totalPage", total_page);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("page", current_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}

		return "homebob/list";
	}	
	
	@GetMapping("write")
	public String writeForm(Model model) throws Exception {

		model.addAttribute("mode", "write");

		return "homebob/write";
	}	
	
	@PostMapping("write")
	public String wrtieSubmit(HomeBob dto, HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			service.insertHomeBob(dto, uploadPath);
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}

		return "redirect:/homebob/list";
	}
	
	@GetMapping("article")
	public String article(@RequestParam(name = "num") long num,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&kwd=" + myUtil.encodeUrl(kwd);
			}

			HomeBob dto = Objects.requireNonNull(service.findById(num));

			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

			// 이전 글, 다음 글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", num);

			HomeBob prevDto = service.findByPrev(map);
			HomeBob nextDto = service.findByNext(map);

			// 이미지 파일
			List<HomeBob> listFile = service.listHomeBobFile(num);

			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("listFile", listFile);

			model.addAttribute("page", page);
			model.addAttribute("query", query);

			return "homebob/article";
		
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		
		return "redirect:/homebob/list?" + query;
	}
	
	
	@GetMapping("update")
	public String updateForm(@RequestParam(name = "num") long num,
			@RequestParam(name = "page") String page,
			Model model,
			HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			HomeBob dto = Objects.requireNonNull(service.findById(num));
			
			if (dto.getMemberId() != info.getMemberId()) {
				return "redirect:/";
			}

			List<HomeBob> listFile = service.listHomeBobFile(num);

			model.addAttribute("dto", dto);
			model.addAttribute("listFile", listFile);

			model.addAttribute("page", page);
			model.addAttribute("mode", "update");

			return "homebob/write";
			
		} catch (NullPointerException e) {
			log.info("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		
		return "redirect:/homebob/list?page=" + page;
	}	
	
	@PostMapping("update")
	public String updateSubmit(HomeBob dto,
			@RequestParam(name = "page") String page) throws Exception {

		try {
			service.updateHomeBob(dto, uploadPath);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

		return "redirect:/homebob/article?num=" + dto.getNum() + "&page=" + page;
	}
	
	@GetMapping("delete")
	public String delete(@RequestParam(name = "num") long num,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&kwd=" + myUtil.encodeUrl(kwd);
			}

			SessionInfo info = (SessionInfo) session.getAttribute("member");
			HomeBob dto = Objects.requireNonNull(service.findById(num));

			if (dto.getMemberId() != info.getMemberId()) {
				return "redirect:/";
			}
			
			service.deleteHomeBob(num, uploadPath);
			
		} catch (NullPointerException e) {
			log.info("delete : ", e);
		} catch (Exception e) {
			log.info("delete : ", e);
		}

		return "redirect:/homebob/list?" + query;
	}

	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "fileNum") long fileNum, 
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "false";
		try {

			HomeBob dto =  Objects.requireNonNull(service.findByFileId(fileNum));
			
			service.deleteUploadFile(uploadPath, dto.getImageFilename());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "fileNum");
			map.put("num", fileNum);
			
			service.deleteHomeBobFile(map);
			
			state = "true";
			
		} catch (NullPointerException e) {
			log.info("deleteFile : ", e);
		} catch (Exception e) {
			log.info("deleteFile : ", e);
		}

		// 작업 결과를 json으로 전송
		model.put("state", state);
		return model;
	}
}
