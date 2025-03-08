package kr.or.ddit.emam.ilike.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.ilike.service.ILikeService;
import kr.or.ddit.emam.ilike.service.LikeServiceImpl;
import kr.or.ddit.emam.vo.ILikeVO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/setilike.do")
public class ILikeControllerAjax extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=utf-8");

        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        String memid = req.getParameter("memid");
        ILikeService Service = LikeServiceImpl.getInstance();

        ILikeVO lv = new ILikeVO(postindexInt,memid);

        int cnt = Service.likeCheck(lv);
        //좋아요 체크
        boolean liked = false;
        if(cnt>0){
            //체크한적이있으면 체크 취소
            Service.deleteILike(lv);
            liked = false;
        }else{
            Service.insertILike(lv);
            liked = true;
        }
        Gson gson = new Gson();
        String jsonData = null;

        jsonData = gson.toJson(liked);

        PrintWriter out = resp.getWriter();
        out.write(jsonData);
        resp.flushBuffer();
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //게시글 가져올때
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=utf-8");
        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        String memid = req.getParameter("memid");
        ILikeService Service = LikeServiceImpl.getInstance();

        ILikeVO lv = new ILikeVO(postindexInt,memid);
        int cnt = Service.likeCheck(lv);
        boolean liked = false;
        if(cnt>0){
            liked = true;
        }else {
            liked = false;
        }
        Gson gson = new Gson();
        String jsonData = null;
        jsonData = gson.toJson(liked);

        PrintWriter out = resp.getWriter();
        out.write(jsonData);
        resp.flushBuffer();
    }
}
