package kr.or.ddit.emam.post.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostVO;
import oracle.jdbc.proxy.annotation.Post;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

//{"postindex":1}
@WebServlet("/post/postDetailAjax.do")
public class PostDetailAjax extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");

        //서비스 객체 얻기
        IMemberService memberService = MemberServiceImpl.getInstance();
        IPostService postService = PostServiceImpl.getInstance();

        String postindex = request.getParameter("postindex");

        int postindexInt = Integer.parseInt(postindex);

//        System.out.println("postindex : " + postindex);

        Gson gson = new Gson();
        String jsonData = null; //변환된 Json문자열이 저장될 변수

        PostVO postVo = postService.selectPost(postindexInt);
//        System.out.println("PostDetailAjax->postVo" + postVo);

        MemberVO memVo = memberService.getMember(postVo.getMem_id());
        postVo.setMemVo(memVo);

        jsonData = gson.toJson(postVo);
//		jsonData += "{}";//오류확인하기위해 추가

//        System.out.println("jsonData = " + jsonData);
        //Json문자열을 응답으로 보내기
        PrintWriter out = response.getWriter();
        out.write(jsonData);
        response.flushBuffer();

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
