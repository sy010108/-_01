package com.kkn.www.community;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkn.www.comment.dto.CommentsLoadDto;
import com.kkn.www.community.dto.CommunityLoadDto;
import com.kkn.www.community.dto.CommunitySaveDto;
import com.kkn.www.entity.Community;
import com.kkn.www.repository.CommentsRepository;
import com.kkn.www.repository.CommunityRepository;

import jakarta.transaction.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Transactional
public class CommunityService {
	@Autowired
	CommunityRepository communityRepository;

	@Autowired
	CommentsRepository commentRepository;

	public List<CommunityLoadDto> communityHomeInformationLoadService(String loadTimestamp) {
		List<Community> communityList = communityRepository.findTop10ByWritedatetimeLessThanEqualOrderByWritedatetimeDesc(Timestamp.valueOf(loadTimestamp));

		List<CommunityLoadDto> communityLoadDtoList = this.commentsLoad(communityList.stream().map(CommunityLoadDto::toCommunityHomeDto).collect(Collectors.toList()));

		for (CommunityLoadDto dto : communityLoadDtoList) {
			Community community = communityRepository.findById(dto.getNum()).orElse(null);
			if (community != null) {
				dto.setImageURL(community.getImageurl());

				// Fetch all image filenames from the folder and convert to base64
				File folder = new File("C:/Temp/upload/" + community.getImageurl());
				if (folder.exists() && folder.isDirectory()) {
					File[] files = folder.listFiles();
					if (files != null) {
						List<String> imageBase64List = new ArrayList<>();
						for (File file : files) {
							String base64Image = convertImageToBase64(file);
							imageBase64List.add(base64Image);
						}
						dto.setImageBase64List(imageBase64List); // Set the list of base64 encoded images
					}
				}
			}
		}

		return communityLoadDtoList;
	}
	private String convertImageToBase64(File file) {
		try (FileInputStream fileInputStream = new FileInputStream(file)) {
			// Read the file into a byte array
			ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = fileInputStream.read(buffer)) != -1) {
				byteArrayOutputStream.write(buffer, 0, bytesRead);
			}

			byte[] fileBytes = byteArrayOutputStream.toByteArray();
			return Base64.getEncoder().encodeToString(fileBytes);
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
	}


	private List<CommunityLoadDto> commentsLoad(List<CommunityLoadDto> postList) {
		for (CommunityLoadDto post : postList) {
			post.setCommentslist(commentRepository.findTop2ByPostNumOrderByCommentwritetimestampDesc(post.getNum()).stream().map(CommentsLoadDto::toCommentsDto).collect(Collectors.toList()));
		}

		return postList;
	}

	public List<CommunityLoadDto> communityListAddService(String lastPostWriteTimeStamp) {
		List<Community> communityList = communityRepository.findTop10ByWritedatetimeLessThanOrderByWritedatetimeDesc(Timestamp.valueOf(lastPostWriteTimeStamp));

		return this.commentsLoad(communityList.stream().map(CommunityLoadDto::toCommunityHomeDto).collect(Collectors.toList()));
	}

	public void postSaveService(CommunitySaveDto communitySaveDto) {
		Community newPost = CommunitySaveDto.toCommunity(communitySaveDto);

		newPost.setWritedatetime(Timestamp.valueOf(LocalDateTime.now()));

		communityRepository.save(newPost);
	}

	public void postDeleteService(int postNum) {
		communityRepository.deleteById(postNum);
	}

	private static final String uploadPath = "C:/Temp/upload/";

	public String handleImageUpload(MultipartFile[] files, String userid) {
		System.out.println(userid);
		try {
			String randomFilename = userid + "_" + UUID.randomUUID().toString();

			String baseUploadPath = uploadPath;
			File uploadDir = new File(baseUploadPath + randomFilename);

			int count = 1;
			while (uploadDir.exists()) {
				randomFilename = userid + "_" + UUID.randomUUID().toString() + "_" + count;
				uploadDir = new File(baseUploadPath + randomFilename);
				count++;
			}

			uploadDir.mkdirs();

			String imageUrl = "";

			for (MultipartFile file : files) {
				String originalFileName = file.getOriginalFilename();
				String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String savedFileName = randomFilename + "/" + UUID.randomUUID().toString() + fileExtension;

				File localPath = new File(uploadPath + savedFileName);
				file.transferTo(localPath);

				if (imageUrl.isEmpty()) {
					imageUrl = savedFileName;
				}

				System.out.println("File received: " + originalFileName);
				System.out.println("File saved to: " + localPath.getAbsolutePath());
				System.out.println("Image URL saved in the database: " + savedFileName);
			}

			return randomFilename;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}

