package com.sp.app.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import lombok.extern.slf4j.Slf4j;

/*
  - @ControllerAdvice
    : 예외를 catch 해서 처리
    : 일반적인 웹 애플리케이션에서 사용되는 예외 처리 및 공통 기능을 제공
    : 주로 뷰 리졸버를 사용하는 @Controller와 함께 사용
*/

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(MissingServletRequestParameterException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST) // 400
	public ModelAndView handleMissingParams(MissingServletRequestParameterException ex) {
		// 파라미터의 개수가 다른 경우
		
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "잘못된 요청입니다.";
		String errorMessage = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);
		
		log.info("BAD_REQUEST - ", ex);
		
		return mav;
	}

	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST) // 400
	public ModelAndView handleArgumentTypeMismatch(MethodArgumentTypeMismatchException ex) {
		// 파리미터의 타입이 다른 경우
		
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "잘못된 요청입니다.";
		String errorMessage = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("BAD_REQUEST - ", ex);
		
		return mav;
	}
	
	@ExceptionHandler(NoResourceFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND) // 404
	public ModelAndView handleResourceNotFound(NoResourceFoundException ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "페이지를 찾을 수 없습니다.";
		String errorMessage = "죄송합니다.<br> <strong>404 - 요청하신 페이지가 존재하지 않습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("NOT_FOUND - ", ex);
		
		return mav;
	}

	@ExceptionHandler(MaxUploadSizeExceededException.class)
	public ModelAndView handleMaxUploadSizeExceededException(MaxUploadSizeExceededException ex) {
		// 파일 업로드 용량을 초과한 경우
		return new ModelAndView("error/uploadFailure");
	}
	
	@ExceptionHandler(Exception.class)
	// @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) // 500
	public ModelAndView handleServerError(Exception ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "시스템 오류.";
		String errorMessage = "죄송합니다.<br> <strong>요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("INTERNAL_SERVER_ERROR 등 - ", ex);
		
		return mav;
	}
}
