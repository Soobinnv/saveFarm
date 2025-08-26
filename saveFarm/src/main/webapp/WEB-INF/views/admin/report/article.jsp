<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/tabs.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
<style type="text/css">
	table.reports-content th {
		background-color: #f8f9fa;
		text-align: left;
		white-space: nowrap;
		font-weight: 600;
	}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<main class="main-container">
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

	<div class="right-panel">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>게시글 신고 관리</h2>
		</div>

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="row gy-4 m-0">
					<div class="col-lg-12 board-section p-5 m-2" data-aos="fade-up" data-aos-delay="200">

						<div class="card shadow-sm mb-3">
							<div class="card-header bg-light-secondary py-3">
								<strong>신고 상세 정보</strong>
							</div>
							<div class="card-body">
							
								<table class="table table-bordered reports-content">
									<tbody>
										<tr>
											<th style="width: 15%;">콘텐츠</th>
											<td style="width: 35%;">${report.content_title}</td>
											<th style="width: 15%;">게시글번호</th>
											<td style="width: 35%;">${report.target_num} (${report.target})</td>
										</tr>
										<tr>
											<th>신고자</th>
											<td>${report.reporter_name} (${report.reporter_id})</td>
											<th>처리상태</th>
											<td>
												<c:choose>
													<c:when test="${report.report_status == 1}">신고접수</c:when>
													<c:when test="${report.report_status == 2}">처리완료</c:when>
													<c:when test="${report.report_status == 3}">기각</c:when>
													<c:otherwise>미확인</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<th>신고일자</th>
											<td>${report.report_date}</td>
											<th>신고 IP</th>
											<td>${report.report_ip}</td>
										</tr>
										<tr>
											<th>신고유형</th>
											<td>
												${report.reason_code}
											</td>
											<th>신고건수</th>
											<td>
												${reportsCount}
											</td>
										</tr>
										<tr>
											<th valign="middle">신고상세내용</th>
											<td colspan="3">
												<div class="p-2">${report.reason_detail}</div>
											</td>
										</tr>
								
										<c:if test="${not empty report.processor_id}">
											<tr>
												<th>처리담당자</th>
												<td>${report.processor_name} (${report.processor_id})</td>
												<th>처리일자</th>
												<td>${report.processed_date}</td>
											</tr>
											<tr>
												<th valign="middle">처리상세내용</th>
												<td colspan="3">
													<div class="p-2">${report.action_taken}</div>
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
								
								<div class="d-flex justify-content-between align-items-center">
									<div>
										<button type="button" class="btn-default me-2" onclick="reportProcess('one');">신고처리</button>
										<button type="button" class="btn-default" onclick="reportProcess('all');">신고 일괄처리</button>
									</div>
									
									<div>
										<button type="button" class="btn-default me-2" onclick="postsView()">게시글 보기</button>
										<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/admin/reportsManage/main?${query}';">리스트</button>
									</div>
								</div>
																
        					</div>
        				</div>
						
						<div class="card shadow-sm">
							<div class="card-header bg-light-secondary py-3">
								<strong>동일 게시글 신고 리스트</strong>
							</div>
							
							<div class="card-body reports-list"></div>
						</div>						

					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<!-- 신고 조치 -->
