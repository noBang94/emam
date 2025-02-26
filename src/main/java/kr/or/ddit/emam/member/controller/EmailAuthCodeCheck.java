package kr.or.ddit.emam.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

@WebServlet("/member/emailAuthCodeCheck.do")
public class EmailAuthCodeCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String authCode = request.getParameter("authCode");

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String sessionAuthCode = null;
        String sessionKey = null;

        // 세션에서 해당 이메일에 대한 인증 코드 찾기
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            if (attributeName.endsWith("_" + email) && attributeName.startsWith("authCode_")) {
                sessionAuthCode = (String) session.getAttribute(attributeName);
                sessionKey = attributeName;
                break;
            }
        }

        if (authCode == null || authCode.trim().isEmpty() || sessionAuthCode == null || !(sessionAuthCode.equals(authCode))) {
            out.print("{\"success\": false}");
        } else {
            out.print("{\"success\": true}");
            if(sessionKey != null) {
                session.removeAttribute(sessionKey);
            }
        }
        out.flush();
        out.close();
    }
}
