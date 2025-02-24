package kr.or.ddit.emam.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.util.StreamData;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;

@WebServlet("/member/memberInsert.do")
public class MemberInsert extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        // 클라이언트가 파라미터 형식으로 보낸 데이터 받기 -
        String id = request.getParameter("mem_id");
        String pass = request.getParameter("mem_pw");
        String name = request.getParameter("mem_name");
        String nickName = request.getParameter("mem_nickname");
        String hp = request.getParameter("mem_phone");
        String addr = request.getParameter("mem_addr");
        String bir = request.getParameter("mem_bir");
        String gen = request.getParameter("mem_gen");
        //String mail = request.getParameter("mem_mail");
        //String zip = request.getParameter("mem_zip");
        //String add2 = request.getParameter("mem_add2");

        MemberVO  vo = new MemberVO();
        vo.setMem_id(id);
        vo.setMem_pw(pass);
        vo.setMem_name(name);
        vo.setMem_nickname(nickName);
        vo.setMem_addr(addr);
        vo.setMem_phone(hp);
        vo.setMem_bir(bir);
        vo.setMem_gen(gen);
        //vo.setMem_mail(mail);
        //vo.setMem_zip(zip);
        //vo.setMem_add1(add1);

        //--------------------------------------------------------
        // 클라이언트가 JSON 문자열로 보낸 자료 받기
//    	String strMemJson = StreamData.dataChange(request);
//    	Gson gson = new Gson();
//
//    	MemberVO  vo = gson.fromJson(strMemJson, MemberVO.class);

        //---------------------------------------------------------------


        //service겍체 얻기
        IMemberService  service = MemberServiceImpl.getInstance();

        //service메소드 호출 - 결과값 받기
        int  insetCnt = service.insertMember(vo);

        String result = "";
        if(insetCnt > 0){
            result =
                    """
                             {
                               "flag"  : "%s님 가입을 축하합니다"
                             }
                    """.formatted(vo.getMem_name());

        }else {
            result =
                    """	 	
                         {
                            "flag"  : "앗~~ 가입실패"
                         } 
                    """	;
        }
        PrintWriter out = response.getWriter();
        out.write(result);

        response.flushBuffer();
    }

}
