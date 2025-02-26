package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;
import kr.or.ddit.emam.vo.AdminVO;
import com.google.gson.Gson; // Gson 라이브러리 추가

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/adminLogin.do")
public class LoginAdmin extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json"); // JSON 응답 설정
        response.setCharacterEncoding("utf-8");

        String adminId = request.getParameter("adminId");
        String adminPw = request.getParameter("adminPw");

        System.out.println(adminId + "," + adminPw);

        AdminVO adminVO = new AdminVO();
        adminVO.setAdmin_id(adminId);
        adminVO.setAdmin_pw(adminPw);

        IAdminService service = AdminServiceImpl.getInstance();

        AdminVO loginAdVo = service.getLoginAdmin(adminVO);
        System.out.println("amVo :" + loginAdVo);

        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        if (loginAdVo != null) {
            session.setAttribute("loginAdmin", loginAdVo);
            String json = gson.toJson(new Result("success"));
            out.print(json);
        } else {
            String json = gson.toJson(new Result("fail"));
            out.print(json);
        }
        out.flush();
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/admin/adminLogin.jsp").forward(request, response);
    }

    // JSON 응답을 위한 내부 클래스
    private static class Result {
        private String result;

        public Result(String result) {
            this.result = result;
        }

        public String getResult() {
            return result;
        }
    }
}