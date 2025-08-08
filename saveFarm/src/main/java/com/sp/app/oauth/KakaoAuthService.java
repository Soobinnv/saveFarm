package com.sp.app.oauth;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KakaoAuthService {
	private final String REST_API_KEY = "카카오 - RESTAPIKEY";
	private final String TOKEN_URI = "https://kauth.kakao.com/oauth/token";
	private final String USER_INFO_URI = "https://kapi.kakao.com/v2/user/me";
	private final String REDIRECT_URI = "http://localhost:9090/oauth/kakao/callback";
	
	public String getAccessToken(String code) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", REST_API_KEY);
		params.add("redirect_uri", REDIRECT_URI);
		params.add("code", code);

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

		ResponseEntity<String> response = restTemplate.postForEntity(
				TOKEN_URI, request, String.class);		
		
	    try {
	    	ObjectMapper objectMapper = new ObjectMapper();
	    	JsonNode jsonNode = objectMapper.readTree(response.getBody());
	    	
	    	return jsonNode.get("access_token").asText();
	    } catch (Exception e) {
	        throw new RuntimeException("Access token 요청 실패", e);
	    }		
	}
	
	public KakaoUser getUserInfo(String accessToken) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(accessToken);
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		HttpEntity<?> request = new HttpEntity<>(headers);

	    try {
			ResponseEntity<String> response = restTemplate.exchange(
					USER_INFO_URI,
					HttpMethod.GET,
					request,
					String.class
			);
			
			if (response.getStatusCode() == HttpStatus.OK) {
				ObjectMapper objectMapper = new ObjectMapper();
		    	JsonNode jsonNode = objectMapper.readTree(response.getBody());

		    	// log.info("::" + response.getBody());
		    	
		    	Long id = jsonNode.get("id").asLong();
		    	String nickname = jsonNode.get("properties").get("nickname").asText();
		    	String email = "";
		    	if(jsonNode.get("kakao_account").get("email") != null) {
		    		email = jsonNode.get("kakao_account").get("email").asText();		    		
		    	}
		    	
		    	String is_email_verified = null;
		    	if(jsonNode.get("kakao_account").get("is_email_verified") != null) {
		    		is_email_verified = jsonNode.get("kakao_account").get("is_email_verified").asText();
		    	}
		    	
		    	boolean email_verified = false;
		    	if(is_email_verified != null) {
		    		email_verified = is_email_verified.equals("true");
		    	}

		    	KakaoUser user = KakaoUser.builder()
						.id(id)
						.nickname(nickname)
						.email(email)
						.email_verified(email_verified)
						.build();
		    	
		    	return user;
		    	
			} else {
				throw new RuntimeException("Unexpected status: " + response.getStatusCode());
			}
	    } catch (Exception e) {
	    	log.info("getUserInfo : ", e);
	    	throw new RuntimeException("사용자 정보 parsing 실패", e);
	    }	
	}

}
