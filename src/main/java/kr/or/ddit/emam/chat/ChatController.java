package kr.or.ddit.emam.chat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.google.gson.Gson;
import kr.or.ddit.emam.vo.MemberVO;

@WebServlet({"/chat", "/chat/user"})
public class ChatController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/chat".equals(path)) {
            HttpSession session = request.getSession();
            MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

            if (loginMember == null) {
                response.sendRedirect(request.getContextPath() + "/member/loginMember.do");
                return;
            }

            request.getRequestDispatcher("/WEB-INF/view/chat/chat.jsp").forward(request, response);
        } else if ("/chat/user".equals(path)) {
            HttpSession session = request.getSession();
            MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

            if (loginMember == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            response.setContentType("application/json; charset=UTF-8"); // UTF-8 설정
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(loginMember));
        }
    }
}