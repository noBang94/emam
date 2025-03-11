package kr.or.ddit.emam.notification.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;

import java.io.IOException;

//알림 확인(별도 이벤트 발생 없이 알림status만 1로 변경하는 경우 사용)
@WebServlet("/notification/notificationCheck.do")
public class NotiCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int notiIndex = Integer.parseInt(request.getParameter("notiIndex"));
        //service객체 구하기
        INotificationService notificationService = NotificationServiceImpl.getInstance();
        notificationService.updateNotification(notiIndex);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
