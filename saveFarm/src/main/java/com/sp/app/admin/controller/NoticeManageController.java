package com.sp.app.admin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.CategoryInfo;
import com.sp.app.admin.model.NoticeManage;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/notice/*")
public class NoticeManageController {

	private final NoticeManageService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/notice");
	}	
	
	@GetMapping("noticeList/{itemId}")
	public String handleNoticeList(
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 5;
			int totalPage = 0;
			int dataCount = 0;
			
			int classify = itemId == 200 ? 1 : 0;
			
			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemId", itemId);
			map.put("classify", classify);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.noticeCount(map);
			if (dataCount != 0) {
				totalPage = paginateUtil.pageCount(dataCount, size);
			}
			currentPage = Math.min(currentPage, totalPage);
			
			
//			List<NoticeManage> noticeList = null;
//			if (currentPage == 1) {
//				noticeList = service.listNoticeTop(classify);
//			}
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<NoticeManage> list = service.listNotice(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/notice/noticeList/" + itemId;
			
			String query = "";
			if (kwd.length() != 0) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				listUrl += "?" + query;
			}
			
			
			String paging = paginateUtil.adminPagingUrl(currentPage, totalPage, listUrl);
			String title = (itemId == 200) ? "농가 공지사항" : "회원 공지사항";

			model.addAttribute("title", title);
			model.addAttribute("itemId", itemId);
			model.addAttribute("classify", classify);
			
//			model.addAttribute("noticeList", noticeList);
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("query", query);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", currentPage);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("handleNoticeList : ", e);
		}
		
		return "admin/notice/noticeList";
	}
	
	@GetMapping("write/{itemId}")
	public String writeForm(@PathVariable("itemId") int itemId,
			Model model, HttpSession session) throws Exception {
		model.addAttribute("mode", "write");
		model.addAttribute("itemId", itemId);

		return "admin/notice/write";
	}
	
	@PostMapping("write/{itemId}")
	public String writeSubmit(@PathVariable("itemId") int itemId,
			NoticeManage dto, HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			dto.setCategoryCount(service.categoryCount());
			service.insertNotice(dto, uploadPath);
			
			
		} catch (Exception e) {
			log.info("writeSubmit : ", e);
		}
		
		if(itemId != 300) {
			return "redirect:/admin/notice/noticeList/" + itemId;
		} else {
			return "redirect:/admin/notice/guideLineslist";
		}
	}
	
	@GetMapping("update/{itemId}")
	public String updateForm(@PathVariable("itemId") int itemId,
			@RequestParam(name = "noticeNum") long noticeNum,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd, 
			@RequestParam(name = "page") String page,
			Model model,
			HttpSession session) throws Exception {
		
		try {
			NoticeManage dto = Objects.requireNonNull(service.findById(noticeNum));

			List<NoticeManage> listFile = service.listNoticeFile(noticeNum);

			model.addAttribute("mode", "update");
			model.addAttribute("itemId", itemId);
			model.addAttribute("page", page);
			model.addAttribute("dto", dto);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("listFile", listFile);

			return "admin/notice/write";
			
		} catch (NullPointerException e) {
			log.info("updateForm : ", e);
		} catch (Exception e) {
			log.info("updateForm : ", e);
		}
		if(itemId != 300) {
			return "redirect:/admin/notice/noticeList?page=" + page;
		} else {
			return "redirect:/admin/notice/guideLineslist?page=" + page;
		}
	}

	@PostMapping("update/{itemId}")
	public String updateSubmit(@PathVariable("itemId") int itemId,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd, 
			NoticeManage dto,
			@RequestParam(name = "page") String page,
			HttpSession session) throws Exception {

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setMemberId(info.getMemberId());
			
			service.updateNotice(dto, uploadPath);
			
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}
		
		String query = "page=" + page;
        if (! kwd.isBlank()) {
            query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
        }
		
        if(itemId != 300) {
			return "redirect:/admin/notice/noticeList/"+ itemId + "?" + query;
		} else {
			return "redirect:/admin/notice/guideLineslist?" + query;
		}
	
	}
	
	@GetMapping("delete/{itemId}")
	public String delete(@PathVariable("itemId") int itemId,
			@RequestParam(name = "noticeNum") long noticeNum,
			@RequestParam(name = "page") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpSession session) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}

			service.deleteNotice(noticeNum, uploadPath);
			
		} catch (Exception e) {
			log.info("delete : ", e);
		}
		if(itemId != 300) {
			return "redirect:/admin/notice/noticeList/ "+ itemId +"?" + query;
		} else {
			return "redirect:/admin/notice/guideLineslist?" + query;
		}
	}
	
	@GetMapping("article/{itemId}")
	public String article(@PathVariable("itemId") int itemId,
			@RequestParam(name = "noticeNum") long noticeNum,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {

		String query = "page=" + page;
		try {
			kwd = myUtil.decodeUrl(kwd);

			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
			}
			service.updateHitCount(noticeNum);

			NoticeManage dto = Objects.requireNonNull(service.findById(noticeNum));

			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

			// 이전 글, 다음 글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("updateDate", dto.getUpdateDate());

			NoticeManage prevDto = service.findByPrev(map);
			NoticeManage nextDto = service.findByNext(map);
			
			
			// 파일
			List<NoticeManage> listFile = service.listNoticeFile(noticeNum);

			model.addAttribute("dto", dto);
			model.addAttribute("prevDto", prevDto);
			model.addAttribute("nextDto", nextDto);
			model.addAttribute("listFile", listFile);
			model.addAttribute("page", page);
			model.addAttribute("noticeNum", noticeNum);
			model.addAttribute("query", query);
			model.addAttribute("itemId", itemId);

			return "admin/notice/article";
			
		} catch (NullPointerException e) {
			log.info("article : ", e);
		} catch (Exception e) {
			log.info("article : ", e);
		}
		if(itemId != 300) {
			return "redirect:/admin/notice/noticeList/"+ itemId + "?" + query;
		} else {
			return "redirect:/admin/notice/guideLineslist?" + query;
		}
	}
	
	
	@GetMapping("download/{fileNum}")
	public ResponseEntity<?> download(
			@PathVariable(name = "fileNum") long fileNum) throws Exception {
		
		try {
			NoticeManage dto = Objects.requireNonNull(service.findByFileId(fileNum));

			return storageService.downloadFile(uploadPath, dto.getSaveFilename(), dto.getOriginalFilename());
			
		} catch (NullPointerException | StorageException e) {
			log.info("download : ", e);
		} catch (Exception e) {
			log.info("download : ", e);
		}
		
		String errorMessage = "<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>";

		return ResponseEntity.status(HttpStatus.NOT_FOUND) // 404 상태 코드 반환
				.contentType(MediaType.valueOf("text/html;charset=UTF-8"))
				.body(errorMessage); // 에러 메시지 반환
	}
	
	
	@GetMapping("zipdownload/{noticeNum}")
	public ResponseEntity<?> zipdownload(@PathVariable(name = "noticeNum") long noticeNum) throws Exception {
		try {
			List<NoticeManage> listFile = service.listNoticeFile(noticeNum);
			if (listFile.size() > 0) {
				String[] sources = new String[listFile.size()];
				String[] originals = new String[listFile.size()];
				String fileName = listFile.get(0).getOriginalFilename();
				String zipFilename = fileName.substring(0, fileName.lastIndexOf(".")) + "_외.zip";

				for (int idx = 0; idx < listFile.size(); idx++) {
					sources[idx] = uploadPath + File.separator + listFile.get(idx).getSaveFilename();
					originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
				}

				return storageService.downloadZipFile(sources, originals, zipFilename);
			}
			
		} catch (Exception e) {
			log.info("zipdownload : ", e);
		}
		
		String errorMessage = "<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>";
		 
		return ResponseEntity.status(HttpStatus.NOT_FOUND) // 404 상태 코드 반환
				.contentType(MediaType.valueOf("text/html;charset=UTF-8")) // HTML 콘텐츠 타입 설정
				.body(errorMessage); // 에러 메시지 반환
	}
	
	@ResponseBody
	@PostMapping("deleteFile")
	public Map<String, ?> deleteFile(@RequestParam(name = "fileNum") long fileNum, 
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "false";
		try {
			NoticeManage dto = Objects.requireNonNull(service.findByFileId(fileNum));
			
			service.deleteUploadFile(uploadPath, dto.getSaveFilename());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "fileNum");
			map.put("fileNum", fileNum);
			
			service.deleteNoticeFile(map);
			
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
	
	@GetMapping("guideLineslist/{itemId}")
	public String handleguideLineslist(
			@PathVariable("itemId") int itemId
			,Model model) throws Exception {
		model.addAttribute("itemId", itemId);
		
		return "admin/notice/guideLineslist";
	}
	
	@GetMapping("guide/{itemId}")
	public String handleGuideList(
			@PathVariable("itemId") int itemId,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "schType", defaultValue = "inquiryNum") String schType,
			@RequestParam(name = "kwd",defaultValue = "") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int size = 5;
			int totalPage = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("classify", itemId);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.noticeCount2(map);

			if (dataCount != 0) {
				totalPage = paginateUtil.pageCount(dataCount, size);
			}
			currentPage = Math.min(currentPage, totalPage);
			
			
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);

			List<NoticeManage> list = service.listNotice2(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/notice/guide/" + itemId;
			
			String query = "";
			if (kwd.length() != 0) {
				query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
				listUrl += "?" + query;
			}
			
			
			String paging = paginateUtil.adminPagingUrl(currentPage, totalPage, listUrl);
			
			List<CategoryInfo> guide = service.listAllCategories();
			
			model.addAttribute("itemId", itemId);
			model.addAttribute("classify", itemId);
			model.addAttribute("guide", guide);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("query", query);
			
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("page", currentPage);
			model.addAttribute("size", size);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("handleNoticeList : ", e);
		}
		
		return "admin/notice/guide";
	}
}
