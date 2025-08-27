package com.sp.app.farm.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.NoticeManage;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.farm.service.NoticeService;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/farm/notice/*")
public class FarmNoticeController {

	private final NoticeService service;
	private final PaginateUtil paginateUtil;
	private final StorageService storageService;
	private final MyUtil myUtil;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
	    uploadPath = storageService.getRealPath("/uploads/notice");
	}
	
	@GetMapping("list")
	public String list(
	        @RequestParam(value="categoryNum", required=false) Integer categoryNum,
	        @RequestParam(name="page", defaultValue="1") int currentPage,
	        @RequestParam(name="size", defaultValue="10") int size,
	        @RequestParam(name="schType", defaultValue="all") String schType,
	        @RequestParam(name="kwd", defaultValue="") String kwd,
			Model model,
			HttpServletRequest req) throws Exception {
		
		try {
			int totalPage = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			if (kwd != null) kwd = kwd.trim();

			 List<NoticeManage> categoryList = service.listFarmCategories(); // classify >= 1

		    if (categoryNum == null && !categoryList.isEmpty()) {
		        categoryNum = categoryList.get(0).getCategoryNum();
		    }
			
		    Map<String,Object> map = new HashMap<>();
		    map.put("schType", schType);
		    map.put("kwd", kwd);
		    map.put("categoryNum", categoryNum);

		    dataCount = service.noticeCount(map);
		    if (dataCount != 0) {
				totalPage = paginateUtil.pageCount(dataCount, size);
			} 
		    
		    if (totalPage < 1) totalPage = 1;
		    
		    if (currentPage > totalPage) currentPage = totalPage;
		    if (currentPage < 1) currentPage = 1;

		    map.put("offset", (currentPage - 1) * size);
			map.put("size", size);
		    List<NoticeManage> list = service.listNotice(map);

		    // 페이징용 base URL (categoryNum, schType, kwd 보존)
		    String cp = req.getContextPath();
		    StringBuilder sb = new StringBuilder();
		    
		    if (categoryNum != null) sb.append("categoryNum=").append(categoryNum);
		    
		    if (schType != null && !schType.isEmpty()) {
		        if (sb.length() > 0) sb.append('&');
		        sb.append("schType=").append(schType);
		    }
		    
		    if (kwd != null && !kwd.isEmpty()) {
		        if (sb.length() > 0) sb.append('&');
		        sb.append("kwd=").append(myUtil.encodeUrl(kwd));
		    }
		    
		    String listUrl = cp + "/farm/notice/list" + (sb.length() > 0 ? "?" + sb : "");
		    String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

		    model.addAttribute("categoryList", categoryList);
		    model.addAttribute("categoryNum", categoryNum);

		    model.addAttribute("list", list);
		    model.addAttribute("dataCount", dataCount);
		    model.addAttribute("paging", paging);

		    model.addAttribute("page", currentPage);
		    model.addAttribute("size", size);
		    model.addAttribute("totalPage", totalPage);

		    model.addAttribute("schType", schType);
		    model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list : ", e);
		}
		
		return "farm/notice/list";
	}
	
	@GetMapping("article/{noticeNum}")
	public String article(
			@PathVariable("noticeNum") long noticeNum,                 
	        @RequestParam(name="page", defaultValue="1") int currentPage,
	        @RequestParam(name="categoryNum", required=false) Integer categoryNum,
	        @RequestParam(name="schType", defaultValue="all") String schType,
	        @RequestParam(name="kwd", defaultValue="") String kwd,
	        Model model) {

	    try {
	        kwd = myUtil.decodeUrl(kwd);
	        if (kwd != null) kwd = kwd.trim();

	        service.updateHitCount(noticeNum);

	        // findByNoticeNum은 Map으로 호출(카테고리 필터 optional)
	        Map<String,Object> map = new HashMap<>();
	        map.put("noticeNum", noticeNum);
	        map.put("categoryNum", categoryNum);

	        NoticeManage dto = Objects.requireNonNull(service.findByNoticeNum(map));

	        Map<String,Object> cond = new HashMap<>();
	        cond.put("schType", schType);
	        cond.put("kwd", kwd);
	        cond.put("categoryNum", categoryNum);
	        cond.put("updateDate", dto.getUpdateDate());
	        cond.put("noticeNum", noticeNum);

	        NoticeManage prevDto = service.findByPrev(cond);
	        NoticeManage nextDto = service.findByNext(cond);

	        List<NoticeManage> listFile = service.listNoticeFile(noticeNum);

	        StringBuilder query = new StringBuilder();
	        query.append("page=").append(currentPage);
	        if (categoryNum != null) query.append("&categoryNum=").append(categoryNum);
	        if (schType != null && !schType.isEmpty()) query.append("&schType=").append(schType);
	        if (kwd != null && !kwd.isEmpty()) query.append("&kwd=").append(myUtil.encodeUrl(kwd));

	        model.addAttribute("dto", dto);
	        model.addAttribute("prevDto", prevDto);
	        model.addAttribute("nextDto", nextDto);
	        model.addAttribute("listFile", listFile);
	        model.addAttribute("page", currentPage);
	        model.addAttribute("noticeNum", noticeNum);
	        model.addAttribute("query", query.toString());
	        return "farm/notice/article";
	    } catch (Exception e) {
	        log.info("article : ", e);
	    }
	    return "redirect:/farm/notice/list";
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
	
	/*
	@GetMapping("zipdownload/{noticeNum}")
	public ResponseEntity<?> zipdownload(@PathVariable("noticeNum") long noticeNum) {
	    try {
	        // 0) 현재 업로드 루트 확인
	        log.warn("[zip] uploadPath = {}", uploadPath);

	        // 1) 첨부 목록 조회
	        List<NoticeManage> listFile = service.listNoticeFile(noticeNum);
	        if (listFile == null || listFile.isEmpty()) {
	            return errorScript("첨부파일이 없습니다.");
	        }

	        // 2) zip 파일명(확장자 없는 경우 대비)
	        String base = listFile.get(0).getOriginalFilename();
	        String stem = (base != null && base.lastIndexOf('.') > 0)
	                ? base.substring(0, base.lastIndexOf('.'))
	                : (base != null ? base : "attachments");
	        String zipFilename = stem + "_외.zip";

	        // 3) 소스 경로/ZIP 내 표시명 구성 + 존재 여부 검사
	        List<String> srcList = new java.util.ArrayList<>();
	        List<String> nameList = new java.util.ArrayList<>();
	        List<String> missing  = new java.util.ArrayList<>();

	        for (NoticeManage f : listFile) {
	            java.nio.file.Path p = java.nio.file.Paths.get(uploadPath, f.getSaveFilename());
	            boolean exists = java.nio.file.Files.exists(p) && java.nio.file.Files.isReadable(p);
	            log.warn("[zip] check: {} exists={}", p, exists);

	            if (exists) {
	                srcList.add(p.toString());
	                nameList.add(safeUniqueName(nameList, f.getOriginalFilename())); // 중복 파일명 방지
	            } else {
	                missing.add(f.getSaveFilename());
	            }
	        }

	        // 4-a) 하나도 없으면 바로 안내
	        if (srcList.isEmpty()) {
	            return errorScript("첨부 원본 파일을 찾을 수 없습니다. (저장 경로 확인 필요)");
	        }

	        // 4-b) 일부만 없으면 경고하고, 존재하는 파일만 zip (원하면 여기서도 막아도 됨)
	        if (!missing.isEmpty()) {
	            log.warn("[zip] missing files: {}", missing);
	            // 존재하는 것만 묶어서 내려가게 할지, 막을지는 정책에 따라 결정
	            // 여기선 존재하는 것만 묶어서 내려감
	        }

	        String[] sources   = srcList.toArray(new String[0]);          // 절대경로
	        String[] originals = nameList.toArray(new String[0]);          // ZIP 안 파일명(슬래시/역슬래시 금지)

	        // 5) ZIP 다운로드 수행
	        return storageService.downloadZipFile(sources, originals, zipFilename);

	    } catch (Exception e) {
	        log.error("zipdownload error", e);
	        return errorScript("파일 다운로드가 불가능 합니다 !!!");
	    }
	}


	private String safeUniqueName(List<String> used, String name) {
	    if (name == null || name.isBlank()) name = "file";
	    String base = name;
	    String ext = "";
	    int dot = name.lastIndexOf('.');
	    if (dot > 0) {
	        base = name.substring(0, dot);
	        ext  = name.substring(dot); // .png, .zip 등
	    }
	    String candidate = base + ext;
	    int n = 1;
	    while (used.contains(candidate)) {
	        candidate = base + " (" + n++ + ")" + ext;
	    }
	    return candidate;
	}

	private ResponseEntity<String> errorScript(String msg) {
	    String html = "<script>alert('" + msg + "');history.back();</script>";
	    return ResponseEntity.status(HttpStatus.NOT_FOUND)
	            .contentType(MediaType.valueOf("text/html;charset=UTF-8"))
	            .body(html);
	}
	*/

	
	
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
	
}
