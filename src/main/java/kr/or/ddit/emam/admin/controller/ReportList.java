package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.vo.ReportVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reportList.do")
public class ReportList extends HttpServlet {
    private IReportService reportService = ReportServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String searchTitle = request.getParameter("searchTitle");

        try {
            if(searchTitle == null || searchTitle.equals("")) {
                List<ReportVO> reportList = reportService.selectAllReport(null);
                request.setAttribute("reportList", reportList);
            } else {
                List<ReportVO> reportList = reportService.searchReportId(searchTitle);
                request.setAttribute("reportList", reportList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/WEB-INF/view/admin/adminReportList.jsp").forward(request, response);
    }
}
