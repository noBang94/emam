package kr.or.ddit.emam.reply.controller;

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
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/reply/getreply.do")
public class Replyselect extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        IReplyService replyService = ReplyServiceImpl.getInstance();

        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);

        IProfileService profileService = ProfileServiceImpl.getInstance();

        List<ReplyVO> ReplyList = replyService.selectReplyListByPostIndex(postindexInt);
        for(ReplyVO replyVO : ReplyList){
            ProfileVO pfVO = profileService.selectProfile(replyVO.getMem_id());
            replyVO.setProfileVo(pfVO);
        }

//        ReplyVO replyVO = replyService.selectOneReply(postindexInt);

        Gson gson = new Gson();
        String jsonData = null; //변환된 Json문자열이 저장될 변수



        jsonData = gson.toJson(ReplyList);

        PrintWriter out = resp.getWriter();
        out.write(jsonData);
        resp.flushBuffer();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
