package kr.or.ddit.emam.friend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NotificationVO;

import java.io.IOException;

//친구 신청 승인
@WebServlet("/friend/friendYes.do")
public class FriendYes extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        //로그인한 계정정보 가져오기
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");
        //수락하려는 대상의 계정정보 가져오기
        String fromFriend = request.getParameter("fromFriend");

        //해당 친구 테이블 index 찾기
        FriendVO friendVo = new FriendVO();
        friendVo.setFriend_toid(loginMemberVo.getMem_id());
        friendVo.setFriend_fromid(fromFriend);
        IFriendService friendService = FriendServiceImpl.getInstance();
        int friendIndex = friendService.indexFriend(friendVo);

        //알림 테이블 행 삭제
        NotificationVO notificationVo = new NotificationVO();
        notificationVo.setNotification_type("friend");
        notificationVo.setNotification_target(friendIndex);
        INotificationService notificationService = NotificationServiceImpl.getInstance();
        int notificationIndex = notificationService.selectOneNotification(notificationVo);
        notificationService.updateNotification(notificationIndex);

        //해당 친구 index 행의 status를 1로 변경하기 (승인처리)
        friendService.yesFriend(friendIndex);

    }
}
