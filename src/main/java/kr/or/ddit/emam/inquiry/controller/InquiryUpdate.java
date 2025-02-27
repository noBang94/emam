package kr.or.ddit.emam.inquiry.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.inquiry.service.IInquiryService;
import kr.or.ddit.emam.inquiry.service.InquiryServiceImpl;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.util.StreamData;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/inquiry/inquiryUpdate.do")
public class InquiryUpdate extends HttpServlet {
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
            MemberVO memberVo = memberService.getMember(inquiryVo.getMem_id());
            inquiryVo.setMemberVo(memberVo);
        }

        request.setAttribute("inquiryVo", inquiryVo);
        //request.setAttribute("inquiryproVo", inquiryproVo);

        request.getRequestDispatcher("/WEB-INF/view/inquiry/inquiryUpdate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        //작성 완료 시 데이터 받기

        String reqStr = StreamData.getJsonStream(request);

        //역직렬화 - InquiryVO객체로 변환
        Gson gson = new Gson();
        InquiryVO inquiryVo = gson.fromJson(reqStr, InquiryVO.class);

        //service객체 얻기
        IInquiryService service = InquiryServiceImpl.getInstance();

        //service메소드 호출하기
        int res = service.updateInquiry(inquiryVo);

        String jsonStr =
                """
                     {
                        "result" : %d
                     }
                """.formatted(res);
        PrintWriter out = response.getWriter();
        out.write(jsonStr);
        response.flushBuffer();

    }
}
