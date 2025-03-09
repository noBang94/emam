package kr.or.ddit.emam.friend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;

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
        MemberVO fromFriendVo = (MemberVO) session.getAttribute("loginMember");
        //삭제하려는 대상의 계정정보 가져오기
        String toFriend = request.getParameter("toFriend");

        //해당 친구 테이블 index 찾기
        FriendVO friendVo = new FriendVO();
        friendVo.setFriend_toid(toFriend);
        friendVo.setFriend_fromid(fromFriendVo.getMem_id());
        IFriendService friendService = FriendServiceImpl.getInstance();
        int friendIndex = friendService.indexFriend(friendVo);

        //해당 친구 index 행의 status를 1로 변경하기 (승인처리)
        friendService.yesFriend(friendIndex);

    }
}
