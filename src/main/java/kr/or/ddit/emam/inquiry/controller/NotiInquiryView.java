package kr.or.ddit.emam.inquiry.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.inquiry.service.IInquiryService;
import kr.or.ddit.emam.inquiry.service.InquiryServiceImpl;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NotificationVO;

import java.io.IOException;

@WebServlet("/inquiry/notiInquiryView.do")
public class NotiInquiryView extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //선택한 문의글의 inquiry_index를 가져와 num에 저장함
        int num = Integer.parseInt(request.getParameter("num"));

        //service객체 구하기
        IInquiryService inquiryService = InquiryServiceImpl.getInstance();
        IMemberService memberService = MemberServiceImpl.getInstance();

        //문의번호에 맞는 문의 정보 가져오기
        InquiryVO inquiryVo = inquiryService.getInquiry(num);
        if(inquiryVo!=null){
            MemberVO memberVo = memberService.getMember(inquiryVo.getMem_id());
            inquiryVo.setMemberVo(memberVo);
        }

		request.setAttribute("inquiryVo", inquiryVo);

        //알림 읽음으로 처리하기
        INotificationService notificationService = NotificationServiceImpl.getInstance();
        NotificationVO notificationVo = new NotificationVO();
        notificationVo.setNotification_target(num);
        notificationVo.setNotification_type("inquiry");
        int notificationIndex = notificationService.selectOneNotification(notificationVo);
        notificationService.updateNotification(notificationIndex);

		request.getRequestDispatcher("/WEB-INF/view/inquiry/inquiryView.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
