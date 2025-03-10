package kr.or.ddit.emam.friend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;


@WebServlet("/friend/friendGnbList.do")
public class FriendGnbList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8"); // ContentType을 text/html로 설정

        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");
        IFriendService friendService = FriendServiceImpl.getInstance();

        String mem_id = loginMemberVo.getMem_id();
        List<MemberVO> friendList = friendService.selectFriend(mem_id);

        StringBuilder html = new StringBuilder("<ul>");
        for (MemberVO friend : friendList) {
            html.append("<li>");
            // 프로필 이미지, 닉네임, 채팅 버튼 등 친구 정보를 HTML로 구성
            html.append("<a href='").append(request.getContextPath()).append("/profile/profile.do?mem_id=").append(friend.getMem_id()).append("'>"); // 프로필 링크 추가
            html.append("<img src='").append(request.getContextPath()).append("/images/profile/").append(friend.getProfile_photo()).append("' width='30' height='30' style='border-radius: 50%;'>");
            html.append("<span>").append(friend.getMem_nickname()).append("</span>");
            html.append("</a>");
            html.append("<button>채팅</button>");
            html.append("</li>");
        }
        html.append("</ul>");

        response.getWriter().write(html.toString()); // HTML 조각 클라이언트에게 전송
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