<div class="modal fade" id="reportHandledDialogModal" tabindex="-1" 
		data-bs-backdrop="static" data-bs-keyboard="false"
		aria-labelledby="reportHandledDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reportHandledDialogModalLabel">신고 조치</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form name="reportsForm" method="post" class="p-3 border rounded">
				    <div class="row mb-3">
				        <div class="col-md-6">
				            <label for="report-status" class="form-label">신고 처리 상태</label>
				            <select name="report_status" id="report-status" class="form-select">
				                <option value="2">처리완료</option>
				                <option value="3">기각</option>
				            </select>
				        </div>
				        <div class="col-md-6">
				            <label for="report-action" class="form-label">조치 유형</label>
				            <select name="report_action" id="report-action" class="form-select">
				                <option value="blind">블라인드</option>
				                <option value="delete">삭제</option>
				                <option value="none">무처리</option>
				                <option value="unlock">블라인드 해제</option>
				            </select>
				        </div>
				    </div>
				
				    <div class="mb-3">
				        <label for="action_taken" class="form-label">조치 사항</label>
				        <textarea name="action_taken" id="action_taken" class="form-control" style="height: 120px;" placeholder="조치사항을 입력해주세요"></textarea>
				    </div>
				
				    <!-- hidden inputs -->
				    <input type="hidden" name="num" value="${report.num}">
				    <input type="hidden" name="target" value="${report.target}">
				    <input type="hidden" name="target_num" value="${report.target_num}">
				    <input type="hidden" name="content_type" value="${report.content_type}">
				    <input type="hidden" name="mode" value="all">
				
				    <input type="hidden" name="status" value="${reportsStatus}">
				    <input type="hidden" name="page" value="${page}">
				    <input type="hidden" name="schType" value="${schType}">
				    <input type="hidden" name="kwd" value="${kwd}">

				    <div class="text-end">
						<button type="button" class="btn-accent" onclick="reportProcessSaved();"> 등록 </button>
						<button type="button" class="btn-default" data-bs-dismiss="modal"> 취소 </button>
				    </div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 게시글 내용 -->
<div class="modal fade" id="postsDialogModal" tabindex="-1" aria-labelledby="postsDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
        
            <div class="modal-header">
                <h5 class="modal-title" id="postsDialogModalLabel">게시글 내용</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
            	<c:choose>
            		<c:when test="${empty posts}">
            			<p class="text-center p-3">삭제된 게시글입니다.</p>
            		</c:when>
            		<c:otherwise>
						<table class="table table-bordered reports-content">
							<tbody>
								<tr>
									<th style="width: 15%;">작성자</th>
									<td style="width: 35%;">${posts.writer} (${posts.writer_id})</td>
									<th style="width: 15%;">블라인드</th>
									<td style="width: 35%;">${posts.block == 1 ? "블라인드 처리" : ""}</td>
								</tr>
								<c:if test="${not empty posts.subject}">
									<tr>
										<th style="width: 15%;">제목</th>
										<td style="width: 85%;" colspan="3">${posts.subject}</td>
									</tr>
								</c:if>
								<tr>
									<th style="width: 15%;">내용</th>
									<td style="width: 85%;" colspan="3">${posts.content}</td>
								</tr>
								<c:if test="${not empty posts.imageFilename}">
									<tr>
										<th style="width: 15%;">이미지</th>
										<td style="width: 85%;" colspan="3"> <img src="${posts.imageFilename}" class="img-fluid rounded border mt-2" alt="첨부 이미지"></td>
									</tr>
								</c:if>
							</tbody>
						</table>
            		</c:otherwise>
            	</c:choose>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn-default" data-bs-dismiss="modal">닫기</button>
            </div>
            
        </div>
    </div>
</div>

<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	// 동일 게시물 신고리스트
	const url = '${pageContext.request.contextPath}/admin/reportsManage/listRelated';
	const params = 'num=${report.num}&target_num=${report.target_num}&target=${report.target}&pageNo=' + page;
	const fn = function(data){
		const selector = '.reports-list';
		$(selector).html(data);
	};

	ajaxRequest(url, 'get', params, 'text', fn);	
}

function reportProcess(mode) {
	// 신고처리 대화상자 출력
	const f = document.reportsForm;
	
	f.mode.value = mode;
	f.action_taken.value = '';
	f.report_status.value = '2'
	f.report_action.value = 'blind';
	
	if(mode === 'one') {
		$('#reportHandledDialogModalLabel').html('신고처리');
	} else {
		$('#reportHandledDialogModalLabel').html('동일게시글 일괄처리');
	}
	
	$('#reportHandledDialogModal').modal('show');
}

function reportProcessSaved() {
	const f = document.reportsForm;
	
	if(! f.action_taken.value.trim()) {
		alert('조치사항을 입력 하세요.');
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/admin/reportsManage/update';
	f.submit();
}

function postsView() {
	$('#postsDialogModal').modal('show');
}

$(function(){
	$('#report-status').change(function(){
		let value = $(this).val();
		
		if(value === '3') {
			$('#report-action').val('none');
		} else {
			$('#report-action').val('blind');
		}
	});
});

</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>