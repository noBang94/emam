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
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");
        IFriendService friendService = FriendServiceImpl.getInstance();

        String mem_id = loginMemberVo.getMem_id();
        List<MemberVO> friendList = friendService.selectFriend(mem_id);

        StringBuilder html = new StringBuilder();

        // 친구 목록 헤더 추가
        html.append("<div class='friend-header'>친구 목록</div>");

        // 친구 검색 기능 추가
        html.append("<div class='friend-search'>");
        html.append("<input type='text' id='friendSearchInput' placeholder='친구 검색...' onkeyup='searchFriends()'>");
        html.append("</div>");

        // 친구 목록 컨테이너
        html.append("<div class='friend-list-container'>");

        if (friendList.isEmpty()) {
            html.append("<div class='no-friends'>등록된 친구가 없습니다.</div>");
        } else {
            html.append("<ul class='friend-list'>");
            for (MemberVO friend : friendList) {
                html.append("<li class='friend-item'>");

                // 프로필 이미지
                html.append("<div class='friend-avatar'>");
                if (friend.getProfile_photo() != null && !friend.getProfile_photo().isEmpty()) {
                    html.append("<img src='").append(request.getContextPath()).append("/images/profile/").append(friend.getProfile_photo()).append("' alt='프로필'>");
                } else {
                    // 프로필 이미지가 없는 경우 이니셜 표시
                    String initial = friend.getMem_nickname().substring(0, 1);
                    html.append("<div class='friend-initial'>").append(initial).append("</div>");
                }
                html.append("</div>");

                // 친구 정보
                html.append("<div class='friend-info'>");
                html.append("<a href='").append(request.getContextPath()).append("/profile/profile.do?mem_id=").append(friend.getMem_id()).append("' class='friend-name'>");
                html.append(friend.getMem_nickname());
                html.append("</a>");
                html.append("</div>");

                // 채팅 버튼
                html.append("<div class='friend-actions'>");
              
                html.append("</div>");

                html.append("</li>");
            }
            html.append("</ul>");
        }

        html.append("</div>");

        // 친구 검색 스크립트
        html.append("<script>");
        html.append("function searchFriends() {");
        html.append("  var input, filter, ul, li, a, i, txtValue;");
        html.append("  input = document.getElementById('friendSearchInput');");
        html.append("  filter = input.value.toUpperCase();");
        html.append("  ul = document.querySelector('.friend-list');");
        html.append("  li = ul.getElementsByTagName('li');");
        html.append("  for (i = 0; i < li.length; i++) {");
        html.append("    a = li[i].getElementsByClassName('friend-name')[0];");
        html.append("    txtValue = a.textContent || a.innerText;");
        html.append("    if (txtValue.toUpperCase().indexOf(filter) > -1) {");
        html.append("      li[i].style.display = '';");
        html.append("    } else {");
        html.append("      li[i].style.display = 'none';");
        html.append("    }");
        html.append("  }");
        html.append("}");
        html.append("</script>");

        // 스타일 추가
        html.append("<style>");
        html.append(".friend-header {");
        html.append("  font-weight: 500;");
        html.append("  font-size: 14px;");
        html.append("  margin: 8px 16px;");
        html.append("  padding-bottom: 8px;");
        html.append("  border-bottom: 1px solid #eee;");
        html.append("  color: #757575;");
        html.append("}");

        html.append(".friend-search {");
        html.append("  padding: 0 16px 8px;");
        html.append("}");

        html.append(".friend-search input {");
        html.append("  width: 100%;");
        html.append("  padding: 8px;");
        html.append("  border: 1px solid #eee;");
        html.append("  border-radius: 4px;");
        html.append("  font-size: 13px;");
        html.append("}");

        html.append(".friend-list-container {");
        html.append("  max-height: 300px;");
        html.append("  overflow-y: auto;");
        html.append("}");

        html.append(".no-friends {");
        html.append("  padding: 16px;");
        html.append("  text-align: center;");
        html.append("  color: #757575;");
        html.append("  font-size: 13px;");
        html.append("}");

        html.append(".friend-list {");
        html.append("  list-style: none;");
        html.append("  padding: 0;");
        html.append("  margin: 0;");
        html.append("}");

        html.append(".friend-item {");
        html.append("  display: flex;");
        html.append("  align-items: center;");
        html.append("  padding: 8px 16px;");
        html.append("  transition: background-color 0.2s;");
        html.append("}");

        html.append(".friend-item:hover {");
        html.append("  background-color: #f5f5f5;");
        html.append("}");

        html.append(".friend-avatar {");
        html.append("  width: 32px;");
        html.append("  height: 32px;");
        html.append("  border-radius: 50%;");
        html.append("  overflow: hidden;");
        html.append("  margin-right: 12px;");
        html.append("  flex-shrink: 0;");
        html.append("}");

        html.append(".friend-avatar img {");
        html.append("  width: 100%;");
        html.append("  height: 100%;");
        html.append("  object-fit: cover;");
        html.append("}");

        html.append(".friend-initial {");
        html.append("  width: 100%;");
        html.append("  height: 100%;");
        html.append("  background-color: #2196F3;");
        html.append("  color: white;");
        html.append("  display: flex;");
        html.append("  align-items: center;");
        html.append("  justify-content: center;");
        html.append("  font-weight: 500;");
        html.append("}");

        html.append(".friend-info {");
        html.append("  flex: 1;");
        html.append("}");

        html.append(".friend-name {");
        html.append("  color: #333;");
        html.append("  text-decoration: none;");
        html.append("  font-size: 14px;");
        html.append("  transition: color 0.2s;");
        html.append("}");

        html.append(".friend-name:hover {");
        html.append("  color: #2196F3;");
        html.append("}");

        html.append(".friend-actions {");
        html.append("  margin-left: 8px;");
        html.append("}");

        html.append(".chat-button {");
        html.append("  background-color: transparent;");
        html.append("  border: none;");
        html.append("  color: #757575;");
        html.append("  cursor: pointer;");
        html.append("  padding: 4px;");
        html.append("  border-radius: 4px;");
        html.append("  transition: all 0.2s;");
        html.append("}");

        html.append(".chat-button:hover {");
        html.append("  background-color: rgba(33, 150, 243, 0.1);");
        html.append("  color: #2196F3;");
        html.append("}");
        html.append("</style>");

        response.getWriter().write(html.toString());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}