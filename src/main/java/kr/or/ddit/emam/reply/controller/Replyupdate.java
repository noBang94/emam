package kr.or.ddit.emam.reply.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.ProfileVO;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/reply/replyUpdate.do")
public class Replyupdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        IProfileService profileService = ProfileServiceImpl.getInstance();
        //게시글 인덱스
        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        
        //뎃글 인덱스
        String Replyindex = req.getParameter("replyindex");
        int ReplyindexInt = Integer.parseInt(Replyindex);
        
        //수정될 뎃글 내용
        String Replycon = req.getParameter("replycon");

        //댓글 객체 생성
        IReplyService replyService = ReplyServiceImpl.getInstance();

        ReplyVO replyVO = new ReplyVO(ReplyindexInt,Replycon);

        int cnt = replyService.updateReply(replyVO);
        if (cnt > 0) {
//            resp.sendRedirect(req.getContextPath() + "/post/postList.do");
            List<ReplyVO> ReplyList = replyService.selectReplyListByPostIndex(postindexInt);
            for(ReplyVO replyVO2 : ReplyList){
                ProfileVO pfVO = profileService.selectProfile(replyVO2.getMem_id());
                replyVO2.setProfileVo(pfVO);
            }

            Gson gson = new Gson();
            String jsonData = null;

            jsonData = gson.toJson(ReplyList);

            PrintWriter out = resp.getWriter();
            out.write(jsonData);
            resp.flushBuffer();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
