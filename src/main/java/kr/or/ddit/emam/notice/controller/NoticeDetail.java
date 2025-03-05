package kr.or.ddit.emam.notice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.notice.service.INoticeService;
import kr.or.ddit.emam.notice.service.NoticeServiceImpl;
import kr.or.ddit.emam.vo.NoticeVO;

import java.io.IOException;

@WebServlet("/notice/noticeDetail.do")
public class NoticeDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        NoticeVO noticeVO = null;
        String getNotice = request.getParameter("noticeIndex");
        INoticeService noticeService = NoticeServiceImpl.getInstance();
        int noticeIndex = Integer.parseInt(getNotice);

        noticeVO = noticeService.getNotice(noticeIndex);

        System.out.println(noticeVO);

        if(noticeVO == null) {
            response.getWriter().write("null");
        } else {
            request.setAttribute("noticeVO", noticeVO);
            request.getRequestDispatcher("/WEB-INF/view/notice/noticeDetail.jsp").forward(request, response);
        }
    }
}
