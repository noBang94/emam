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
import java.util.Date;

@WebServlet("/admin/noticeUpdate.do")
public class NoticeUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String getNotice = request.getParameter("noticeIndex");

        if(getNotice != null && !(getNotice.isEmpty())) {
            int noticeIndex = Integer.parseInt(getNotice);

            IAdminService adminService = AdminServiceImpl.getInstance();

            NoticeVO noticeVO = adminService.getNotice(noticeIndex);

            request.setAttribute("noticeVO", noticeVO);
            request.setAttribute("mode", "update"); // 수정 모드 설정
            request.getRequestDispatcher("/WEB-INF/view/admin/noticeCreate.jsp").forward(request, response);
        } else {
            request.setAttribute("mode","insert");
            request.getRequestDispatcher("/WEB-INF/view/admin/noticeCreate.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String mode = request.getParameter("mode");

        String noticeTitle = request.getParameter("noticeTitle");
        String noticeCon = request.getParameter("noticeCon");

        NoticeVO noticeVO = new NoticeVO();
        noticeVO.setNotice_title(noticeTitle);
        noticeVO.setNotice_con(noticeCon);

        IAdminService adminService = AdminServiceImpl.getInstance();
        int result;

        if("update".equals(mode)) {
            int noticeIndex = Integer.parseInt(request.getParameter("noticeIndex"));
            noticeVO.setNotice_index(noticeIndex);
            result = adminService.updateNotice(noticeVO);
        } else {
            noticeVO.setNotice_date(String.valueOf(new Date()));
            result = adminService.insertNotice(noticeVO);
        }

        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/noticeList.do");
        } else {
            response.getWriter().write("공지사항을 처리할 수 없습니다.");
        }
    }
}
