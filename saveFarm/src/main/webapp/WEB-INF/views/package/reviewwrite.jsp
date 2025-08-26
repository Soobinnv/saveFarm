<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>구독리뷰</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
  :root{
    --primary:#18a05b;   /* 버튼·포커스 컬러 */
    --primary-ink:#117645;
    --border:#e6efe9;    /* 카드 테두리 */
    --ink:#1f2937;       /* 본문 글색 */
    --muted:#6b7280;     /* 보조 텍스트 */
    --bg:#ffffff;
  }
  *{box-sizing:border-box}
  body{
    font-family: "Pretendard", "Noto Sans KR", system-ui, -apple-system, Segoe UI, Roboto, "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    margin:0; padding:40px 16px; background:#f6faf8; color:var(--ink);
  }

  /* 카드 래퍼 */
  .review-card{
    max-width: 860px; margin: 0 auto;
    background:var(--bg);
    border:2px solid var(--border);
    border-radius:16px;
    box-shadow:0 6px 20px rgba(17,24,39,.04);
  }
  .card-in{ padding:28px 28px 20px 28px; }
  .card-foot{ padding:0 28px 28px 28px; }

  /* 타이틀/메타 */
  .title{ font-size:28px; font-weight:800; letter-spacing:-.3px; margin:4px 0 18px; }
  .meta-row{
    display:flex; gap:12px; align-items:center; justify-content:space-between;
    font-size:15px; color:var(--muted); margin-bottom:8px;
    flex-wrap:wrap;
  }
  .meta-row b{ color:var(--ink) }
  .hr{ height:1px; background:var(--border); margin:12px 0 18px }

  /* 폼 공통 */
  .field{ margin:16px 0 }
  .label{ display:inline-block; font-size:15px; font-weight:700; margin-bottom:8px }
  .hint{ font-size:12px; color:var(--muted); margin-left:6px }
  .control{ width:100% }
  input[type="text"], textarea{
    width:100%; border:1.5px solid var(--border); background:#fff;
    padding:14px 16px; border-radius:14px; font-size:15px; outline:none;
    transition:.15s border-color;
  }
  input[type="text"]:focus, textarea:focus{ border-color:var(--primary) }
  textarea{ min-height:200px; resize:vertical; line-height:1.6 }

  /* 별점 */
  .stars{ display:inline-flex; gap:6px; align-items:center }
  .rating{ display:inline-flex; flex-direction: row-reverse; gap:6px }
  .rating input{ display:none }
  .rating label{
    font-size:28px; cursor:pointer; filter:grayscale(1) opacity(.5);
    transition: .1s transform, .15s filter;
  }
  .rating label:hover{ transform:translateY(-1px); filter:none }
  .rating input:checked ~ label,
  .rating label:hover,
  .rating label:hover ~ label{
    filter:none; color:#f4b400;
  }
  .rating-caption{ font-size:14px; color:var(--muted); margin-left:8px }

  /* 파일 업로드 */
  .filebox{ display:flex; gap:10px; align-items:center; flex-wrap:wrap }
  .filebox input[type="file"]{
    position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); border:0;
  }
  .filebox .btn-file{
    display:inline-block; padding:12px 14px; border-radius:12px;
    background:#eef7f2; color:var(--primary-ink); font-weight:700; font-size:14px;
    border:1px solid var(--border); cursor:pointer;
  }
  .filebox .file-names{
    flex:1; min-width:220px; border:1px dashed var(--border);
    border-radius:12px; padding:12px 14px; font-size:13px; color:var(--muted);
    background:#fcfffd;
  }
  .previews{ display:flex; gap:10px; margin-top:10px; flex-wrap:wrap }
  .previews img{
    width:84px; height:84px; object-fit:cover; border-radius:10px;
    border:1px solid var(--border);
  }

  /* 제출 버튼 */
  .submit-wrap{ margin-top:18px }
  .btn-submit{
    width:100%; height:48px; border-radius:999px; font-weight:800; font-size:16px;
    border:none; color:#fff; background:var(--primary); cursor:pointer;
    transition:.15s transform, .15s filter;
  }
  .btn-submit:hover{ transform: translateY(-1px); filter:brightness(0.98) }
  .btn-submit:disabled{ opacity:.5; cursor:not-allowed }

  /* 카운터 */
  .counter{ font-size:12px; color:var(--muted); text-align:right; margin-top:6px }

  /* 반응형 */
  @media (max-width:560px){
    .card-in{ padding:22px 16px 10px }
    .card-foot{ padding:0 16px 16px }
  }
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<div class="review-card">
  <div class="card-in">
    <div class="title">구독리뷰</div>

    <div class="meta-row">
      <div>구독 주문 번호 : <b>${subNum}</b></div>
      <div><b>${memberName}</b> 님의 <b>${subMonth}</b>회차 구독 리뷰</div>
    </div>
    <div class="hr"></div>

    <form name="reviewForm"
          action="${pageContext.request.contextPath}/package/reviewSubmit"
          method="post" enctype="multipart/form-data" autocomplete="off">

      <!-- 별점 -->
      <div class="field">
        <div class="label">별점</div>
        <div class="stars">
          <div class="rating">
            <input type="radio" id="star5" name="star" value="5"><label for="star5">★</label>
            <input type="radio" id="star4" name="star" value="4"><label for="star4">★</label>
            <input type="radio" id="star3" name="star" value="3"><label for="star3">★</label>
            <input type="radio" id="star2" name="star" value="2"><label for="star2">★</label>
            <input type="radio" id="star1" name="star" value="1"><label for="star1">★</label>
          </div>
        </div>
      </div>

      <!-- 제목 -->
      <div class="field">
        <label class="label" for="title">제목</label>
        <input class="control" type="text" id="subject" name="subject"
               placeholder="리뷰 제목을 입력하세요" maxlength="60" required>
        <div class="counter"><span id="titleCnt">0</span>/60</div>
      </div>

      <!-- 내용 -->
      <div class="field">
        <label class="label" for="content">내용</label>
        <textarea class="control" id="content" name="content"
                  placeholder="구독 상품/배송/맛/포장 등에 대한 솔직한 후기를 남겨주세요 (최소 20자)" maxlength="1000" required></textarea>
        <div class="counter"><span id="contCnt">0</span>/1000</div>
      </div>

      <!-- 파일 첨부 -->
      <div class="field">
        <div class="label">사진 첨부 <span class="hint">(선택 · 최대 5장, 10MB 이하 / jpg·png)</span></div>
        <div class="filebox">
          <label for="files" class="btn-file">파일 선택</label>
          <input id="files" type="file" name="selectFile" accept="image/*" multiple>
          <div class="file-names" id="fileNames">선택된 파일 없음</div>
        </div>
        <div class="previews" id="previews"></div>
      </div>

      <!-- 숨김값 (필요 시) -->
      <input type="hidden" name="subNum" value="202508147000000007">
      
     

      <div class="submit-wrap">
        <button type="submit" class="btn-submit" id="submitBtn">리뷰 등록</button>
      </div>
    </form>
  </div>
  <div class="card-foot"></div>
