<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!-- 배송지 등록 대화상자 -->
<div class="modal fade" id="deliveryDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="deliveryDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deliveryDialogModalLabel">상품 배송지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="tab-1" data-bs-toggle="tab" data-bs-target="#nav-content1" type="button" role="tab" data-tab="1" aria-selected="true">배송지 선택</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="tab-2" data-bs-toggle="tab" data-bs-target="#nav-content2" type="button" role="tab" data-tab="2">배송지 직접입력</button>
					</li>
				</ul>
				
				<div class="tab-content pt-2" id="nav-tabContent">
					<!-- 배송지 목록 탭 -->
					<div class="tab-pane fade show active px-2 py-3" id="nav-content1" role="tabpanel">
						<c:forEach var="vo" items="${listDestination}">
							<div class="row">
								<div class="col-md-6">
									<label class="bold">${vo.recipientName}</label>
									<c:if test="${not empty vo.addressName}"><label>(${vo.addressName})</label> </c:if>
									<c:if test="${vo.defaultDest==1}"><label class="badge text-bg-primary">기본배송지</label></c:if>
								</div>
								<div class="col-md-6 text-end saved-deliveryAddres">
									<input type="hidden" class="saved-addressName" value="${vo.addressName}">
									<input type="hidden" class="saved-defaultDest" value="${vo.defaultDest}">
									<input type="hidden" class="saved-recipientName" value="${vo.recipientName}">
									<input type="hidden" class="saved-zip" value="${vo.zip}">
									<input type="hidden" class="saved-addr1" value="${vo.addr1}">
									<input type="hidden" class="saved-addr2" value="${vo.addr2}">
									<input type="hidden" class="saved-tel" value="${vo.tel}">
									<input type="hidden" class="saved-pickup" value="${vo.pickup}">
									<input type="hidden" class="saved-accessInfo" value="${vo.accessInfo}">
									<input type="hidden" class="saved-passcode" value="${vo.passcode}">
									
									<button type="button" class="btn-default btnSelectDeliveryAddress">선택</button>
								</div>
								
								<div class="col-md-12">
									(${vo.zip}) ${vo.addr1} ${vo.addr2}
								</div>
								<div class="col-md-12">
									${vo.tel}
								</div>
							</div>
							<hr>
						</c:forEach>
						<c:choose>
							<c:when test="${listDestination.size() == 0}">
								<div class="form-control-plaintext text-center">등록된 배송지가 없습니다.</div>
							</c:when>
							<c:otherwise>
								<small class="form-control-plaintext help-block text-end">배송지는 나의쇼핑에서 변경할 수 있습니다.</small>								
							</c:otherwise>
						</c:choose>	
					</div>
					
					<!-- 배송지 입력 탭 -->
					<div class="tab-pane fade px-2 py-3" id="nav-content2" role="tabpanel">
						<small class="form-control-plaintext help-block pb-2"><label class="text-danger">*</label> 는 필수입력사항입니다.</small>
						<form name="deliveryAddressForm" method="post">
							<div class="row">
								<div class="col-md-12">
									<div><label class="col-form-label bold" for="addressName">배송지명</label></div>
									<div class="row ps-1">
										<div class="col-md-6 pe-1">
											<input type="text" name="addressName" id="addressName" list="addressNameList" class="form-control" value="">
											<datalist id="addressNameList">
												<option>우리집</option>
												<option>회사</option>
												<option>부모님댁</option>
											</datalist>											
										</div>
									</div>
								</div>
								
								<div class="col-md-12">
									<div><label class="col-form-label bold" for="recipientName">받는사람</label> <label class="text-danger">*</label></div>
									<div class="row ps-1">
										<div class="col-md-6 pe-1">
											<input type="text" name="recipientName" id="recipientName" class="form-control" value="${sessionScope.member.name}">										
										</div>
									</div>
								</div>

								<div class="col-md-12">
									<div><label class="col-form-label bold" for="zip">우편번호</label> <label class="text-danger">*</label></div>
									<div class="row ps-1">
										<div class="col-md-6 pe-1">
											<input type="text" name="zip" id="zip" class="form-control" readonly tabindex="-1">
										</div>
										<div class="col-auto px-1">
											<button type="button" class="btn-default" id="btn-zip" onclick="daumPostcode();">주소찾기</button>
										</div>
									</div>
								</div>

								<div class="col-md-12">
									<div><label class="col-form-label bold" for="addr1">주소</label> <label class="text-danger">*</label></div>
									<div class="pb-2 ps-1">
										<input class="form-control" type="text" name="addr1" id="addr1" readonly tabindex="-1" placeholder="기본주소">
									</div>
									<div class="ps-1">
										<input class="form-control" type="text" name="addr2" id="addr2" placeholder="상세주소">
									</div>
								</div>

								<div class="col-md-12">
									<div><label class="col-form-label bold" for="tel1">전화번호</label> <label class="text-danger">*</label></div>
									<div class="row ps-1">
										<div class="col-md-2 pb-1">
											<input type="text" name="tel1" id="tel1" class="form-control" maxlength="3">
										</div>
										<div class="col-md-1 px-1" style="width: 2%;">
											<p class="form-control-plaintext text-center">-</p>
										</div>
										<div class="col-md-3 px-1">
											<input type="text" name="tel2" id="tel2" class="form-control" maxlength="4">
										</div>
										<div class="col-md-1 px-1" style="width: 2%;">
											<p class="form-control-plaintext text-center">-</p>
										</div>
										<div class="col-md-3 ps-1">
											<input type="text" name="tel3" id="tel3" class="form-control" maxlength="4">
										</div>
									</div>
								</div>

								<div class="col-md-12">
									<div><label class="col-form-label bold" for="pickup">수령장소</label></div>
									<div class="row ps-1">
										<div class="col-md-6 pb-2">
											<select class="form-select" name="pickup" id="pickup">
												<option value="문앞">문앞</option>
												<option value="배송주소에서직접수령">배송주소에서직접수령</option>
												<option value="경비실">경비실</option>
												<option value="택배함">택배함</option>
											</select>
										</div>
									</div>
								</div>

								<div class="col-md-12">
									<div><label class="col-form-label bold" for="pickup">공동현관 출입방법</label> <label class="text-danger">*</label></div>
									<div class="pb-2 ps-1">
										<div class="pb-1">
											<input type="radio" name="accessInfo" id="access1" value="비밀번호" class="form-check-input">
											<label for="access1" class="form-check-label">비밀번호</label></div>
										<div class="ps-4">
											<input class="form-control" type="text" name="passcode" id="passcode" maxlength="20" placeholder="공동현관 비밀번호를 입력하세요">
										</div>
									</div>
									<div class="pb-2 ps-1">
										<input type="radio" name="accessInfo" id="access2" value="자유 출입가능" class="form-check-input">
										<label for="access2" class="form-check-label">자유 출입가능</label>
									</div>
									<div class="pb-2 ps-1">
										<input type="radio" name="accessInfo" id="access3" value="경비실 호출" class="form-check-input">
										<label for="access3" class="form-check-label">경비실 호출</label>
									</div>
									<div class="pb-3 ps-1">
										<input type="radio" name="accessInfo" id="access4" value="기타사항" class="form-check-input">
										<label for="access4" class="form-check-label">기타사항</label>
									</div>
								</div>

								<div class="col-md-12">
									<div class="row">
										<div class="col text-center">
											<input type="checkbox" class="form-check-input" name="addressSave" id="addressSave" value="1">
											<label for="addressSave" class="form-check-label pe-3">배송지정보 저장</label>

											<input type="checkbox" class="form-check-input" name="defaultDest" id="defaultDest" value="1">
											<label for="defaultDest" class="form-check-label">기본배송지로 설정</label>
										</div>
									</div>
								</div>

								<div class="col-md-12 text-center pt-4">
									<button type="button" class="btn-accent btnDeliveryInput">배송지 입력 완료</button>
									<button type="button" class="btn-default btnDeliveryModalClose" data-bs-dismiss="modal">취소</button>
								</div>
							</div>
							
						</form>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
									
