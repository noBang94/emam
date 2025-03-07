package kr.or.ddit.emam.profile.controller;

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

@WebServlet("/profile/profile.do")
public class ProfileController extends HttpServlet {

    private static ProfileController instance;
    private IProfileService profileService;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String uri = request.getRequestURI();
        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");

        String memId = memberVO.getMem_id();

        IProfileService profileService = ProfileServiceImpl.getInstance();
        ProfileVO pv = profileService.selectProfile(memId);





        if (memberVO == null) {
            response.sendRedirect(request.getContextPath() + "http://localhost:8080/");
            return;
        }
        request.setAttribute("memberVO", memberVO);

        request.setAttribute("pv", pv);
        request.setAttribute("mv", memberVO);

        ProfileVO profileVO = profileService.getProfile(memId);
        List<PostVO> postList = profileService.getPostList(memId);

        request.setAttribute("profileVO", profileVO);
        request.setAttribute("postList", postList);

        String viewPage = "/WEB-INF/view/profile/profile.jsp";
        request.getRequestDispatcher(viewPage).forward(request, response);
    }


}