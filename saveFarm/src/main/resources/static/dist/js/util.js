async function fetchRequest(url, method='GET', data=null, contentType='urlEncoded', responseType='json', headers = {'AJAX': true}) {
	const upperMethod = method.toUpperCase();
	const lowerContentType = contentType.toLowerCase();
	
	const sentinelNode = document.querySelector('.sentinel');
	
	const options = {
		method: method,
		headers: { ...headers }
	};
	
	// GET 요청일 경우 URL에 파라미터 추가
	if (upperMethod === 'GET' && data && typeof data === 'object') {
		const params = new URLSearchParams(data).toString();
		url += (url.includes('?') ? '&' : '?') + params;
	} else if (upperMethod !== 'GET' && data !== null) {
		// POST, PUT 등일 때 본문 설정
		switch (lowerContentType) {
		case 'json':
			options.headers['Content-Type'] = 'application/json';
			options.body = JSON.stringify(data);
			break;

		case 'formdata':
			// FormData는 자동으로 Content-Type을 설정하므로 헤더 생략
			options.body = data instanceof FormData ? data : objectToFormData(data);
			break;

		case 'urlencoded':
			options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
			options.body = new URLSearchParams(data).toString();
			break;

		default:
			throw new Error('지원하지 않는 Content-Type: ' + contentType);
		}
	}
	
	try {
		if(sentinelNode) {
			sentinelNode.setAttribute('data-loading', 'true');
		}
		
		fadeTo('#loadingLayout');
						
		const resp = await fetch(url, options);
		if (! resp.ok ) {
			switch (resp.status) {
				case 401: alert('로그인이 필요 합니다.'); break;
				case 403: alert('권한이 필요 합니다.'); break;
				case 406: alert('요청 처리가 실패 했습니다.'); break;
				case 410: alert('삭제된 게시물입니다.'); break;
				case 500: alert('요청 처리가 실패 했습니다.'); break;
				default: throw new Error('HTTP 오류: ' + resp.status);
			}
			
			return;
		}
		
		switch (responseType) {
		case 'json': return await resp.json();
		case 'text': return await resp.text();
		case 'blob': return await resp.blob();
		default: throw new Error('지원하지 않는 responseType: ' + responseType);
		}
	} catch (error) {
	    throw error;
	} finally {
		hideElement('#loadingLayout')
	}
}

// object를 formData로 변환
function objectToFormData(obj) {
    const formData = new FormData();
    for (const key in obj) {
        if (obj.hasOwnProperty(key)) {
            formData.append(key, obj[key]);
        }
    }
    
    return formData;
}

// 요소가 보이지 않으면 true를 반환
function isHidden(el) {
	const styles = window.getComputedStyle(el);
	return styles.display === 'none' || styles.visibility === 'hidden' || styles.opacity === '0';
}

// 요소에 부드럽게 투명도를 적용하여 보이기
function fadeTo(selector, duration = 600, targetOpacity = 0.6, displayType = 'block') {
	const element = document.querySelector(selector);
	if (!element) {
		return;
	}

	element.style.display = displayType;
	
	let opacity = parseFloat(window.getComputedStyle(element).opacity);
	const interval = 10;
	const step = (opacity - targetOpacity) / (duration / interval);
	
	const fade = setInterval(() => {
		opacity -= step;
		if (opacity <= targetOpacity) {
			opacity = targetOpacity;
			clearInterval(fade);
		}
		element.style.opacity = opacity;
	}, interval);
}

// 요소 보이기
function showElement(selector, displayType = 'block') {
  const element = document.querySelector(selector);

  if (!element) {
    return;
  }
  element.style.display = displayType;
}

// 요소 숨기기
function hideElement(selector) {
	const element = document.querySelector(selector);
	if (!element) {
		return;
	}
	element.style.display = 'none';
}

// 이미지 파일인지 검사
function isImageFile(filename){
	let format = /(\.gif|\.jpg|\.jpeg|\.png)$/i;
	return format.test(filename);
}

// 파일 용량 구하기
function fileSize(file) {
	let size = 0;
	
	for(let f of file.files) {
		size += f.size;
	}
	
	return size;
}

// 이메일 형식 검사
function isValidEmail(data){
    let format = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    return format.test(data); // true : 올바른 포맷 형식
}

