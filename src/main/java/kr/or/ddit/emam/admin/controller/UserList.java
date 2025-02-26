package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/userList.do")
public class UserList extends HttpServlet {

    private IAdminService adminService = AdminServiceImpl.getInstance();
    private static final int PAGE_SIZE = 10; // 페이지 크기를 상수로 정의

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchId = request.getParameter("searchId");
        int page = 1; // 기본 페이지 번호

        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            int totalCount = adminService.getTotalMemberCount(searchId);
            int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

            MemberVO memberVo = null;
            if (searchId != null && !searchId.isEmpty()) {
                memberVo = new MemberVO();
                memberVo.setMem_id(searchId);
            }

            List<MemberVO> memberList = adminService.getMemberList(memberVo, page, PAGE_SIZE);

            request.setAttribute("memberList", memberList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchId", searchId);

            request.getRequestDispatcher("/WEB-INF/view/admin/adminUser.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            handleException(request, response, "잘못된 페이지 번호입니다.", searchId, page);
        } catch (Exception e) {
            handleException(request, response, "오류가 발생했습니다.", searchId, page);
        }
    }

    private void handleException(HttpServletRequest request, HttpServletResponse response, String errorMessage, String searchId, int page) throws ServletException, IOException {
        request.setAttribute("errorMessage", errorMessage);
        int totalCount = adminService.getTotalMemberCount(searchId);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        MemberVO memberVo = null;
        if (searchId != null && !searchId.isEmpty()) {
            memberVo = new MemberVO();
            memberVo.setMem_id(searchId);
        }
        List<MemberVO> memberList = adminService.getMemberList(memberVo, page, PAGE_SIZE);
        request.setAttribute("memberList", memberList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchId", searchId);
        request.getRequestDispatcher("/WEB-INF/view/admin/adminUser.jsp").forward(request, response);
    }
}