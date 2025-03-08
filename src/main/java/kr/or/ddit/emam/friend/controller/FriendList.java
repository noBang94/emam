package kr.or.ddit.emam.friend.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/friend/friendList.do")
public class FriendList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //로그인한 계정정보 가져오기
        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");

        //service객체 구하기
        IFriendService friendService = FriendServiceImpl.getInstance();

        String mem_id = loginMemberVo.getMem_id();
        List<MemberVO> friendList = friendService.selectFriend(mem_id);
        request.setAttribute("friendList", friendList);

        int totalFriend = friendService.totalFriend(mem_id);
        request.setAttribute("totalFriend", totalFriend);

        request.getRequestDispatcher("/WEB-INF/view/friend/friendList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
