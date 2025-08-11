package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.model.Product;
import com.sp.app.model.ProductQna;
import com.sp.app.model.ProductReview;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ProductService;
import com.sp.app.service.WishService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController 
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/products")
public class ProductApiController {

	private final ProductService service;
	private final WishService wishService;

	// 상품 리스트 데이터
    @GetMapping
    public Map<String, Object> getProductList(@RequestParam(name = "kwd", required = false, defaultValue = "")String kwd) {
        Map<String, Object> model = new HashMap<>();
        
        try {
            List<Product> list = service.getProductList(new HashMap<>());
            model.put("state", "true");
            model.put("list", list); 
        } catch (Exception e) {
            log.error("getProductList: ", e);
            model.put("state", "false");
        }
        
        return model;
    }

    // 상품 상세 데이터
    @GetMapping("/{productNum}")
    public Map<String, Object> getProductInfo(@PathVariable long productNum) {
        Map<String, Object> model = new HashMap<>();

        try {
            Product productInfo = Objects.requireNonNull(service.getProductInfo(productNum));
            
            model.put("state", "true");
            model.put("productInfo", productInfo); 
            
        } catch (NullPointerException e) {
        	model.put("state", "false");        	
        } catch (Exception e) {
            log.error("getProductInfo: ", e);
            model.put("state", "false");
        }
        
        return model;
    }

    // 상품 문의 데이터
    @GetMapping("/{productNum}/qnas")
    public Map<String, Object> getProductQna(@PathVariable long productNum) {
        Map<String, Object> model = new HashMap<>();
        
        try {
            List<ProductQna> list = null;
            
            model.put("state", "true");
            model.put("list", list);
        } catch (Exception e) {
            log.error("getProductQna: ", e);
            model.put("state", "false");
        }
        
        return model;
    }
    
    // 상품 리뷰 데이터
    @GetMapping("/{productNum}/reviews")
    public Map<String, Object> getProductReview(@PathVariable long productNum) {
        Map<String, Object> model = new HashMap<>();

        try {
            List<ProductReview> list = null;
            
            model.put("state", "true");
            model.put("list", list);
        } catch (Exception e) {
        	log.error("getProductReview: ", e);
            model.put("state", "false");
        }
        
        return model;
    }

    // 상품 환불/반품 데이터
    @GetMapping("/{productNum}/refundInfo")
    public Map<String, Object> getProductRefundInfo(@PathVariable long productNum) {
        Map<String, Object> model = new HashMap<>();

        try {
            
            model.put("state", "true");
        } catch (Exception e) {
        	log.error("getProductRefundInfo: ", e);
            model.put("state", "false");
        }
        
        return model;
    }

	// 찜 등록
	@PostMapping("{productNum}/wish")
	public Map<String, ?> insertWish(
			@PathVariable(name = "productNum") Long productNum,
			HttpSession session
	) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);

			wishService.insertWish(map);

			model.put("state", "true");
		} catch (Exception e) {
			log.error("insertWish: ", e);
			model.put("state", "false");
		}
		
		return model;
	}

	// 찜하기 취소
	@DeleteMapping("{productNum}/wish")
	public Map<String, ?> deleteWish(
			@PathVariable(name = "productNum") Long productNum, 
			HttpSession session
		) throws Exception {

		Map<String, Object> model = new HashMap<String, Object>();
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			map.put("memberId", info.getMemberId());
			map.put("productNum", productNum);

			wishService.deleteWish(map);

			model.put("state", "true");
		} catch (Exception e) {
			log.error("deleteWish: ", e);
			model.put("state", "false");
		}

		return model;
	}
}
