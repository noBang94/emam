package kr.or.ddit.emam.member.controller;
import java.io.IOException;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//import kr.or.ddit.board.controller.StreamData;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;


@WebServlet("/member/loginMember.do")
public class LoginMember extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        //{"mem_id" : "a001" , "mem_pass" : "asdfasdf"}
        String memId = request.getParameter("mem_id");
        String memPw = request.getParameter("mem_pw");

        MemberVO memVo = new MemberVO();
        memVo.setMem_id(memId);
        memVo.setMem_pw(memPw);

        //service객체 얻기
        IMemberService service = MemberServiceImpl.getInstance();

        //service메소드 호출 - 결과값 받기
        MemberVO loginMemVo = service.getLoginMember(memVo);
        System.out.println("lmVo : " + loginMemVo);

        HttpSession session = request.getSession();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        String jsonResponse;

        //로그인 성공 실패 비교 하여  HttpSession에 저장
        if(loginMemVo != null) {
            //로그인 성공
            session.setAttribute("loginMember", loginMemVo);
            jsonResponse = gson.toJson(new LoginResponse("success", "로그인 성공"));
        } else {
            jsonResponse = gson.toJson(new LoginResponse("fail", "로그인 실패"));
        }
        response.getWriter().write(jsonResponse);

    }
    // JSON 응답을 위한 내부 클래스
    private static class LoginResponse {
        private String result;
        private String message;

        public LoginResponse(String result, String message) {
            this.result = result;
            this.message = message;
        }

        public String getResult() {
            return result;
        }

        public String getMessage() {
            return message;
        }
    }

}

