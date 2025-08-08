const uploadUrl = '/editor/upload';

// Quill(퀼) text editor
const quill = new Quill('#editor', {
	modules: {
		toolbar: [
			// [{ size: [ 'small', false, 'large', 'huge' ] }],
			[{ 'header': [1, 2, 3, 4, 5, 6, false] }],
			// [{ 'font': [] }],
			['bold', 'italic', 'underline', 'strike'],
			[{ 'align': [] }],
			[{ 'color': [] }, { 'background': [] }],
			[{ list: 'ordered' }, { list: 'bullet' }, { 'indent': '-1'}, { 'indent': '+1' }],
			['blockquote', 'code-block'],
			['link', 'image'],
			['clean'], // remove formatting button
		],
		
		resize: {
			// tools: []
        },
	},
	placeholder: 'Content',
	theme: 'snow', // or 'bubble'
});

const toolbar = quill.getModule('toolbar');

// 이미지 버튼
toolbar.addHandler('image', imageHandler);
function imageHandler() {
	const input = document.createElement('input');
	input.setAttribute('type', 'file');
	input.setAttribute('accept', 'image/*');
	input.click();

	input.onchange = function () {
		const file = input.files[0];
		
		const fn = function(data) {
			if (data.imageUrl) {
				const range = quill.getSelection();
				quill.insertEmbed(range.index, 'image', data.imageUrl);
			} else {
				alert('이미지 업로드 실패');
			}
		};
		
		if (file) {
			const formData = new FormData();
			formData.append('imageFile', file);

			const options = {
				method: "post",
				body: formData,
			};
			
			fetch(uploadUrl, options)
				.then(res => res.json())
				.then(data => fn(data))
				.catch(err => console.log("error:", err));
		}
	};
}

// 소스 보기 버튼 추가
// 툴바 컨테이너
const toolbarContainer = document.querySelector('.ql-toolbar');

// 마지막 버튼 그룹(ql-formats) 찾기
const buttonGroups = toolbarContainer.querySelectorAll('.ql-formats');
const lastGroup = buttonGroups[buttonGroups.length - 1];

// 커스텀 버튼을 생성
const button = document.createElement('button');
button.innerText = 'HTML';
button.title = 'Source';
button.type = 'button';
button.classList.add('ql-custom-button');

// 버튼 이벤트 처리
let isSourceView = false;
button.addEventListener('click', () => {
	const editorEl = document.querySelector('#editor');
	const editorContainer = editorEl.parentElement;
	
	if (!isSourceView) {
		const html = editorEl.querySelector('.ql-editor').innerHTML;

		// 기존 Quill 에디터 제거
		quill.disable();
		editorEl.style.display = 'none';

		// <textarea> 삽입
		const textarea = document.createElement('textarea');
		textarea.id = 'html-view';
		textarea.style.width = '100%';
		// textarea.style.height = '260px';
		textarea.value = html;
		textarea.classList.add('default-control');
		textarea.style.borderTop = 'none';
		editorContainer.appendChild(textarea);
		
		button.innerText = 'View';
		button.title = 'Preview';
		isSourceView = true;
	} else {
		const textarea = document.getElementById('html-view');
		const newHtml = textarea.value;

		quill.root.innerHTML = newHtml;
		quill.enable();

		// textarea 제거
		textarea.remove();
		editorEl.style.display = '';
		
		button.innerText = 'HTML';
		button.title = 'Source';
		isSourceView = false;
	}
});

// 툴바에 소스보기 버튼 추가
lastGroup.appendChild(button);
