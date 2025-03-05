package kr.or.ddit.emam.profile.controller;

import kr.or.ddit.emam.profile.dao.IProfileDao;
import kr.or.ddit.emam.profile.dao.ProfileDaoImpl;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/profile.do"})
public class ProfileController extends HttpServlet {

    private static ProfileController instance;
    private IProfileService profileService;

    public ProfileController() { // <-- 생성자에서 초기화
        profileService = ProfileServiceImpl.getInstance();
        IProfileDao profileDao = ProfileDaoImpl.getInstance();
        ((ProfileServiceImpl) profileService).setProfileDao(profileDao);
        System.out.println("ProfileController: 생성자 호출 및 ProfileServiceImpl, ProfileDaoImpl 싱글톤 획득 및 의존성 주입 완료");
    }

    public static ProfileController getInstance() {
        if (instance == null) {
            instance = new ProfileController();
        }
        return instance;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        if (uri.endsWith("/profile.do")) {
            profileView(request, response);
        }
    }

    private void profileView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memId = request.getParameter("memId");

        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");

        if (memberVO == null) {
            response.sendRedirect(request.getContextPath() + "http://localhost:8080/");
            return;
        }
        request.setAttribute("memberVO", memberVO);

        ProfileVO profileVO = profileService.getProfile(memId);
        List<PostVO> postList = profileService.getPostList(memId);

        request.setAttribute("profileVO", profileVO);
        request.setAttribute("postList", postList);

        String viewPage = "/WEB-INF/view/profile/profile.jsp";
        request.getRequestDispatcher(viewPage).forward(request, response);
    }
}