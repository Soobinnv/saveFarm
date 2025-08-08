package com.sp.app.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.exception.StorageException;
import com.sp.app.exception.StorageFileNotFoundException;

import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class StorageServiceImpl implements StorageService {
	private final ServletContext servletContext;
	private final FileManager fileManager;

	
	/**
	* 웹 루트 경로의 실제 경로를 반환하는 메소드
	* @return 실제 웹 애플리케이션의 루트 경로
	*/
	public String getRootRealPath() {
        return servletContext.getRealPath("/");
	}

	/**
	* 웹 경로의 실제 경로를 반환하는 메소드
	* @return 실제 웹 애플리케이션의 경로
	*/
	public String getRealPath(String webPath) {
		if(webPath.indexOf("/") != 0) {
			webPath = "/" + webPath;
		}
		
		String realPath = servletContext.getRealPath(webPath);
		
        return realPath;
	}
	
	/**
	 * 파일 업로드
	 */
	@Override
	public String uploadFileToServer(MultipartFile multiFile, String directoryPath) {
		try {
			if(multiFile == null || multiFile.isEmpty()) {
				return null;
			}
			
			String originalFilename = multiFile.getOriginalFilename();
			if (originalFilename == null || originalFilename.isBlank()) {
				return null;
			}
			
			if(! fileManager.isDirectoryExist(directoryPath)) {
				fileManager.createAllDirectories(directoryPath);
			}
			
			// 확장자
			String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			// 서버에 저장할 새로운 파일명
			String saveFilename = fileManager.generateUniqueFileName(directoryPath, extension);
			
			Path location = Paths.get(directoryPath);
			
			// resolve() : 주어진 경로가 상대 경로인 경우, 이를 현재 경로를 기준으로 절대 경로로 변경
			// normalize() : 경로에서 .(현재 디렉토리) 또는 .. (상위 디렉토리)와 같은 특수한 요소들을 정리하여 경로를 정규화하는 역할
			// toAbsolutePath() : 경로를 절대 경로로 변환하는 데 사용
			Path destinationFile = location.resolve(Paths.get(saveFilename))
					.normalize()
					.toAbsolutePath();
			
			// 파일 업로드 후 바로 저장할 경우 매우 직관적이고 간단한 방법
			// multiFile.transferTo(destinationFile.toFile());
			
			// 파일 경로를 Path로 처리하거나 복사할 때 추가적인 옵션(예: 덮어쓰기, 스트림 처리)이 필요할 때 사용
			// 파일을 저장할 때 더 많은 제어가 필요하거나 복잡한 처리가 필요한 경우에 적합
			Files.copy(multiFile.getInputStream(), destinationFile);
			
	        return saveFilename;

		} catch (Exception e) {
			throw new StorageException("Failed to store file.", e);
		}
	}

	/**
	 * 파일 업로드
	 */
	@Override
	public String uploadFileToServer(InputStream inputStream, String originalFilename, String directoryPath) {
		try {
			if (originalFilename == null || originalFilename.isBlank()) {
				return null;
			}
			
			if(! fileManager.isDirectoryExist(directoryPath)) {
				fileManager.createAllDirectories(directoryPath);
			}
			
			// 확장자
			String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			// 서버에 저장할 새로운 파일명
			String saveFilename = fileManager.generateUniqueFileName(directoryPath, extension);
			
			Path location = Paths.get(directoryPath);
			Path destinationFile = location.resolve(saveFilename);
			
			// 파일 복사
	        Files.copy(inputStream, destinationFile);
			
	        return saveFilename;
	        
		} catch (Exception e) {
			throw new StorageException("Failed to store file.", e);
		}
	}
	
	/**
	 * 파일 다운로드
	 * @param directoryPath
	 * @param saveFilename
	 * @param originalFilename
	 * @return
	 */	
	@Override
	public ResponseEntity<?> downloadFile(String directoryPath, String saveFilename, String originalFilename) {
		String pathname = directoryPath + File.separator + saveFilename;
		
		if( ! fileManager.isFileExist(pathname) ) {
			throw new StorageFileNotFoundException("Could not read file : " + saveFilename);
		}
		
		try {
			File file = new File(pathname);
			byte[] fileContent = readFileToByteArray(file);
			
			originalFilename = new String(originalFilename.getBytes("utf-8"), "8859_1");
			// originalFilename = new String(originalFilename.getBytes("euc-kr"), "8859_1");
			
			HttpHeaders headers = new HttpHeaders();
			headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + originalFilename + "\"");
			headers.add(HttpHeaders.CONTENT_TYPE, "application/octet-stream");
			
			// 바이트 배열을 ByteArrayResource로 감싸서 ResponseEntity로 반환
			ByteArrayResource resource = new ByteArrayResource(fileContent);
			
			return ResponseEntity.ok()
					.headers(headers)
					.contentLength(file.length())
					.body(resource);			
		} catch (Exception e) {
			throw new StorageException("Unable to download : " + saveFilename, e);
		}
	}

	/**
	 * 파일을 byte 단위로 읽어들이는 메소드
	 * @param file
	 * @return
	 * @throws IOException
	 */
	protected byte[] readFileToByteArray(File file) throws IOException {
		try (InputStream inputStream = new FileInputStream(file)) {
			byte[] fileContent = new byte[(int) file.length()];
			inputStream.read(fileContent);
			return fileContent;
		}
	}

	/**
	 * ZIP 파일 다운로드
	 * @param sources
	 * @param originals
	 * @param zipFilename
	 * @return
	 */
	@Override
	public ResponseEntity<?> downloadZipFile(String[] sources, String[] originals, String zipFilename) {
		try {
			String directoryPath = System.getProperty("user.dir") + File.separator + "temp";
			
			String archiveFilename = fileManager.fileCompression(directoryPath, sources, originals);

			ResponseEntity<?> entity = downloadFile(directoryPath, archiveFilename, zipFilename);
			
			// 다운로드한 zip 파일 삭제
			deleteFile(directoryPath, archiveFilename);
			
			return entity;
			
		} catch (Exception e) {
			throw new StorageException("Zip file download not possible.", e);
		}
	}
	
	/**
	 * 파일 삭제
	 * @param pathString
	 * @return
	 */
	public boolean deleteFile(String pathString) {
		return fileManager.deletePath(pathString);
	}
	
	/**
	 * 파일 삭제
	 * @param uploadPath
	 * @param filename
	 * @return
	 */
	public boolean deleteFile(String directoryPath, String filename) {
		String pathString = directoryPath + File.separator + filename;
		return fileManager.deletePath(pathString);		
	}

	/**
	 * 디렉토리의 모든 파일 목록 반환. 하위 디렉토리는 제외
	 * @param directoryPath
	 * @return 
	 */
	@Override
	public List<String> listAllFiles(String directoryPath) {
		try {
			return fileManager.listAllFiles(directoryPath)
					.map(path -> path.getFileName().toString())
	            	.collect(Collectors.toList()
	            );
		} catch (Exception e) {
			throw new StorageException("Failed to read stored files", e);
		}
	}

}
