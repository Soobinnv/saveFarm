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