// EditProfile.java
package kr.or.ddit.emam.profile.controller;

import jakarta.servlet.annotation.MultipartConfig;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.ProfileVO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part; // Part import 추가
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/profile/editProfile.do")
@MultipartConfig // MultipartConfig 어노테이션 확인 (이미 있다면 유지)
public class EditProfile extends HttpServlet {

    private IProfileService profileService = ProfileServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");

        if (memberVO == null) {
            response.sendRedirect(request.getContextPath() + "/"); // 로그인 페이지로 리다이렉트
            return;
        }

        String memId = memberVO.getMem_id();
        ProfileVO profileVO = profileService.selectProfile(memId);

        request.setAttribute("profileVO", profileVO);
        request.getRequestDispatcher("/WEB-INF/view/profile/profileEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");

        if (memberVO == null) {
            response.sendRedirect(request.getContextPath() + "/"); // 로그인 페이지로 리다이렉트
            return;
        }

        String memId = memberVO.getMem_id();
        String profileIntro = request.getParameter("profileIntro"); // request.getParameter() 로 텍스트 폼 필드 값 획득
        String profileUrl = request.getParameter("profileUrl");     // request.getParameter() 로 텍스트 폼 필드 값 획득
        String profilePhoto = null;
        String profileHeaderPhoto = null;

        // **수정된 파일 저장 경로: "C:/Users/PC-07/Desktop/emam/src/main/webapp/upload"**
        String uploadDir = "D:/emam/src/main/webapp/upload";
        File uploadPath = new File(uploadDir);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }


        // 프로필 사진 Part 처리
        Part profilePhotoPart = request.getPart("profilePhoto"); // request.getPart() 로 Part 객체 획득
        if (profilePhotoPart != null && profilePhotoPart.getSize() > 0) { // Part 객체가 null 이 아니고, 파일 크기가 0보다 큰 경우 (파일이 업로드된 경우)
            String fileName = getFileName(profilePhotoPart); // 파일 이름 추출 (getFileName 메소드 하단에 구현)
            String filePath = uploadDir + File.separator + fileName;
            try (InputStream fileContent = profilePhotoPart.getInputStream()) { // try-with-resources 구문 사용하여 InputStream 자동 close
                Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING); // Files.copy() 로 파일 저장 (StandardCopyOption.REPLACE_EXISTING: 덮어쓰기 옵션)
            }
            profilePhoto = "upload/" + fileName; // DB 저장을 위한 상대 경로 설정 (웹 접근 경로)
        }

        // 배경 사진 Part 처리 (프로필 사진 Part 처리와 유사)
        Part profileHeaderPhotoPart = request.getPart("profileHeaderPhoto"); // request.getPart() 로 Part 객체 획득
        if (profileHeaderPhotoPart != null && profileHeaderPhotoPart.getSize() > 0) { // Part 객체가 null 이 아니고, 파일 크기가 0보다 큰 경우 (파일이 업로드된 경우)
            String fileName = getFileName(profileHeaderPhotoPart); // 파일 이름 추출 (getFileName 메소드 하단에 구현)
            String filePath = uploadDir + File.separator + fileName;
            try (InputStream fileContent = profileHeaderPhotoPart.getInputStream()) { // try-with-resources 구문 사용하여 InputStream 자동 close
                Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING); // Files.copy() 로 파일 저장 (StandardCopyOption.REPLACE_EXISTING: 덮어쓰기 옵션)
            }
            profileHeaderPhoto = "upload/" + fileName; // DB 저장을 위한 상대 경로 설정 (웹 접근 경로)
        }


        ProfileVO profileVO = new ProfileVO();
        profileVO.setMem_id(memId);
        profileVO.setProfile_intro(profileIntro);
        profileVO.setProfile_url(profileUrl);
        profileVO.setProfile_photo(profilePhoto);
        profileVO.setProfile_headerphoto(profileHeaderPhoto);

        int result = profileService.updateProfile(profileVO);

        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/profile/profile.do");
        } else {
            request.setAttribute("errorMessage", "프로필 업데이트에 실패했습니다.");
            request.getRequestDispatcher("/WEB-INF/view/profile/profileEdit.jsp").forward(request, response);
        }
    }

    // Content-Disposition 헤더에서 파일 이름 추출하는 메소드
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf("=") + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}