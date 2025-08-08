/* 이미지 업로드 */
window.addEventListener('DOMContentLoaded', () => {
	var sel_files = [];
	var fileSize = 0;
	const maxFileSize = 5 * 1024 * 1024;
	
	const fileListEL = document.querySelector('form .image-upload-panel .file-upload-list');
	if (! fileListEL) return false;
	
	const imgAddEL = document.querySelector('form .image-upload-panel .drag-area');
	const inputEL = document.querySelector('form .image-upload-panel input[type=file]');
	const sizeEL = document.querySelector('form .image-upload-panel .file-size');
		
	const fileTransfer = () => {
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
			
		inputEL.files = dt.files;
		
		if(sizeEL) {
			fileSize = fileSize >= 0 ? fileSize : 0;
			let size = fileSize / (1024 * 1024);
			sizeEL.textContent = size.toFixed(2);
		}
	};

	const imageLoader = file => {
		sel_files.push(file);
			
		let node = document.createElement('div');
		node.classList.add('image-item');
		node.setAttribute('data-filename', file.name);

		const reader = new FileReader();
		reader.onload = e => {
			let imageUrl = e.target.result;
			node.style.backgroundImage = `url('${imageUrl}')`;;
		};
		reader.readAsDataURL(file);
			
		fileListEL.appendChild(node);
	};

	imgAddEL.addEventListener('click', () => {
		inputEL.click();
	});
		
	inputEL.addEventListener('change', e => {
		if(! e.target.files || ! e.target.files.length) {
			fileTransfer();
			return;
		}
			
		for(let f of e.target.files) {
			if(! f.type.match('image.*')) {
				continue;
			}

			if(fileSize + f.size >= maxFileSize) {
				return;
			}			
			fileSize += f.size;
						
			imageLoader(f);
		}

		fileTransfer();		
	});
		
	fileListEL.addEventListener('click', e => {
		if(e.target.matches('.image-item')) {
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
				
			let filename = e.target.getAttribute('data-filename');
				
			for(let i = 0; i < sel_files.length; i++) {
				if(filename === sel_files[i].name) {
					fileSize -= sel_files[i].size;
					
					sel_files.splice(i, 1);
					break;
				}
			}
			
			fileTransfer();

			e.target.remove();
		}
	});
	
	// 드래그 & 드롬
	imgAddEL.addEventListener('dragenter', e => {
		e.preventDefault();
		e.stopPropagation();
	});

	imgAddEL.addEventListener('dragover', e => {
		e.preventDefault();
		e.stopPropagation();
	});
	
	imgAddEL.addEventListener('drop', e => { 
		let files = [];
		e.preventDefault();
		e.stopPropagation();
		
		let dt = e.dataTransfer;
		files = dt.files;
		for(let f of files) {
			if(! f.type.match('image.*')) {
				continue;
			}
			
			if(fileSize + f.size >= maxFileSize) {
				return;
			}			
			fileSize += f.size;
				
			imageLoader(f);
		}
		
		fileTransfer();
	});	
});

/* 일반 파일 업로드 */
window.addEventListener('DOMContentLoaded', () => {
	var sel_files = [];
	var fileSize = 0;
	const maxFileSize = 5 * 1024 * 1024;
			
	const fileListEL = document.querySelector('form .file-upload-panel .file-upload-list');
	if (! fileListEL) return false;
	
	const fileAddEL = document.querySelector('form .file-upload-panel .drag-area');
	const inputEL = document.querySelector('form .file-upload-panel input[type=file]');
	const sizeEL = document.querySelector('form .file-upload-panel .file-size');
	
	const fileTransfer = () => {
		let dt = new DataTransfer();

		for(let f of sel_files) {
			dt.items.add(f);
		}
			
		inputEL.files = dt.files;
		
		if(sizeEL) {
			fileSize = fileSize >= 0 ? fileSize : 0;
			let size = fileSize / (1024 * 1024);
			sizeEL.textContent = size.toFixed(2);
		}
	};

	const fileLoader = file => {
		sel_files.push(file);
			
		let node = document.createElement('div');
		node.classList.add('file-item');
		node.setAttribute('data-filename', file.name);

		let span;
		span = document.createElement('span');
		span.classList.add('file-name');
		span.appendChild(document.createTextNode(file.name));
		node.appendChild(span);

		span = document.createElement('span');
		span.innerHTML = '<i class="bi bi-trash3"></i>';
		node.appendChild(span);
		
		/*
		const reader = new FileReader();
		reader.onload = e => {
		};
		reader.readAsDataURL(file);
		*/
		
		fileListEL.appendChild(node);
	};

	fileAddEL.addEventListener('click', () => {
		inputEL.click();
	});
		
	inputEL.addEventListener('change', e => {
		if(! e.target.files || ! e.target.files.length) {
			fileTransfer();
			return;
		}
		
		for(let f of e.target.files) {
			if(fileSize + f.size >= maxFileSize) {
				return;
			}			
			fileSize += f.size;
					
			fileLoader(f);
		}
			
		fileTransfer();	
	});
		
	fileListEL.addEventListener('click', e => {
		if(e.target.matches('.file-item i')) {
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
			
			const child = e.target;
			const parent = child.parentElement;
			const grandparent = parent.parentElement;
			let filename = grandparent.getAttribute('data-filename');
				
			for(let i = 0; i < sel_files.length; i++) {
				if(filename === sel_files[i].name) {
					fileSize -= sel_files[i].size;
					
					sel_files.splice(i, 1);
					break;
				}
			}
			
			fileTransfer();

			grandparent.remove();
		}
	});
	
	// 드래그 & 드롬
	fileAddEL.addEventListener('dragenter', e => {
		e.preventDefault();
		e.stopPropagation();
	});

	fileAddEL.addEventListener('dragover', e => {
		e.preventDefault();
		e.stopPropagation();
	});
	
	fileAddEL.addEventListener('drop', e => { 
		let files = [];
		e.preventDefault();
		e.stopPropagation();
		
		let dt = e.dataTransfer;
		files = dt.files;
		for(let f of files) {
			if(fileSize + f.size >= maxFileSize) {
				return;
			}			
			fileSize += f.size;
						
			fileLoader(f);
		}
		
		fileTransfer();
	});	
});
