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

@WebServlet("/admin/qnaDetail.do")
public class QnaDetail extends HttpServlet {

    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int inquiryIndex = Integer.parseInt(request.getParameter("inquiryIndex"));
            InquiryVO inquiry = adminService.getInquiryDetail(inquiryIndex);

            if (inquiry != null) {
                request.setAttribute("inquiry", inquiry);
                request.getRequestDispatcher("/WEB-INF/view/admin/qnaDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "문의 상세 정보를 찾을 수 없습니다.");
                request.getRequestDispatcher("/WEB-INF/view/admin/qnaDetail.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "잘못된 문의 번호입니다.");
            request.getRequestDispatcher("/WEB-INF/view/admin/qnaDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로깅
            request.setAttribute("errorMessage", "문의 상세 정보 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/WEB-INF/view/admin/qnaDetail.jsp").forward(request, response);
        }
    }
}