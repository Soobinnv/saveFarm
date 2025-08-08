package com.sp.app.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;

import com.sp.app.exception.StorageException;

@Service
public class FileManager {
	/**
	 * 디렉토리 또는 파일 존재 여부
	 * @param pathString
	 * @return
	 */
	public boolean isPathExist(String pathString) {
		// Path 클래스
		//  : 파일 또는 디렉터리 경로를 나타내는 객체
		//  : Path 객체는 파일 시스템 경로를 표현하는 데 사용
		// Paths 클래스
		//  : Path 객체를 생성하기 위한 유틸리티 클래스
		Path path = Paths.get(pathString);
		return Files.exists(path);
	}
	
	/**
	 * 디렉토리 존재 여부
	 * @param directoryPath
	 * @return
	 */
	public boolean isDirectoryExist(String directoryPath) {
		Path path = Paths.get(directoryPath);
		return Files.exists(path) && Files.isDirectory(path);
	}
	
	/**
	 * 파일 존재 여부
	 * @param directoryPath
	 * @return
	 */
	public boolean isFileExist(String filePath) {
		Path path = Paths.get(filePath);
		return Files.exists(path) && Files.isRegularFile(path);
	}
	
	/**
	 * 지정된 경로의 모든 디렉토리 생성(상위 디렉토가 존재하지 않는 경우 상위 디렉토리도 생성)
	 * @param directoryPath
	 * @return
	 */
	public void createAllDirectories(String directoryPath) throws IOException {
		try {
			Path path = Paths.get(directoryPath);
			Files.createDirectories(path);
		} catch (IOException e) {
			throw e;
		}
	}
	
	/**
	 * 주어진 디렉토리 또는 파일을 삭제. 디렉토리일 경우 하위 디렉토리와 파일들을 재귀적으로 삭제
	 * @param pathString
	 * @return
	 */
	public boolean deletePath(String pathString) {
		Path path = Paths.get(pathString);

		try {
			FileSystemUtils.deleteRecursively(path);
			
			return true;
		} catch (IOException e) {
			return false;
		}
	}	

	/**
	 * 여러 파일을 ZIP 파일로 압축
	 * @param directoryPath	압축할 경로
	 * @param sources		압축할 파일 목록
	 * @param originals		압축할 파일들이 압축될 때의 파일명
	 * @return				압축된 파일 이름		
	 * @throws IOException
	 */
	public String fileCompression(String directoryPath, String[] sources, String[] originals) throws IOException {
		if(! isDirectoryExist(directoryPath)) {
			createAllDirectories(directoryPath);
		}

		// 압축 파일명
		String archiveFilename = generateUniqueFileName(directoryPath, ".zip");
		Path filePath = Paths.get(directoryPath);
		Path zipFile = filePath.resolve(archiveFilename);
		
		// ZIP 파일을 쓰기 위한 OutputStream
		String filename;
		try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFile.toFile()))) {
			for (int idx = 0; idx < sources.length; idx++) {
				Path file = Paths.get(sources[idx]);
				
				filename = file.getFileName().toString();
				if (originals != null && originals.length > idx) {
					filename = originals[idx];
				}
				
				if (filename.indexOf(File.separator) >= 0) {
					filename = filename.substring(filename.lastIndexOf(File.separator));
				}
				
				if (filename.indexOf(File.separator) == -1) {
					filename = File.separator + filename;
				}
				
                // 파일을 읽기 위한 InputStream
                try (FileInputStream fis = new FileInputStream(file.toFile())) {
                    // 각 파일을 ZIP에 추가
                    ZipEntry entry = new ZipEntry(filename);
                    zos.putNextEntry(entry);

                    // 파일 내용을 압축하여 출력 스트림에 저장
                    byte[] buffer = new byte[8192];
                    int length;
                    while ((length = fis.read(buffer)) >= 0) {
                        zos.write(buffer, 0, length);
                    }

                    // 압축이 완료된 후 엔트리 닫기
                    zos.closeEntry();
                }
			}
		}
		
		return archiveFilename;
	}
        
	/**
	 * 시스템 시간을 이용하여 고유한 파일 이름 생성
	 * @param directoryPath		파일을 저장할 디렉토리
	 * @param extension			확장자
	 * @return					생성된 파일명과 확장자
	 */
	public String generateUniqueFileName(String directoryPath, String extension) {
		String uniqueFileName = null;
		File file;

		synchronized (this) {
			long currentTimeMillis = System.currentTimeMillis();

			long nanoTime = System.nanoTime();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String formattedDate = sdf.format(new Date(currentTimeMillis));

			// 고유한 파일 이름 생성(현재 시간 + nanoTime + 확장자)
            uniqueFileName = formattedDate + nanoTime + extension;
            file = new File(directoryPath, uniqueFileName);

            // 파일이 이미 존재하면 다시 고유한 파일 이름을 생성
            while (file.exists()) {
            	nanoTime = System.nanoTime();  // nanoTime을 다시 업데이트하여 중복을 피함
            	uniqueFileName = formattedDate + nanoTime + extension;
            	file = new File(directoryPath, uniqueFileName);
            }
		}

		return uniqueFileName;
	}
	
	/**
	 * 동일한 파일이름이 있는 경우 파일명 뒤에(숫자)를 붙이고 "파일명(숫자)" 파일명이 존재하면 "파일명(숫자+1)" 로 작성 
	 * @param directoryPath	파일경로
	 * @param filename		파일이름
	 * @return				새로운 파일명
	 */	
	public String appendSuffixFilename(String directoryPath, String filename) {
		try {
			File file = new File(directoryPath, filename);
			
			if(file.exists()) {
				int dotIndex = filename.lastIndexOf('.');
				String baseName = dotIndex == -1 ? filename : filename.substring(0, dotIndex);
				String extension = dotIndex == -1 ? "" : filename.substring(dotIndex);;
				
				int count = 1;
				String newFileName;
				do {
					newFileName = baseName + "(" + count + ")" + extension;
					file = new File(directoryPath, newFileName);
					count++;
				} while(file.exists());
				
				return newFileName;
			}
			
		} catch (Exception e) {
			return null;
		}
		
		return filename;
	}
	
	/**
	 * 지정된 디렉토리에서 파일 목록을 스트림(Stream) 형태로 반환
	 * @param directoryPath 디렉토리
	 * @return
	 */
	public Stream<Path> listAllFiles(String directoryPath) {
		try {
			Path location = Paths.get(directoryPath);
			
			// Files.walk(Path start, int maxDepth) : 지정된 경로를 기준으로 디렉토리 트리를 탐색
			//   start : 탐색을 시작할 디렉토리
			//   maxDepth : 탐색 깊이. 1은 주어진 디렉토리에서 바로 아래의 파일/디렉토리까지만 탐색하도록 제한
			// .filter() : 탐색된 결과 중에서 특정 조건에 맞는 항목만 포함
            return Files.walk(location, 1)
                    .filter(Files::isRegularFile); // 디렉토리가 아닌 파일만 필터링	
			
		} catch (Exception e) {
			throw new StorageException("Failed to read stored files", e);
		}
	}
	
}
