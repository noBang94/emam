package kr.or.ddit.emam.util.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.util.service.ISearchService;
import kr.or.ddit.emam.util.service.SearchServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
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

        // 2. 서비스에서 회원 목록 조회 (getMemberListById 사용)
        List<MemberVO> memberList = service.getMemberListById(searchQuery);

        // 3. 조회된 회원 목록을 request 속성에 저장
        request.setAttribute("memberList", memberList);

        // 4. 검색 결과 페이지로 포워딩 (SearchList.jsp 사용)
        request.getRequestDispatcher("/WEB-INF/view/search/Search.jsp").forward(request, response);
    }
}