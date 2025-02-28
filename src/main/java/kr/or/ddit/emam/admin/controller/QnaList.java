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

@WebServlet("/admin/qnaList.do") // URL 매핑 수정
public class QnaList extends HttpServlet {

    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<InquiryVO> inquiryList = adminService.getInquiryList(); // 파라미터 제거

            // 디버깅 코드 (필요 시 로깅 프레임워크 사용)
            System.out.println("inquiryList size: " + inquiryList.size());
            for (InquiryVO inquiry : inquiryList) {
                System.out.println(inquiry);
            }

            request.setAttribute("inquiryList", inquiryList); // 속성 이름 수정
            request.getRequestDispatcher("/WEB-INF/view/admin/adminQna.jsp").forward(request, response); // JSP 파일 이름 수정
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로깅
            request.setAttribute("errorMessage", "문의 목록 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/WEB-INF/view/admin/adminQna.jsp").forward(request, response);
        }
    }
}