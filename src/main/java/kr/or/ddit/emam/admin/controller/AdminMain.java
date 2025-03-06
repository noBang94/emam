package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;

import java.io.IOException;

@WebServlet("/admin/adminMain.do")
public class AdminMain extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        IAdminService service = AdminServiceImpl.getInstance();

        // 대시보드 데이터 가져오기
        int totalUsers = service.getTotalMemberCount(null); // 총 회원 수
        int totalPosts = service.getTotalPosts(); // 총 게시글 수
        int totalReports = service.getTotalReports(); // 총 신고 수
        int totalQnas = service.getInquiryList().size(); // 총 문의 수
        int unprocessedReports = service.getUnprocessedReportsCount();
        int unprocessedInquiries = service.getUnprocessedInquiriesCount();

        int newMembers = service.getNewMembersCount();
        int newPosts = service.getNewPostsCount();
        int newReports = service.getNewReportsCount();
        int newInquiries = service.getNewInquiriesCount();

        // 요청 속성에 데이터 저장
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("totalReports", totalReports);
        request.setAttribute("totalQnas", totalQnas);
        request.setAttribute("unprocessedReports", unprocessedReports);
        request.setAttribute("unprocessedInquiries", unprocessedInquiries);

        request.setAttribute("newMembers", newMembers);
        request.setAttribute("newPosts", newPosts);
        request.setAttribute("newReports", newReports);
        request.setAttribute("newInquiries", newInquiries);


        request.getRequestDispatcher("/WEB-INF/view/admin/adminMain.jsp").forward(request, response);
    }
}