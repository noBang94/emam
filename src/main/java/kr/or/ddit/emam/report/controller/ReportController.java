package kr.or.ddit.emam.report.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.ReportVO;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/report.do", "/initialReport.do"})
public class ReportController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        String requestURI = request.getRequestURI();
        String nickname = request.getParameter("nickname");


        IMemberService memberService = MemberServiceImpl.getInstance();
        MemberVO memVo = memberService.getMemberByNickname(nickname);
        request.setAttribute("memVo", memVo);

        if (requestURI.endsWith("/initialReport.do")) {
            request.getRequestDispatcher("/WEB-INF/view/report/initial_report.jsp").forward(request, response);
        } else if (requestURI.endsWith("/report.do")) {
            // 신고대상
            String toId = request.getParameter("toId");
            request.getRequestDispatcher("/WEB-INF/view/report/report.jsp").forward(request, response);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");
        response.setHeader("Content-Type", "application/json; charset=utf-8");

        try {
            String fromId = request.getParameter("fromId");
            if (fromId == null) {
                String nickname = request.getParameter("nickname");
                IMemberService memberService = MemberServiceImpl.getInstance();
                MemberVO memVo = memberService.getMemberByNickname(nickname);
                request.setAttribute("memVo", memVo);
            }
            String toId = request.getParameter("toId");
            String reportType = request.getParameter("reportType");
            String content = request.getParameter("content");
            if (content == null || content.equals("")) {
                content = "";
            }

            ReportVO vo = new ReportVO();
            vo.setFromId(fromId);
            vo.setToId(toId);
            vo.setReportType(reportType);
            vo.setReportContent(content);

            IReportService service = ReportServiceImpl.getInstance();
            int insetCnt = service.insertReport(vo);

            Map<String, Object> responseMap = new HashMap<>();

            if (insetCnt > 0) {
                responseMap.put("message", "신고가 정상적으로 접수되었습니다.");
                responseMap.put("success", true);
                responseMap.put("redirectUrl", request.getContextPath() + "/post/postList.do"); // 리다이렉션 URL 추가
                String jsonResponse = new Gson().toJson(responseMap);
                response.getWriter().write(jsonResponse);
            } else {
                responseMap.put("message", "신고 접수에 실패했습니다. 다시 시도해주세요.");
                responseMap.put("success", false);
                request.setAttribute("reportVO", vo);
                String jsonResponse = new Gson().toJson(responseMap);
                response.getWriter().write(jsonResponse);
            }
            response.getWriter().flush();

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("message", "서버 오류가 발생했습니다. 다시 시도해주세요.");
            errorResponse.put("success", false);
            String errorJsonResponse = new Gson().toJson(errorResponse);
            response.getWriter().write(errorJsonResponse);
            response.getWriter().flush();
        }
    }
}