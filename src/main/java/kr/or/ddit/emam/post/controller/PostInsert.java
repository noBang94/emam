package kr.or.ddit.emam.post.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.post.dao.PostPhotoDaoImpl;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.vo.PostPhotoVO;
import kr.or.ddit.emam.vo.PostVO;

import java.io.IOException;

@WebServlet("/post/insertpost.do")
@MultipartConfig
public class PostInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");

        String mem_id = req.getParameter("postwriter");
        String post_con = req.getParameter("postcon");
        String post_visible = req.getParameter("postvis")==null?"N":req.getParameter("postvis");


        //service객체 얻기
        IPostService service = PostServiceImpl.getInstance();

        //게시글 사진 업로드하기위한 객체 생성
        IPostPhotoService photoService = PostPhotoServiceImpl.getInstance();
        //업로드처리
        PostPhotoVO postPhotoVO =  photoService.savePostPhoto(req.getParts());

        PostVO post = new PostVO(mem_id, post_con, post_visible);
        if(postPhotoVO != null){
            post.setPost_photo(postPhotoVO.getPost_photo());
        }

        System.out.println(post.getMem_id());
        System.out.println(post.getPost_con());
        System.out.println(post.getPost_visible());
        System.out.println(post.getPost_photo());

        int cnt = service.insertPost(post);
        if (cnt > 0) {
            resp.sendRedirect(req.getContextPath()+"/post/postList.do");
        }else {
            System.out.println("게시글 생성실패");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
