package kr.or.ddit.emam.post.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;

import java.io.IOException;

@WebServlet("/post/postview.do")
public class PostView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long postPhoto = req.getParameter("postphoto") == null ?
                -1 : Long.parseLong(req.getParameter("postphoto"));
        int postPhotoSn = req.getParameter("postphotosn") == null ?
                1 : Integer.parseInt(req.getParameter("postphotosn"));

        IPostPhotoService postPhotoService = PostPhotoServiceImpl.getInstance();
        PostPhotoDetailVO detailVO = new PostPhotoDetailVO();
        detailVO.setPost_photo(postPhoto);
        detailVO.setPost_photo_sn(postPhotoSn);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
