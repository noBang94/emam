package kr.or.ddit.emam.post.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

        //회원service 객체 얻기
        IMemberService service = MemberServiceImpl.getInstance();

        //세션 객체 가져오기
        HttpSession session = req.getSession();
        //세션에 로그인멤버가 있는지 확인한다
        MemberVO memcheck = (MemberVO) session.getAttribute("loginMember");
        //회원이 없으면 로그인화면으로 이동
        if(memcheck == null){
            resp.sendRedirect("/");
        }else {
            //진짜 회원인지 확인한다

            //서비스 객체 얻기
            IMemberService memberService = MemberServiceImpl.getInstance();
            IPostService postService = PostServiceImpl.getInstance();

            List<PostVO> postList = postService.selectAllPost();

//            System.out.println("postList->postList : " + postList);

            for(PostVO postVO : postList){
                MemberVO memVo = memberService.getMember(postVO.getMem_id());

//                System.out.println("postList->memVo : " + memVo);
                postVO.setMemVo(memVo);

            }

            req.setAttribute("postList", postList);
            req.getRequestDispatcher("/WEB-INF/view/post/post.jsp").forward(req, resp);
        }
        

    }

}
