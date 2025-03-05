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

@WebServlet("/admin/processReport.do")
public class ProcessReport extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IReportService reportService = ReportServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reportId = Integer.parseInt(request.getParameter("reportId"));

        ReportVO reportVO = reportService.getReport(reportId);

        request.setAttribute("reportVO", reportVO);
        request.getRequestDispatcher("/WEB-INF/view/admin/adminReportDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reportId = Integer.parseInt(request.getParameter("reportId"));
        String status = request.getParameter("reportStatus");

        if("N".equals(status)) {
            processReport(reportId, response);
        } else {
            response.getWriter().write("invalid status");
        }
    }

    private void processReport(int reportId, HttpServletResponse response) throws IOException {
        ReportVO reportVO = new ReportVO();
        reportVO.setReportId(reportId);

        int result = reportService.updateReport(reportId);

        if(result > 0) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}
