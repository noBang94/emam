package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;
import kr.or.ddit.emam.vo.InquiryVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/qnaList.do")
public class QnaList extends HttpServlet {

    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String searchTitle = request.getParameter("searchTitle"); // 검색어 파라미터 가져오기

            List<InquiryVO> inquiryList;
            if (searchTitle != null && !searchTitle.isEmpty()) {
                // 검색어가 있는 경우, 검색 결과를 가져옴
                inquiryList = adminService.searchInquiryList(searchTitle);
            } else {
                // 검색어가 없는 경우, 전체 목록을 가져옴
                inquiryList = adminService.getInquiryList();
            }

            // 디버깅 코드 (필요 시 로깅 프레임워크 사용)
            System.out.println("inquiryList size: " + inquiryList.size());
            for (InquiryVO inquiry : inquiryList) {
                System.out.println(inquiry);
            }

            request.setAttribute("inquiryList", inquiryList);
            request.getRequestDispatcher("/WEB-INF/view/admin/adminQna.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로깅
            request.setAttribute("errorMessage", "문의 목록 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/WEB-INF/view/admin/adminQna.jsp").forward(request, response);
        }
    }
}