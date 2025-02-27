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
import kr.or.ddit.emam.vo.InquiryproVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;

@WebServlet("/inquiry/inquiryView.do")
public class InquiryView extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //선택한 문의글의 inquiry_index를 가져와 num에 저장함
        int num = Integer.parseInt(request.getParameter("num"));

        //service객체 구하기
        IInquiryService inquiryService = InquiryServiceImpl.getInstance();
        IMemberService memberService = MemberServiceImpl.getInstance();
        //IInquiryproService inquiryproService = InquiryproServiceImpl.getInstance();

        //문의번호에 맞는 문의 정보 가져오기
        InquiryVO inquiryVo = inquiryService.getInquiry(num);
        if(inquiryVo!=null){
            MemberVO memberVo = memberService.getMember(inquiryVo.getMemberVo().getMem_id());
            inquiryVo.setMemberVo(memberVo);
            //문의번호에 맞는 문의처리 정보 가져오기
            //InquiryproVO inquiryproVo = inquiryproService.getInquiry(num);
        }

		request.setAttribute("inquiryVo", inquiryVo);
		//request.setAttribute("inquiryproVo", inquiryproVo);

		request.getRequestDispatcher("/WEB-INF/view/board/boardView.jsp").forward(request, response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
