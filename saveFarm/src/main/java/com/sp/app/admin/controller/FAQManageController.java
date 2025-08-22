package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
@RequestMapping("/admin/FAQ/*")
public class FAQManageController {
    private final FaqManageService service;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;

    @GetMapping("/")
    public String handleMain() throws Exception {

        return "admin/FAQ/main";
    }

    @GetMapping("FAQ")
    public String handleFAQ(
        @RequestParam(name = "page", defaultValue = "1") int currentPage,
        @RequestParam(name = "schTypeFAQ", defaultValue = "memberFAQ") String schTypeFAQ,
        @RequestParam(name = "classify", defaultValue = "1") int classify,
        @RequestParam(name = "schType", defaultValue = "all") String schType,
        @RequestParam(name = "kwd", defaultValue = "") String kwd,
        Model model,
        HttpServletRequest req) throws Exception {

        try {
            int size = 10;
            int totalPage = 0;
            
            kwd = myUtil.decodeUrl(kwd);
            List<FaqManage> listFAQ = service.categoryFAQList();
            
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            FaqManage dto = service.dataCount(map);
            int dataCount = dto.getDataCount();
            
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
            String listUrl = cp + "/admin/FAQ/FAQ";

            String query = "";
            if (kwd.length() != 0) {
                query = "schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
                listUrl += "?" + query;
            }

            String paging = paginateUtil.adminPagingUrl(currentPage, totalPage, listUrl);
            
            
            if(schTypeFAQ == "memberFAQ") {
            	classify = 1;
            } else if(schTypeFAQ == "farmFAQ"){
            	classify = 2;
            }
            
            model.addAttribute("listFAQ", listFAQ);
            model.addAttribute("classify", classify);
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

        } catch (Exception e) {
            log.info("handleFAQ : ", e);
        }
        return "admin/FAQ/FAQ";
    }
}