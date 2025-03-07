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
import kr.or.ddit.emam.usersettings.service.IUsersettingsService;
import kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NotificationVO;
import kr.or.ddit.emam.vo.UsersettingsVO;

import java.io.IOException;

//친구신청
@WebServlet("/friend/friendRequest.do")
public class FriendRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        //로그인한 계정정보 가져오기
        MemberVO fromFriendVo = (MemberVO) session.getAttribute("loginMember");
        //신청하려는 대상의 계정정보 가져오기
        String toFriend = request.getParameter("toFriend");

        //친구 테이블 행 추가하기
        FriendVO friendVo = new FriendVO();
        friendVo.setFriend_toid(toFriend);
        friendVo.setFriend_fromid(fromFriendVo.getMem_id());
        IFriendService friendService = FriendServiceImpl.getInstance();
        friendService.requestFriend(friendVo);

        //알림 테이블 행 추가하기
        int friendIndex = friendService.indexFriend(friendVo);
        NotificationVO notificationVo = new NotificationVO();
        notificationVo.setNotification_toId(toFriend);
        notificationVo.setNotification_fromId(fromFriendVo.getMem_id());
        notificationVo.setNotification_target(friendIndex);
        notificationVo.setNotification_type("friend");
        String notificationContent = fromFriendVo.getMem_nickname() + "님이 친구를 신청했습니다.";
        notificationVo.setNotification_con(notificationContent);
            //신청 받는 유저의 유저세팅 확인
        IUsersettingsService usersettingsService = UsersettingsServiceImpl.getInstance();
        UsersettingsVO usersettingsVo = new UsersettingsVO();
        usersettingsVo = usersettingsService.checkUsersettings(toFriend);
        if(usersettingsVo.getSet_friend() == 1){
            notificationVo.setNotification_isread(0);
        }else{
            notificationVo.setNotification_isread(1);
        }
        INotificationService notificationService = NotificationServiceImpl.getInstance();
        notificationService.insertNotification(notificationVo);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}