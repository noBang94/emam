package kr.or.ddit.emam.notification.controller;


import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NotificationVO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/notification/notificationList.do")
public class NotificationList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //로그인한 계정정보 가져오기
        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");

        //service객체 구하기
        IMemberService memberService = MemberServiceImpl.getInstance();
        INotificationService notificationService = NotificationServiceImpl.getInstance();

        String mem_id = loginMemberVo.getMem_id();
        List<NotificationVO> notificationList = notificationService.selectNotification(mem_id);

        // JSON으로 변환하여 응답
        Gson gson = new Gson();
        String json = gson.toJson(notificationList);

        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
