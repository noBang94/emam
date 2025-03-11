package kr.or.ddit.emam.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.vo.NotificationVO;
import kr.or.ddit.emam.vo.ReportVO;

import java.io.IOException;
import java.util.List;

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

        //신고 접수 시 회원의 알림 추가
        //신고-1. 알림vo에 넣기 위해 신고자ID를 구함
        INotificationService notificationService = NotificationServiceImpl.getInstance();
        NotificationVO notificationVo = new NotificationVO();
        notificationVo.setNotification_toId(reportService.getReport(reportId).getFromId());
        notificationVo.setNotification_fromId(null);
        notificationVo.setNotification_target(reportId);
        notificationVo.setNotification_type("report");
        String notificationContent = reportService.getReport(reportId).getToId() + " 계정에 대한 신고가 접수되었습니다.";
        notificationVo.setNotification_con(notificationContent);
        notificationVo.setNotification_isread(0);
        notificationService.insertNotification(notificationVo);

        if(result > 0) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}
