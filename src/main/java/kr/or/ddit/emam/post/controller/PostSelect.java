package kr.or.ddit.emam.post.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;
import kr.or.ddit.emam.vo.PostPhotoVO;
import kr.or.ddit.emam.vo.PostVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/post/postList.do")
public class PostSelect extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        //서비스 객체 얻기
        IMemberService memberService = MemberServiceImpl.getInstance();
        IPostService postService = PostServiceImpl.getInstance();

        List<PostVO> postList = postService.selectAllPost();

        System.out.println("postList->postList : " + postList);

        for(PostVO postVO : postList){
            MemberVO memVo = memberService.getMember(postVO.getMem_id());

            System.out.println("postList->memVo : " + memVo);
            postVO.setMemVo(memVo);

        }

        req.setAttribute("postList", postList);
        req.getRequestDispatcher("/WEB-INF/view/post/post.jsp").forward(req, resp);
    }

}
