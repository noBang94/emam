package kr.or.ddit.emam.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/memberIdCheck.do")
public class MemberIdCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        //요청시 전송데ㅔ이타 받기 - id
        String userId = request.getParameter("id");

        //service객체얻기
        IMemberService service = MemberServiceImpl.getInstance();

        //service메소드 호출 - 결과값을 얻기 - String
        int idCount = service.getMemberIdCount(userId);

        String result = null;
        if(idCount==0){
            result =
                    """
                        {
                            "flag"  : "사용가능한 id"
                        }
                    """;

        }else {
            result =
                    """	 	
                        {
                            "flag"  : "사용 불가능한 id"
                        }
                    """	;
        }

        PrintWriter out = response.getWriter();
        out.write(result);

        response.flushBuffer();

    }

}

