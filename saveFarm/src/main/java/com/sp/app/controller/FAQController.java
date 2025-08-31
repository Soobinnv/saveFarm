package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.FaqManage;
import com.sp.app.admin.service.FaqManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/FAQ/*")
public class FAQController {
    private final FaqManageService service;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;

    @GetMapping("/")
    public String handleMain() throws Exception {

        return "FAQ/main";
    }

    

    @GetMapping("FAQ")
    public String handleList(
    	    @RequestParam(name = "page", defaultValue = "1") int currentPage,
    	    @RequestParam(name = "schTypeFAQ", defaultValue = "memberFAQ") String schTypeFAQ,
    	    @RequestParam(name = "categoryNum", required = false) String categoryNum,
    	    @RequestParam(name = "schType", defaultValue = "all") String schType,
    	    @RequestParam(name = "kwd", defaultValue = "") String kwd,
    	    Model model,
    	    HttpServletRequest req) throws Exception {

        try {
            int size = 10;
            int totalPage = 0;
            int dataCount = 0;
            
            kwd = myUtil.decodeUrl(kwd);
            
            Map<String, Object> categoryMap = new HashMap<>();
            categoryMap.put("schTypeFAQ", schTypeFAQ);
            
            List<FaqManage> listFAQ = service.categoryFAQList(categoryMap);
            
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("schTypeFAQ", schTypeFAQ);
            
            if (categoryNum != null && !categoryNum.isEmpty()) {
                map.put("categoryNum", categoryNum);
            }
            
            FaqManage dto = service.dataCount(map);
           
           	dataCount = dto.getMemberCount();
          
            if (dataCount != 0) {
                totalPage = paginateUtil.pageCount(dataCount, size);
            }
            currentPage = Math.min(currentPage, totalPage);

            int offset = (currentPage - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<FaqManage> list = service.faqList(map);
            String cp = req.getContextPath();
            String listUrl = cp + "FAQ/FAQ";

            StringBuilder queryBuilder = new StringBuilder();
            if (kwd.length() != 0) {
                queryBuilder.append("schType=").append(schType).append("&kwd=").append(myUtil.encodeUrl(kwd));
            }
            
            if (categoryNum != null && !categoryNum.isEmpty()) {
                 if (queryBuilder.length() > 0) {
                    queryBuilder.append("&");
                }
                queryBuilder.append("categoryNum=").append(categoryNum);
            }

            // schTypeFAQ도 쿼리 파라미터에 추가
            if (schTypeFAQ != null && !schTypeFAQ.isEmpty()) {
                 if (queryBuilder.length() > 0) {
                    queryBuilder.append("&");
                }
                queryBuilder.append("schTypeFAQ=").append(schTypeFAQ);
            }

            String query = queryBuilder.toString();
            if (query.length() > 0) {
                 listUrl += "?" + query;
            }

            String paging = paginateUtil.adminPaging(currentPage, totalPage, "listFaq");
            
            
            model.addAttribute("listFAQ", listFAQ);
            model.addAttribute("list", list);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("query", query);
            model.addAttribute("schTypeFAQ", schTypeFAQ);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("page", currentPage);
            model.addAttribute("size", size);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("paging", paging);
            model.addAttribute("categoryNum", categoryNum);

        } catch (Exception e) {
            log.info("handleFAQ : ", e);
        }
        return "FAQ/FAQ";
    }
	
    @GetMapping("categoryList")
    @ResponseBody
    public List<FaqManage> getCategoryList(
            @RequestParam(name = "schTypeFAQ", defaultValue = "memberFAQ") String schTypeFAQ) throws Exception {

        Map<String, Object> categoryMap = new HashMap<>();
        categoryMap.put("schTypeFAQ", schTypeFAQ);
        
        // schTypeFAQ 값에 따라 필터링된 카테고리 목록을 반환
        List<FaqManage> listFAQ = service.categoryFAQList(categoryMap);
        
        return listFAQ;
    }

	
	
}