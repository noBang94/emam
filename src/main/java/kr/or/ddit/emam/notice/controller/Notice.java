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
import java.util.List;

@WebServlet("/notice/notice.do")
public class Notice extends HttpServlet {
    private INoticeService noticeService = NoticeServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String searchTitle = request.getParameter("searchTitle");

        try {
            if(searchTitle == null || searchTitle.equals("")) {
                List<NoticeVO> noticeList = noticeService.selectAllNotice(null);     // 공지 전체 조회
                request.setAttribute("noticeList", noticeList);
            } else {
                List<NoticeVO> noticeList = noticeService.searchTitle(searchTitle);          // 제목 검색하여 조회
                request.setAttribute("noticeList", noticeList);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/WEB-INF/view/notice/notice.jsp").forward(request, response);
    }
}