<script type="text/javascript">
$(function(){
	$('.btnUpdateDelivery').click(function(){
		$('#deliveryDialogModal').modal('show');
	});
	
	$('.btnSelectDeliveryAddress').click(function(){
		let $el = $(this).closest('.saved-deliveryAddres');
		
		const addressName = $el.find('.saved-addressName').val();
		const defaultDest = $el.find('.saved-defaultDest').val();
		const recipientName = $el.find('.saved-recipientName').val();
		const zip = $el.find('.saved-zip').val();
		const addr1 = $el.find('.saved-addr1').val();
		const addr2 = $el.find('.saved-addr2').val();
		const tel = $el.find('.saved-tel').val();
		const pickup = $el.find('.saved-pickup').val();
		const accessInfo = $el.find('.saved-accessInfo').val();
		const passcode = $el.find('.saved-passcode').val();
		
		const f = document.paymentForm;
		f.recipientName.value = recipientName;
		f.tel.value = tel;
		f.zip.value = zip;
		f.addr1.value = addr1;
		f.addr2.value = addr2;
		f.pickup.value = pickup;
		f.accessInfo.value = accessInfo;
		f.passcode.value = passcode;
		
		$('.selected-recipientName').text(recipientName + (addressName ? '(' + addressName + ')' : ''));
		$('.selected-defaultDest').text(defaultDest === '1' ? '기본배송지' :'');
		$('.selected-addr').text(addr1 + ' ' + addr2);
		$('.selected-tel').text(tel);
		
		$('#deliveryDialogModal').modal('hide');
	});

	$('.btnDeliveryInput').click(function(){
		const f = document.deliveryAddressForm;
		const f2 = document.paymentForm;
		
	    if( !/^[가-힣]{2,5}$/.test(f.recipientName.value) ) {
	        alert('받는사람 이름을 다시 입력하세요. ');
	        f.recipientName.focus();
	        return;
	    }	
		
	    if( ! f.zip.value ) {
	        alert('우편번호는 필수입니다. ');
	        return;
	    }

	    if( ! f.addr1.value ) {
	        alert('주소는 필수입니다. ');
	        return;
	    }

	    if( ! f.addr2.value.trim() ) {
	        alert('주소는 필수입니다. ');
	        f.addr2.focus();
	        return;
	    }
	    
	    if( !/^\d{2,3}$/.test(f.tel1.value) ) {
	        alert('전화번호를 입력하세요. ');
	        f.tel1.focus();
	        return;
	    }

	    if( !/^\d{3,4}$/.test(f.tel2.value) ) {
	        alert('숫자만 가능합니다. ');
	        f.tel2.focus();
	        return;
	    }

	    if( !/^\d{4}$/.test(f.tel3.value) ) {
	    	alert('숫자만 가능합니다. ');
	        f.tel3.focus();
	        return;
	    }
		
		const accessInfos = document.querySelectorAll('form[name=deliveryAddressForm] input[name="accessInfo"]');
		let isChecked = false;

		for (const radio of accessInfos) {
			if (radio.checked) {
				isChecked = true;
				break;
			}
		}

		if (!isChecked) {
			alert('출입 방법을 선택해주세요.');
			return;
		}
		
		if(document.getElementById('access1').checked && ! f.passcode.value.trim()) {
			alert('비밀번호를 입력하세요.');
			f.passcode.focus();
			return;
		}
		
		if(! document.getElementById('access1').checked) {
			f.passcode.value = '';
		}

		let recipientName = f.recipientName.value;
		let addressName = f.addressName.value;
		let tel = f.tel1.value + '-' + f.tel2.value + '-' + f.tel3.value;
		let zip = f.zip.value;
		let addr1 = f.addr1.value;
		let addr2 = f.addr2.value;
		let pickup = f.pickup.value;
		let accessInfo = document.querySelector('form[name=deliveryAddressForm] input[name=accessInfo]:checked').value;
		let passcode = f.passcode.value;
		let defaultDest = f.defaultDest.checked ? '기본배송지' : '';
		
		f2.recipientName.value = recipientName;
		f2.tel.value = tel;
		f2.zip.value = zip;
		f2.addr1.value = addr1;
		f2.addr2.value = addr2;
		f2.pickup.value = pickup;
		f2.accessInfo.value = accessInfo;
		f2.passcode.value = passcode;
		
		$('.selected-recipientName').text(recipientName + (addressName ? '(' + addressName + ')' : ''));
		$('.selected-addr').text(addr1 + ' ' + addr2);
		$('.selected-tel').text(tel);
		
		if(f.addressSave.checked) {
			let url = '${pageContext.request.contextPath}/myShopping/deliveryAddress/save';
			let params = $('form[name=deliveryAddressForm]').serialize();
			const fn = function(data) {
				let defaultDest = f.defaultDest.checked ? '기본배송지' : '';
				$('.selected-defaultDest').text(defaultDest);
				
				$('#deliveryDialogModal').modal('hide');		
			};
			
			ajaxRequest(url, 'post', params, 'json', fn);
			
		} else {
			$('#deliveryDialogModal').modal('hide');
		}
	});
});
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
