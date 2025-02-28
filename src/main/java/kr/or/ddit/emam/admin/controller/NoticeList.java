package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;
import kr.or.ddit.emam.vo.NoticeVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/noticeList.do")
public class NoticeList extends HttpServlet {
    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        try {
            List<NoticeVO> noticeList = adminService.selectAllNotice(null);
            request.setAttribute("noticeList", noticeList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/WEB-INF/view/admin/noticeList.jsp").forward(request, response);
    }
}