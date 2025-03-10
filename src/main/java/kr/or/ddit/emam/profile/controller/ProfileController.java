package kr.or.ddit.emam.profile.controller;

import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.vo.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/profile/profile.do")
public class ProfileController extends HttpServlet {

    private static ProfileController instance;
    private IProfileService profileService;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        /// 가죠옴 - postphoto, postphotosn 파라미터 처리 (현재 친구 목록 기능과는 무관)
        long postPhoto = request.getParameter("postphoto") == null ?
                -1 : Long.parseLong(request.getParameter("postphoto"));
        int postPhotoSn = request.getParameter("postphotosn") == null ?
                1 : Integer.parseInt(request.getParameter("postphotosn"));
        /// 가죠옴 - postphoto, postphotosn 파라미터 처리 (현재 친구 목록 기능과는 무관)


        String uri = request.getRequestURI();
        HttpSession session = request.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) { // 로그인 되어있지 않으면 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "http://localhost:8080/");
            return;
        }

        String memId = loginMember.getMem_id(); // 기본적으로 로그인한 사용자 ID 사용
        String memIdParam = request.getParameter("memId");

        boolean isMyProfile = true; //
        if (memIdParam != null && !memIdParam.isEmpty() && !memIdParam.equals(memId)) {
            memId = memIdParam; // 친구 프로필 memId 설정 (파라미터 값 사용)
            isMyProfile = false; // 친구 프로필로 변경
        }

        boolean isFriend = false; // 기본값: 친구 아님
        if (!isMyProfile) { // 친구 프로필 페이지에서만 친구 여부 확인
            IProfileService profileService = ProfileServiceImpl.getInstance();
            isFriend = profileService.isFriend (loginMember.getMem_id(), memId); // ⭐ Service 메서드 호출 ⭐
        }

        IProfileService profileService = ProfileServiceImpl.getInstance();
        ProfileVO pv = profileService.selectProfile(memId);
        ProfileVO profileVO = profileService.getProfile(memId);
        List<PostVO> postList = profileService.getPostList(memId);
        List<MemberVO> friendList = profileService.getFriend(memId);

        request.setAttribute("isFriend", isFriend);
        request.setAttribute("memberVO", loginMember);
        request.setAttribute("pv", pv);
        request.setAttribute("mv", pv); // mv 도 pv 로 설정 (ProfileVO 타입)
        request.setAttribute("isMyProfile", isMyProfile);
        request.setAttribute("profileVO", profileVO);
        request.setAttribute("postList", postList);
        request.setAttribute("friendList", friendList);

        String viewPage = "/WEB-INF/view/profile/profile.jsp"; // JSP 페이지 경로 설정 (기존 코드 유지)

        // 로그인한 회원과 상대 회원에 대하여 친구상태 구하여 목록 만들기(status값이 null이면 상호작용 없음, 0이면 신청중, 1이면 친구)
        IFriendService friendService = FriendServiceImpl.getInstance();
        FriendVO friendVo = new FriendVO();
        String friendStatus = "";
        friendVo.setFriend_fromid(loginMember.getMem_id());
        friendVo.setFriend_toid(memId);
        if(friendService.checkFriend(friendVo)==0){
            friendStatus = "null";
        }else if(friendService.statusFriend(friendVo)==0){
            friendStatus = "0";
        }else {
            friendStatus = "1";
        }
        request.setAttribute("friendStatus", friendStatus);

        request.getRequestDispatcher(viewPage).forward(request, response); // JSP 페이지로 forward (기존 코드 유지)
    }
}