package kr.or.ddit.emam.post.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.vo.PostVO;

import java.io.IOException;

@WebServlet("/post/deletepost.do")
public class PostDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String post_indexS = req.getParameter("postindex");
        //인덱스를 인트로 변환
        int post_idex = Integer.parseInt(post_indexS);

        IPostService service = PostServiceImpl.getInstance();

        int cnt = service.deletePost(post_idex);
        if (cnt > 0) {
            resp.sendRedirect(req.getContextPath()+"/post/postList.do");
        }else {
            System.out.println("삭제 실패");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
