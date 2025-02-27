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
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PageVO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/inquiry/inquiryList.do")
public class InquiryList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        int page = 1;
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        String sword = request.getParameter("sword");
        sword = sword == null ? "" : sword;

        String myInquiry = request.getParameter("myInquiry");

        //service객체 구하기
        IInquiryService inquiryService = InquiryServiceImpl.getInstance();
        IMemberService memberService = MemberServiceImpl.getInstance();

        //로그인한 계정정보 가져오기... 여기선 굳이 가져올 필요 없나?
        //HttpSession session = request.getSession();
        //MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        //service메소드 호출하기 - 페이지 처리에 필요한 값 계산
        PageVO pageVo = inquiryService.pageInquiry(page, sword, myInquiry);

        //service메소드 호출하기 - paramater로 map을 설정
        Map<String, Object> map = new HashMap<>();
        map.put("start", pageVo.getStart());
        map.put("end", pageVo.getEnd());
        map.put("sword", sword);
        map.put("myInquiry", myInquiry);

        //메소드 호출 결과로 list를 받기
        List<InquiryVO> inquiryList = inquiryService.selectByPage(map);
        for(InquiryVO inquiryVo : inquiryList) {
            MemberVO writeMemberVo = memberService.getMember(myInquiry);
            inquiryVo.setMemberVo(writeMemberVo);
        }

        //결과값을 request에 저장 - 페이지 처리에 필요한 요소들
        request.setAttribute("inquiryList", inquiryList);
        request.setAttribute("pageVo", pageVo);
        request.setAttribute("sword", sword);
        request.setAttribute("myInquiry", myInquiry);

        //문의 화면으로 이동 - 출력에 필요한 json형식의 data 생성
        request.getRequestDispatcher("/WEB-INF/view/inquiry/inquiryList.jsp").forward(request, response);
    }
}