</div>

<script>
  // 별점 텍스트
  const ratingText = document.getElementById('ratingText');
	document.querySelectorAll('input[name="star"]').forEach(r => {
 	 r.addEventListener('change', () => {
    	if (ratingText) ratingText.textContent = r.value + "점";
  	});
});

  // 글자수 카운터
  const titleEl = document.getElementById('subject');
  const contentEl = document.getElementById('content');
  titleEl.addEventListener('input', () =>
    document.getElementById('titleCnt').textContent = titleEl.value.length);
  contentEl.addEventListener('input', () =>
    document.getElementById('contCnt').textContent = contentEl.value.length);

  // 파일 미리보기/이름 표시
  const fileInput = document.getElementById('files');
  const names = document.getElementById('fileNames');
  const previews = document.getElementById('previews');
  fileInput.addEventListener('change', () => {
    const files = Array.from(fileInput.files).slice(0, 5);
    names.textContent = files.length
      ? files.map(f => f.name).join(', ')
      : '선택된 파일 없음';

    previews.innerHTML = '';
    files.forEach(f => {
      if(!f.type.startsWith('image/')) return;
      const reader = new FileReader();
      reader.onload = e => {
        const img = new Image();
        img.src = e.target.result;
        previews.appendChild(img);
      };
      reader.readAsDataURL(f);
    });
  });
	
  const f = document.reviewForm;
  // 간단 유효성 검사
  f.addEventListener('submit', (e) => {
  const ratingChecked = document.querySelector('input[name="star"]:checked');
  if (!ratingChecked) {
    alert('별점을 선택해주세요.');
    e.preventDefault(); return;
  }
    if (contentEl.value.trim().length < 20) {
      alert('내용은 최소 20자 이상 입력해주세요.');
      e.preventDefault();
    }
  });
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>
