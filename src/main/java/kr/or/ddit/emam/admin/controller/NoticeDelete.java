package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;

import java.io.IOException;

@WebServlet("/admin/noticeDelete.do")
public class NoticeDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String noticeIndex = request.getParameter("noticeIndex");

        try {
            int temp = Integer.parseInt(noticeIndex);
            int result = adminService.deleteNotice(temp);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/noticeList.do");
            } else {
                response.getWriter().write("공지사항 삭제에 실패했습니다.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("잘못된 공지사항 인덱스입니다.");
        }
    }
}