// SQL 문 존재 여부 검사
function isValidSQL(data){
    let format = /(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|EXEC|UNION|FETCH|DECLARE|TRUNCATE)/gi;
    return format.test(data);
}

// -------------------------------------------------
// 전체화면
const fullscreen = el => {
    if ( el.requestFullscreen ) return el.requestFullscreen();
    if ( el.webkitRequestFullscreen ) return el.webkitRequestFullscreen();
    if ( el.mozRequestFullScreen ) return el.mozRequestFullScreen();
    if ( el.msRequestFullscreen ) return el.msRequestFullscreen();
};

// 전체화면 취소
const cancelFullScreen = () => {
    if ( document.exitFullscreen ) return document.exitFullscreen();
    if ( document.webkitCancelFullscreen ) return document.webkitCancelFullscreen();
    if ( document.mozCancelFullScreen ) return document.mozCancelFullScreen();
    if ( document.msExitFullscreen ) return document.msExitFullscreen();
};

// 전체 화면 토글
function toggleFullScreen(el) {
    if ( ! document.fullscreenElement ) {
        fullscreen(el);
    } else {
        cancelFullScreen();
    }
}

// -------------------------------------------------
// 자바스크립트 xss 방지 HTML 특수문자 변환
// Cross-site Scripting (XSS)
//   : SQL injection과 함께 웹 상에서 가장 기초적인 취약점 공격 방법의 일종
function symbolHtml(content) {
    if (! content) return content;

    content = content.replace(/</g, '&lt;');
    content = content.replace(/>/g, '&gt;');
    content = content.replace(/\"/g, '&quot;');
    content = content.replace(/\'/g, '&#39;');
    content = content.replace(/\(/g, '&#40;');
    content = content.replace(/\)/g, '&#41;');

    return content;
}

// 기호를 특수문자로
function restoreHtml(content) {
    if (! content) return content;
    
    content = content.replace(/\&lt;/gi, '<');
    content = content.replace(/\&gt;/gi, '>');
    content = content.replace(/\&#40;/gi, '(');
    content = content.replace(/\&#41;/gi, ')');
    content = content.replace(/\&#39;/gi, "'");
    content = content.replace(/\&quot;/gi, "\"");
    
    return content;
}

// 문자열에 특수문자(",  ',  <,  >, (, ) ) 검사
function isValidSpecialChar(data) {
    let format = /[\",\',<,>,\(,\)]/g;
    return format.test(data);
}

// -------------------------------------------------
// 이벤트 등록
/* 
    // 사용 예
    let func= function() { alert('예제'); }
    addEvent(window, load, func);
*/
function addEvent(el, evType, fn) {
    if (el.addEventListener) {
        el.addEventListener(evType, fn, false);
        return true;
    } else if (el.attachEvent) {
        let r = el.attachEvent('on' + evType, fn);
        return r;
    } else {
        el['on' + evType] = fn;
    }
}

// -------------------------------------------------
// 팝업 윈도우즈
function winOpen(url, windowName, windowFeatures) {
	if(! theURL) return;
	if(! windowName) windowName = '';
	
	let flag = windowFeatures;
    if(flag === undefined) {
		flag = 'left=10, ';
		flag += 'top=10, ';
		flag += 'width=372, ';
		flag += 'height=466, ';
		flag += 'toolbar=no, ';
		flag += 'menubar=no, ';
		flag += 'status=no, ';
		flag += 'scrollbars=no, ';
		flag += 'resizable=no';
		// flag = 'scrollbars=no,resizable=no,width=220,height=230';
	}
	
    window.open(url, windowName, flag);
}

// -------------------------------------------------
// 기타 형식 검사
// 영문, 숫자 인지 확인
 function isValidEngNum(str) {
    for(let i = 0; i < str.length; i++) {
        achar = str.charCodeAt(i);                 
        if( achar > 255 ) {
            return false;
        }
    }
    return true; 
}

// 전화번호 형식(숫자-숫자-숫자)인지 체크
function isValidPhone(data) {
    // let format = /^(\d+)-(\d+)-(\d+)$/;
    let format = /^(010)-[0-9]{4}-[0-9]{4}$/g;
    return format.test(data);
}
