package com.sp.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.Destination;
import com.sp.app.model.Member;
import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;
import com.sp.app.service.MyShoppingService;
import com.sp.app.service.OrderService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/order/*")
public class OrderController {
	private final OrderService orderService;
	private final MemberService memberService;
	private final MyShoppingService myShoppingService;

	@RequestMapping(name = "payment", method = {RequestMethod.GET, RequestMethod.POST})
	public String paymentForm(
			@RequestParam(name = "productNums") List<Long> productNums, 
			@RequestParam(name = "buyQtys") List<Integer> buyQtys, 
			@RequestParam(name = "mode", defaultValue = "buy") String mode, 
			Model model, 
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			Member orderUser = memberService.findById(info.getMemberId());
			
			String productOrderNumber = null; // 주문번호
			String productOrderName = ""; // 주문상품명
			int totalMoney = 0; // 상품합
			int deliveryCharge = 0; // 배송비
			int totalPayment = 0; // 결제할 금액(상품합 + 배송비)
			int totalDiscountPrice = 0; // 총 할인액
			
			productOrderNumber = orderService.productOrderNumber();
			
			List<Map<String, Long>> list = new ArrayList<Map<String, Long>>();
			for (int i = 0; i < productNums.size(); i++) {
			    Map<String, Long> map = new HashMap<>();
			    map.put("productNum", productNums.get(i));
			    list.add(map);
			}
			
			System.out.println("------------------------------------");
			System.out.println(list);
			System.out.println("------------------------------------");

			// DB에서 상품 정보 가져오기
	        List<Order> listProduct = orderService.listOrderProduct(list);

	        // Map 으로 매핑 (productNum -> Order)
	        Map<Long, Order> orderMap = listProduct.stream()
	                .collect(Collectors.toMap(Order::getProductNum, o -> o));

	        // 원래 요청 순서(productNums, buyQtys)에 맞춰 재정렬
	        List<Order> orderedList = new ArrayList<>();
	        for (int i = 0; i < productNums.size(); i++) {
	            Long productNum = productNums.get(i);
	            Integer qty = buyQtys.get(i);

	            Order dto = orderMap.get(productNum);
	            if (dto != null && qty > 0) {
	                dto.setQty(qty);
	                dto.setProductMoney(qty * dto.getSalePrice());

	                totalMoney += qty * dto.getUnitPrice();
	                totalDiscountPrice += qty * dto.getDiscountPrice();
	                if (orderedList.isEmpty() || deliveryCharge < dto.getDeliveryFee()) {
	                    deliveryCharge = dto.getDeliveryFee();
	                }

	                orderedList.add(dto);
	            }
	        }
			
			totalPayment = totalMoney - totalDiscountPrice;
			
			productOrderName = listProduct.get(0).getProductName();
			if(listProduct.size() > 1) {
				productOrderName += " 외 " + (listProduct.size() - 1) + "건";
			}
			
			// 배송비
			deliveryCharge = totalPayment >= 200000 ? 0 : deliveryCharge;
			
			// 결제할 금액(상품 총금액 + 배송비)
			totalPayment = totalPayment + deliveryCharge;
			
			// 배송지
			List<Destination> listDestination = myShoppingService.listDestination(info.getMemberId());
			Destination destination = myShoppingService.defaultDelivery(info.getMemberId());
			
			model.addAttribute("productOrderNumber", productOrderNumber); // 주문 번호
			model.addAttribute("orderUser", orderUser); // 주문 유저
			model.addAttribute("productOrderName", productOrderName); // 주문 상품명
			
			model.addAttribute("listProduct", orderedList);
			model.addAttribute("totalMoney", totalMoney); // 총금액 (수량*할인가격 의 합)
			model.addAttribute("totalPayment", totalPayment); // 결제할 금액
			model.addAttribute("totalDiscountPrice", totalDiscountPrice); // 할인 총액
			model.addAttribute("deliveryCharge", deliveryCharge); // 배송비

			model.addAttribute("listDestination", listDestination);
			model.addAttribute("destination", destination);
			
			model.addAttribute("mode", mode); // 바로 구매인지 장바구니 구매인지를 가지고 있음
			
			return "order/payment";
		} catch (Exception e) {
			log.info("paymentForm : ", e);
		}
		
		return "redirect:/";
	}
	
	@PostMapping("paymentOk")
	public String paymentSubmit(Order dto, 
			@RequestParam(name = "mode", defaultValue = "buy") String mode,
			final RedirectAttributes reAttr,
			HttpSession session) throws Exception {
		
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			dto.setMemberId(info.getMemberId());
			
			orderService.insertOrder(dto);
			
			if(mode.equals("cart")) {
				// 구매 상품에 대한 장바구니 비우기
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("gubun", "list");
				map.put("memberId", info.getMemberId());
				map.put("list", dto.getProductNums());
				
				myShoppingService.deleteCart(map);
			}
			
			String p = String.format("%,d", dto.getPayment());
			
			StringBuilder sb = new StringBuilder();
			sb.append(info.getName() + "님 상품을 구매해 주셔서 감사 합니다.<br>");
			sb.append("구매 하신 상품의 결제가 정상적으로 처리되었습니다.<br>");
			sb.append("결제 금액 : <label class='fs-5 fw-bold text-primary'>" +  p + "</label>원");

			reAttr.addFlashAttribute("title", "상품 결제 완료");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/order/complete";
			
		} catch (Exception e) {
			log.info("paymentSubmit : ", e);
		}
		
		return "redirect:/";
	}	
	
	@GetMapping("complete")
	public String complete(@ModelAttribute("title") String title, 
			@ModelAttribute("message") String message) throws Exception {
		// F5를 누른 경우
		if (message == null || message.isBlank()) { 
			return "redirect:/";
		}
		
		return "order/complete";
	}
	
}
