package kr.or.ddit.emam.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/nicknameCheck.do")
public class NicknameCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        String nickname = request.getParameter("nickname");
        IMemberService service = MemberServiceImpl.getInstance();
        boolean available = !service.getMemberNicknameCount(nickname);
        String message = available ? "사용 가능한 닉네임입니다." : "이미 존재하는 닉네임입니다.";

        String result = "{\"available\": " + available + ", \"message\": \"" + message + "\"}";

        PrintWriter out = response.getWriter();
        out.write(result);

        response.flushBuffer();
    }
}
