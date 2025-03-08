package kr.or.ddit.emam.util.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.friend.service.FriendServiceImpl;
import kr.or.ddit.emam.friend.service.IFriendService;
import kr.or.ddit.emam.util.service.ISearchService;
import kr.or.ddit.emam.util.service.SearchServiceImpl;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search.do")
public class searchMember extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        ISearchService service = SearchServiceImpl.getInstance();

        // 1. 검색어 파라미터 가져오기 (JSP에서 name="id"로 설정했으므로 "id" 사용)
        String searchQuery = request.getParameter("id");

        System.out.println("검색어: " + searchQuery);

        // 2. 검색어가 null이거나 공백인지 확인
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            // 검색어가 없거나 공백이면 빈 목록을 request 속성에 저장
            request.setAttribute("memberList", List.of()); // 빈 목록 생성
        } else {
            // 3. 서비스에서 회원 목록 조회 (getMemberListById 사용)
            List<MemberVO> memberList = service.getMemberListById(searchQuery);

            // 4. 조회된 회원 목록을 request 속성에 저장
            request.setAttribute("memberList", memberList);

            // 로그인한 회원과 상대 회원에 대하여 친구상태 구하여 목록 만들기(status값이 null이면 상호작용 없음, 0이면 신청중, 1이면 친구)
            // 로그인한 계정정보 가져오기
            HttpSession session = request.getSession();
            MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");
            // service객체 구하기
            IFriendService friendService = FriendServiceImpl.getInstance();
            List<FriendVO> friendCheckList = new ArrayList();
            for(MemberVO memberVo : memberList) {
                FriendVO friendVo = new FriendVO();
                friendVo.setFriend_fromid(loginMemberVo.getMem_id());
                friendVo.setFriend_toid(memberVo.getMem_id());
                if(friendService.checkFriend(friendVo)==0){
                    friendVo.setFriend_status("null");
                }else if(friendService.statusFriend(friendVo)==0){
                    friendVo.setFriend_status("0");
                }else {
                    friendVo.setFriend_status("1");
                }
                friendCheckList.add(friendVo);
            }
            request.setAttribute("friendCheckList", friendCheckList);
        }

        // 5. 검색 결과 페이지로 포워딩 (SearchList.jsp 사용)
        request.getRequestDispatcher("/WEB-INF/view/search/Search.jsp").forward(request, response);
    }
}