package kr.or.ddit.emam.usersettings.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.usersettings.service.IUsersettingsService;
import kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.UsersettingsVO;

import java.io.IOException;

@WebServlet("/usersettings/usersettings.do")
public class Usersettings extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        //회원정보 값 받아오기
        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");

        //전체 토글박스 값 받아오기
        String friendcoti = request.getParameter("friendnoti");
        int set_friend = (friendcoti == null) ? 0 : 1;
        String ilikenoti = request.getParameter("ilikenoti");
        int set_ilike = (ilikenoti == null) ? 0 : 1;
        String replynoti = request.getParameter("replynoti");
        int set_reply = (replynoti == null) ? 0 : 1;
        String chatnoti = request.getParameter("chatnoti");
        int set_chat = (chatnoti == null) ? 0 : 1;

        UsersettingsVO usersettingsVo = new UsersettingsVO();
        usersettingsVo.setMem_id(loginMemberVo.getMem_id());
        usersettingsVo.setSet_friend(set_friend);
        usersettingsVo.setSet_ilike(set_ilike);
        usersettingsVo.setSet_reply(set_reply);
        usersettingsVo.setSet_chat(set_chat);

        IUsersettingsService usersettingsService = UsersettingsServiceImpl.getInstance();
        usersettingsService.updateUsersettings(usersettingsVo);

    }
}
