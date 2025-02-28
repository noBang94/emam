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

@WebServlet("/admin/qnaComment.do")
public class QnaComment extends HttpServlet {

    private IAdminService adminService = AdminServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int inquiryIndex = Integer.parseInt(request.getParameter("inquiryIndex"));
            String commentContent = request.getParameter("commentContent");

            InquiryVO inquiry = new InquiryVO();
            inquiry.setInquiry_index(inquiryIndex);
            inquiry.setInquiry_comment(commentContent); // 댓글 내용을 inquiryComment 필드에 설정

            int result = adminService.updateInquiryComment(inquiry);

            if (result > 0) {
                // 댓글 등록 성공 시 문의 상세 페이지로 리다이렉트
                response.sendRedirect(request.getContextPath() + "/admin/qnaDetail.do?inquiryIndex=" + inquiryIndex);
            } else {
                // 댓글 등록 실패 시 에러 메시지 설정 후 문의 상세 페이지로 포워딩
                request.setAttribute("errorMessage", "댓글 등록에 실패했습니다.");
                request.getRequestDispatcher("/admin/qnaDetail.do?inquiryIndex=" + inquiryIndex).forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "잘못된 문의 번호입니다.");
            request.getRequestDispatcher("/admin/qnaDetail.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로깅
            request.setAttribute("errorMessage", "댓글 등록 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/admin/qnaDetail.do").forward(request, response);
        }
    }
}