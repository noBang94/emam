package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;

import java.io.IOException;

@WebServlet("/admin/userDelete.do")
public class UserDelete extends HttpServlet {
    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String memId = request.getParameter("memId");
        int cnt = adminService.deleteMember(memId);

        if(cnt > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/userList.do");
        }
        else {
            request.setAttribute("errorMessage", "회원 삭제에 실패했습니다."); // 에러 메시지 저장
            request.getRequestDispatcher("/admin/userList.do").forward(request, response); // 목록 페이지로 포워딩
        }


    }
}
