// HTML 생성 로직 //

/**
 * 상품 리스트 HTML 문자열 생성
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductListHTML = function(item) {	
	let classify = 100;
	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">상품 리스트</h2>
	      <div class="row my-4">
	        <!-- Small table -->
	        <div class="col-md-12">
	          <div class="card shadow">
	            
	            <div class="card-body">
	              <div class="row m-0">
	      			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
	     		  </div>		
	              <ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify==100?'active':''}" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="1" aria-selected="${classify==0?'true':'false'}">일반상품</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify==200?'active':''}" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="2" aria-selected="${classify==1?'true':'false'}">구출상품</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify==300?'active':''}" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="3" aria-selected="${classify==2?'true':'false'}">세이프팜특가</button>
						</li>
					</ul>
	            	
	              <!-- table -->
	              <table class="table datatables" id="dataTable-1">
	                <thead>
	                  <tr>
	                    <th>상품번호</th> <!-- 회원생성시 번호 -->
	                    <th>상풍명</th> <!-- 회원생성시 입력한 아이디 -->
						<th>가격</th> <!-- 일반회원, 농가회원, 관리자 -->
						<th>재고</th> <!-- 회원생성시 입력한 이름 -->
	                    <th>진열</th> <!-- 회원생성시 입력한 생녀월일 -->
	                    <th>수정일</th> <!-- 회원생성시 입력한 전화번호 -->
	                    <th>변경</th> <!-- 회원생성시 입력한 전화번호 -->
	                  </tr>
	                </thead>
	                <tbody>
	                  <tr>
	                    <td>2</td>
	                    <td>김밥</td>
	                    <td>5000</td>
	                    <td>0</td>
	                    <td>일반상품</td>
	                    <td>2025-08-07</td>
	                    <td><button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                        <span class="text-muted sr-only">Action</span>
	                      </button>
	                      <div class="dropdown-menu dropdown-menu-right">
	                        <a class="dropdown-item" href="#">재고</a>
	                        <a class="dropdown-item" href="#">상품정보변경</a>
	                      </div>
	                    </td>
	                  </tr>
	                </tbody>
	              </table>
	                  <div class="row">
						<div class="col-sm-12 col-md-5"></div>
						<div class="col-sm-12 col-md-5">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="0" tabindex="0" class="page-link fe fe-chevron-left"></a>
									</li>
									<li class="paginate_button page-item active">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="1" tabindex="0" class="page-link">1</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="2" tabindex="0" class="page-link">2</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="3" tabindex="0" class="page-link">3</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="4" tabindex="0" class="page-link">4</a>
									</li>
									<li class="paginate_button page-item next" id="dataTable-1_next">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="5" tabindex="0" class="page-link fe fe-chevron-right"></a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-sm-12 col-md-2 d-flex justify-content-end">
							<button type="button" class="btn mb-2 mr-1 btn-outline-primary">상품등록</button>
							<button type="button" class="btn mb-2 btn-outline-primary">상품삭제</button>
						</div>
					</div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div> 
	  </div>
	</div> 
	`
	return html;
}
/**
 * 농가 상품 등록 HTML 문자열 생성
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderFarmProductListHTML = function() {	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">농가상품 신청</h2>
	      <div class="row my-4">
	        <!-- Small table -->
	        <div class="col-md-12">
	          <div class="card shadow">
	            
	            <div class="card-body">
	              <div class="row m-0">
	      			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
	     		  </div>		
	              <!-- table -->
	              <table class="table datatables" id="dataTable-1">
	                <thead>
	                  <tr>
	                    <th>상품번호</th> 
	                    <th>상풍명</th> 
						<th>가격</th> 
	                    <th>농가명</th> 
	                    <th>농가아이디</th> 
	                    <th>신청일</th>
	                    <th>변경</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  <tr>
	                    <td>2</td>
	                    <td>김밥</td>
	                    <td>5000</td>
	                    <td>**농가</td>
	                    <td>nonga</td>
	                    <td>2025-08-07</td>
	                    <td><button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                        <span class="text-muted sr-only">Action</span>
	                      </button>
	                      <div class="dropdown-menu dropdown-menu-right">
	                        <a class="dropdown-item" href="#">승인</a>
	                        <a class="dropdown-item" href="#">반려</a>
	                      </div>
	                    </td>
	                  </tr>
	                </tbody>
	              </table>
	                  <div class="row">
						<div class="col-sm-12 col-md-5"></div>
						<div class="col-sm-12 col-md-5">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="0" tabindex="0" class="page-link fe fe-chevron-left"></a>
									</li>
									<li class="paginate_button page-item active">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="1" tabindex="0" class="page-link">1</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="2" tabindex="0" class="page-link">2</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="3" tabindex="0" class="page-link">3</a>
									</li>
									<li class="paginate_button page-item ">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="4" tabindex="0" class="page-link">4</a>
									</li>
									<li class="paginate_button page-item next" id="dataTable-1_next">
										<a href="#" aria-controls="dataTable-1" data-dt-idx="5" tabindex="0" class="page-link fe fe-chevron-right"></a>
									</li>
								</ul>
							</div>
						</div>
					</div>
	            </div>
	          </div>
	        </div> 
	      </div>
	    </div>
	  </div> 
	</div> 
	
	
	`
	return html;
}
/**
 * 상품 문의 HTML 문자열 생성
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductQnaListHTML = function() {	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title">상품 문의</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body">
	             <div class="row m-0">
	      			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
	     		  </div>           
	              <table class="table datatables" id="dataTable-1">
	                <thead>
	                  <tr>
	                    <th>문의번호</th>
						<th>상품번호</th> 
						<th>상품명</th>   
						<th>문의명</th>   
						<th>작성자</th>    
						<th>문의일자</th>  
						<th>답변자</th>    
						<th>답변일자</th>  
						<th>처리결과</th>  
	                  </tr>
	                </thead>
	                <tbody>
	                  <tr>
	                    <td>1</td>
	                    <td>1546516</td>
	                    <td>ㅇㅇ당근</td>
	                    <td>
	                    	<a href="" class="text-secondary">아니...</a>
	                    </td>
	                    <td>김자바</td>
	                    <td>2025-08-15 10:10</td>
	                    <td></td>
	                    <td></td>
	                    <td>답변대기</td> <!-- 0 답변대기 1 답변중 2 답변완료 -->
	                    
	                  </tr>
	                </tbody>
	              </table>
	                 <div class="row justify-content-center">
	                  	<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
				  			<ul class="pagination">
				  				<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="0" tabindex="0" class="page-link fe fe-chevron-left"></a>
				  	  			</li>
				  				<li class="paginate_button page-item active">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="1" tabindex="0" class="page-link">1</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="2" tabindex="0" class="page-link">2</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="3" tabindex="0" class="page-link">3</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="4" tabindex="0" class="page-link">4</a>
				  				</li>
				  				<li class="paginate_button page-item next" id="dataTable-1_next">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="5" tabindex="0" class="page-link fe fe-chevron-right"></a>
				  				</li>
				  			</ul>
				  	 	</div>
	                 </div>
	                 <div class="row">
						<div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
						<div class="col-sm-12 col-md-6 d-flex justify-content-center ">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item mr-2">
										<button type="reset" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary"></button>
									</li>
									<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
										<select class="form-control">
											<option>제목+내용</option>
											<option>글쓴이</option>
											<option>작성일</option>
											<option>제목</option>
											<option>내용</option>
										</select>
									</li>
									<li class="paginate_button page-item active mr-2">
										<input type="text" class="form-control " id="search1" value="" placeholder="Search">
									</li>
									<li class="paginate_button page-item ">
										<button type="button" class="btn mb-2 btn-outline-primary">검색</button>
									</li>
									
								</ul>
							</div>
						</div>
						
					</div> 
	            </div>
	          </div>
	        </div> 
	      </div> 
	    </div> 
	  </div>
	</div> 		
	`
	return html;
}
/**
 * 상품 리뷰 HTML 문자열 생성
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductReviewListHTML = function() {	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title">상품 리뷰</h2>
	      <div class="row my-4">
	        <!-- Small table -->
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body">
	             <div class="row m-0">
	      			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
	     		  </div>                    
	              <!-- table -->
	              <table class="table datatables" id="dataTable-1">
	                <thead>
	                  <tr>
	                    <th>번호</th>    <!-- 리뷰 고유 번호 -->
						<th>상품번호</th>       <!-- 문의 제목 -->
						<th>상품명</th>       <!-- 문의 제목 -->
						<th>리뷰내용</th>       <!-- 문의 제목 -->
						<th>작성자</th>     <!-- 문의 작성자 -->
						<th>작성일자</th>   <!-- 문의 작성 날짜 -->
						<th>별점</th>   <!-- 문의 작성 날짜 -->
						<th>상태</th>   <!-- 문의 처리 상태 -->
						<th>선택</th>   <!-- 문의 처리 상태 -->
	                  </tr>
	                </thead>
	                <tbody>
	                  <tr>
	                    <td>1</td>
	                    <td>1546516</td>
	                    <td>ㅇㅇ당근</td>
	                    <td>
	                    	<a href="" class="text-secondary">아니...</a>
	                    </td>
	                    <td>김자바</td>
	                    <td>2025-08-15 10:10</td>
	                    <td>5</td>
	                    <td>비활성화</td> <!-- 0 보임 1 숨김 -->
	                    <td><button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                        <span class="text-muted sr-only">선택</span>
	                      </button>
	                      <div class="dropdown-menu dropdown-menu-right">
	                        <a class="dropdown-item" href="#">리뷰 활성화여부</a>
	                        <a class="dropdown-item" href="#">리뷰 삭제</a>
	                      </div>
	                    </td>
	                  </tr>
	                </tbody>
	              </table>
	                 <div class="row justify-content-center">
	                  	<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
				  			<ul class="pagination">
				  				<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="0" tabindex="0" class="page-link fe fe-chevron-left"></a>
				  	  			</li>
				  				<li class="paginate_button page-item active">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="1" tabindex="0" class="page-link">1</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="2" tabindex="0" class="page-link">2</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="3" tabindex="0" class="page-link">3</a>
				  				</li>
				  				<li class="paginate_button page-item ">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="4" tabindex="0" class="page-link">4</a>
				  				</li>
				  				<li class="paginate_button page-item next" id="dataTable-1_next">
				  					<a href="#" aria-controls="dataTable-1" data-dt-idx="5" tabindex="0" class="page-link fe fe-chevron-right"></a>
				  				</li>
				  			</ul>
				  	 	</div>
	                 </div>
	                 <div class="row">
						<div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
						<div class="col-sm-12 col-md-6 d-flex justify-content-center ">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item mr-2">
										<button type="reset" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary"></button>
									</li>
									<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
										<select class="form-control">
											<option>제목+내용</option>
											<option>글쓴이</option>
											<option>작성일</option>
											<option>제목</option>
											<option>내용</option>
										</select>
									</li>
									<li class="paginate_button page-item active mr-2">
										<input type="text" class="form-control " id="search1" value="" placeholder="Search">
									</li>
									<li class="paginate_button page-item ">
										<button type="button" class="btn mb-2 btn-outline-primary">검색</button>
									</li>
									
								</ul>
							</div>
						</div>
					</div> 
	            </div>
	          </div>
	        </div> 
	      </div> 
	    </div> 
	  </div> 
	</div> 
	`
	return html;
}