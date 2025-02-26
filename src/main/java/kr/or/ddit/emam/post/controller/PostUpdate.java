package kr.or.ddit.emam.post.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostVO;

import java.io.IOException;

@WebServlet("/post/updatepost.do")
public class PostUpdate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String post_indexS = req.getParameter("postindex");
        String mem_id = req.getParameter("postwriter");
        String post_con = req.getParameter("postcon");
        String post_visible = req.getParameter("postvis")==null?"N":req.getParameter("postvis");

        //인덱스를 인트로 변환
        int post_idex = Integer.parseInt(post_indexS);

        PostVO post = new PostVO(post_idex,mem_id, post_con, post_visible);

        PostVO pv = new PostVO();

        //service객체 얻기
        IPostService service = PostServiceImpl.getInstance();

        int cnt = service.updatePost(post);

        if (cnt > 0) {
            resp.sendRedirect(req.getContextPath()+"/post/postList.do");
        }else {
            System.out.println("수정실패");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
