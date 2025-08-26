<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${list.size() > 0}">
	<div class="accordion accordion-flush mt-1" id="accordionFlush"> 
		<c:forEach var="dto" items="${list}" varStatus="status">
			<div class="accordion-item" style="border: none;">
				<h2 class="accordion-header mb-1 border" id="flush-heading-${status.index}">
					<button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${status.index}" aria-expanded="false" aria-controls="flush-collapse-${status.index}">
						<span class="flex-grow-1 text-truncate">${dto.subject}</span>
    					<small class="text-muted ms-auto text-nowrap" style="padding-right: 10px;">${dto.categoryName}</small>
					</button>
				</h2>
				
				<div id="flush-collapse-${status.index}" class="accordion-collapse collapse" aria-labelledby="flush-heading-${status.index}" data-bs-parent="#accordionFlush">
					<div class="accordion-body p-2">
						<div class="row border-bottom mb-1 py-2">
							<div class="col mh-px-70 text-light-emphasis">${dto.content}</div>
							<div class="col-auto">
								등록일 : 
								<label class="text-light-emphasis">
									${fn:substringBefore(dto.regDate, ' ')}
								</label>			
							</div>
						</div>

					</div>
				</div>
			</div>		
		</c:forEach>
	</div>
</c:if>
