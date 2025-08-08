package com.sp.app.editor;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// Quill(퀼) text editor 이미지 업로드
@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/editor/*")
public class QuillEditorController {
	private final StorageService storageService;

	@PostMapping("upload")
	public Map<String, ?> handleImageUpload(@RequestParam(name = "imageFile") MultipartFile partFile, 
			HttpServletRequest req) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		// Quill(퀼) text editor
		
		String state = "true";
		try {
			String webPath = "/uploads/editor";
			String realPath = this.storageService.getRealPath(webPath);

			String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(partFile, realPath));
			
			String cp = req.getContextPath();
			String imageUrl = cp + webPath + "/" + saveFilename;
			
			model.put("state", state);
			model.put("saveFilename", saveFilename);
			model.put("imageUrl", imageUrl);
			
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}
}
