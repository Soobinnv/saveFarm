package com.sp.app.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.common.StorageService;
import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;
import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {
	private final MemberMapper mapper;
	private final StorageService storageService;
	private final MailSender mailSender;

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = null;

		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			log.info("loginMember : ", e);
		}

		return dto;
	}

	@Override
	public Member loginSnsMember(Map<String, Object> map) {
		Member dto = null;

		try {
			dto = mapper.loginSnsMember(map);
		} catch (Exception e) {
			log.info("loginSnsMember : ", e);
		}

		return dto;
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void insertMember(Member dto, String uploadPath) throws Exception {
		try {
			if (!dto.getSelectFile().isEmpty()) {
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setProfilePhoto(saveFilename);
			}

			mapper.insertMember12(dto);

		} catch (Exception e) {
			log.info("insertMember : ", e);

			throw e;
		}
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void insertSnsMember(Member dto) throws Exception {
		try {
			Long seq = mapper.memberSeq();
			dto.setMemberId(seq);

			mapper.insertSnsMember(dto);
		} catch (Exception e) {
			log.info("insertSnsMember : ", e);
			throw e;
		}
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void updateLastLogin(Long member_id) throws Exception {
		try {
			mapper.updateLastLogin(member_id);
		} catch (Exception e) {
			log.info("updateLastLogin : ", e);

			throw e;
		}
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void updateMember(Member dto, String uploadPath) throws Exception {
		try {
			// 업로드한 파일이 존재한 경우
			if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
				if (!dto.getProfilePhoto().isBlank()) {
					storageService.deleteFile(uploadPath, dto.getProfilePhoto());
				}

				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setProfilePhoto(saveFilename);
			}

			mapper.updateMember1(dto);
			mapper.updateMember2(dto);
		} catch (Exception e) {
			log.info("updateMember : ", e);

			throw e;
		}
	}

	@Override
	public Member findById(Long member_id) {
		Member dto = null;

		try {
			// 객체 = Objects.requireNonNull(객체)
			// : 파라미터로 입력된 값이 null 이면 NullPointerException을 발생하고,
			// 그렇지 않다면 입력값을 그대로 반환
			dto = Objects.requireNonNull(mapper.findById(member_id));

		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public Member findById(String login_id) {
		Member dto = null;

		try {
			// 객체 = Objects.requireNonNull(객체)
			// : 파라미터로 입력된 값이 null 이면 NullPointerException을 발생하고,
			// 그렇지 않다면 입력값을 그대로 반환
			dto = Objects.requireNonNull(mapper.findByLoginId(login_id));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void deleteMember(Map<String, Object> map, String uploadPath) throws Exception {
		try {
			map.put("userLevel", 0);
			map.put("enabled", 0);
			mapper.updateMemberLevel(map);
			mapper.updateMemberEnabled(map);

			String filename = (String) map.get("filename");
			if (filename != null && !filename.isBlank()) {
				storageService.deleteFile(uploadPath, filename);
			}

			mapper.deleteMember2(map);
			// mapper.deleteMember1(map);
		} catch (Exception e) {
			log.info("deleteMember : ", e);

			throw e;
		}

	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map, String uploadPath) throws Exception {
		// 프로파일 포토 삭제
		try {
			String filename = (String) map.get("filename");
			if (filename != null && !filename.isBlank()) {
				storageService.deleteFile(uploadPath, filename);
			}

			mapper.deleteProfilePhoto(map);
		} catch (Exception e) {
			log.info("deleteProfilePhoto : ", e);

			throw e;
		}
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// 10 자리 임시 패스워드 생성

		String lowercase = "abcdefghijklmnopqrstuvwxyz";
		String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String digits = "0123456789";
		String special_characters = "!#@$%^&*()-_=+[]{}?";
		String all_characters = lowercase + digits + uppercase + special_characters;

		try {
			// 암호화적으로 안전한 난수 생성(예측 불가 난수 생성)
			SecureRandom random = new SecureRandom();

			StringBuilder sb = new StringBuilder();

			// 각 문자는 최소 하나 이상 포함
			sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
			sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
			sb.append(digits.charAt(random.nextInt(digits.length())));
			sb.append(special_characters.charAt(random.nextInt(special_characters.length())));

			for (int i = sb.length(); i < 10; i++) {
				int index = random.nextInt(all_characters.length());

				sb.append(all_characters.charAt(index));
			}

			// 문자 섞기
			StringBuilder password = new StringBuilder();
			while (sb.length() > 0) {
				int index = random.nextInt(sb.length());
				password.append(sb.charAt(index));
				sb.deleteCharAt(index);
			}

			String result;
			result = dto.getName() + "님의 새로 발급된 임시 패스워드는 <b> " + password.toString() + " </b> 입니다.<br>"
					+ "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";

			Mail mail = new Mail();
			mail.setReceiverEmail(dto.getEmail());

			mail.setSenderEmail("soobinsteez@gmail.com");
			mail.setSenderName("관리자");
			mail.setSubject("임시 패스워드 발급");
			mail.setContent(result);

			// 테이블의 패스워드 변경
			dto.setPassword(password.toString());
			mapper.updateMember1(dto);

			// 메일 전송
			boolean b = mailSender.mailSend(mail);

			if (!b) {
				throw new Exception("이메일 전송중 오류가 발생했습니다.");
			}

		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Member> listFindMember(Map<String, Object> map) {
		List<Member> list = null;

		try {
			list = mapper.listFindMember(map);
		} catch (Exception e) {
			log.info("listFindMember : ", e);
		}

		return list;
	}
}
