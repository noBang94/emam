package kr.or.ddit.emam.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/member/logoutMember.do")
public class LogoutMember extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        //Session객체 생성 session값을 얻어온다
        HttpSession  session = request.getSession();

        session.invalidate();	// 세션 삭제

        response.sendRedirect(request.getContextPath() + "/board/boardList.do");

    }

}
