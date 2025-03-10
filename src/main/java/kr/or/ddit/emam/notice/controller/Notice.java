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
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/notice/notice.do")
public class Notice extends HttpServlet {
    private INoticeService noticeService = NoticeServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String searchTitle = request.getParameter("searchTitle");

        try {
            List<NoticeVO> noticeList;
            if (searchTitle == null || searchTitle.trim().isEmpty()) {
                noticeList = noticeService.selectAllNotice(null); // 공지 전체 조회
            } else {
                Map<String, Object> params = new HashMap<>();
                params.put("searchTitle", searchTitle);
                noticeList = noticeService.searchTitle(params); // 제목 검색하여 조회
                if (noticeList == null || noticeList.isEmpty()) {
                    request.setAttribute("errorMessage", "검색 결과가 없습니다.");
                }
            }
            request.setAttribute("noticeList", noticeList);
        } catch (Exception e) {
            e.printStackTrace(); // (실제 운영 환경에서는 로깅 프레임워크 사용)
            request.setAttribute("errorMessage", "오류가 발생했습니다.");
        }
        request.getRequestDispatcher("/WEB-INF/view/notice/notice.jsp").forward(request, response);
    }
}