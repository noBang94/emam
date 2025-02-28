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

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

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
        detailVO = postPhotoService.getPostPhotoDetail(detailVO);

        resp.setContentType("application/octet-steam");
        resp.setHeader("Content-Disposition", "attachment; filename=\""
                + URLEncoder.encode(detailVO.getOrg_photo_nm(), "UTF-8")
                .replaceAll("\\+", "%20") +"\"");


        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(detailVO.getPhoto_stre_cours()));

        BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());

        int data = 0;
        while ((data = bis.read()) != -1) {
            bos.write(data);
        }
        bis.close();
        bos.close();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
