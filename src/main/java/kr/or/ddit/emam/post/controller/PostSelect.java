package kr.or.ddit.emam.post.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.ilike.service.ILikeService;
import kr.or.ddit.emam.ilike.service.LikeServiceImpl;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.vo.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/post/postList.do")
public class PostSelect extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/post/post.jsp").forward(req, resp);
    }

    @Override
//    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        //회원service 객체 얻기
        IMemberService service = MemberServiceImpl.getInstance();
        //세션 객체 가져오기
        HttpSession session = req.getSession();
        //세션에 로그인멤버가 있는지 확인한다
        MemberVO memcheck = (MemberVO) session.getAttribute("loginMember");

        ILikeService likeService = LikeServiceImpl.getInstance();

        //페이지 번호 가져오기
        String page = req.getParameter("page");
        int pageNum = 0;
        if(page == null){
            pageNum =1;
        }else {
            pageNum = Integer.parseInt(page);
        }

        //한번에 보여줄 수
        int setviewnum = 3;
        //회원이 없으면 로그인화면으로 이동
        if(memcheck == null){
            resp.sendRedirect("/");
        }else {
            //진짜 회원인지 확인한다
            //서비스 객체 얻기
            IMemberService memberService = MemberServiceImpl.getInstance();
            IPostService postService = PostServiceImpl.getInstance();
            IProfileService profileService = ProfileServiceImpl.getInstance();
            
            //전체
//            List<PostVO> postList = postService.selectAllPost();

            String memid = memcheck.getMem_id();
            //스크롤하면서 가져오기
            List<PostVO> postList = postService.selectScrollPost(memid, pageNum, setviewnum);
            
            for(PostVO postVO : postList){
                MemberVO memVo = memberService.getMember(postVO.getMem_id());
                ProfileVO pfVO = profileService.selectProfile(postVO.getMem_id());
                postVO.setMemVo(memVo);

                ILikeVO lv = new ILikeVO(postVO.getPost_index(), memcheck.getMem_id());
                int cnt = likeService.likeCheck(lv);
                int lcnt = likeService.likeCheck(lv);
                boolean liked = false;
                if(cnt>0){
                    liked = true;
                }else {
                    liked = false;
                }
                postVO.setLikecheck(liked);
                postVO.setProfileVo(pfVO);
                postVO.setLikecheckcnt(lcnt);
            }
//            req.setAttribute("postList", postList);
//            req.getRequestDispatcher("/WEB-INF/view/post/post.jsp").forward(req, resp);
            Gson gson = new Gson();
            String jsonData = null;

            jsonData = gson.toJson(postList);
            PrintWriter out = resp.getWriter();
            out.write(jsonData);
            resp.flushBuffer();
        }
    }
}
