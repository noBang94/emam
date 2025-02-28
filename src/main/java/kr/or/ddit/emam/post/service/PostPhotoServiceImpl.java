package kr.or.ddit.emam.post.service;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.post.dao.IPostPhotoDao;
import kr.or.ddit.emam.post.dao.PostPhotoDaoImpl;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;
import kr.or.ddit.emam.vo.PostPhotoVO;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

public class PostPhotoServiceImpl implements IPostPhotoService {

    //DAO객체 사용하기 위함
    private IPostPhotoDao postPhotoDao;

    //1) 객체 생성
    private static PostPhotoServiceImpl postService = new PostPhotoServiceImpl();
    //2) 생성자
    private        PostPhotoServiceImpl() {postPhotoDao = PostPhotoDaoImpl.getInstance();}
    //3)Controller에서 이 객체를 사용하기 위함
    public  static PostPhotoServiceImpl getInstance() {return postService;}


    @Override
    public PostPhotoVO savePostPhoto(Collection<Part> parts) {
        String uploadPath = "D:/emam/src/main/webapp/upload";
        File uploadDir =new File(uploadPath);
        if(!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        PostPhotoVO postPhotoVO = null;
        boolean isFirstFile = true;

        for (Part part : parts) {
            String fileName = part.getSubmittedFileName();

            if(fileName != null && !fileName.equals("")) {
                if(isFirstFile) {
                    isFirstFile = false;
                    postPhotoVO = new PostPhotoVO();
                    postPhotoDao.insertPostPhoto(postPhotoVO);
                }

                String originalFileName = fileName;//원본파일
                String saveFileName = UUID.randomUUID().toString() + ".jpg";//저장 파일이름

                //확장자명 추출(s)
                String fileExt =
                        originalFileName.lastIndexOf(".") > 0 ?
                                originalFileName.substring(originalFileName.lastIndexOf(".") + 1) :
                                "";
                //확장자명 추출(e)

                String filePath = uploadPath+"/"+saveFileName;

                //파일 업로드
                try {
                    part.write(filePath);
                }catch (IOException e){
                    e.printStackTrace();
                    throw new RuntimeException("파일 업로드 실패 ㅠㅠ", e);
                }

                PostPhotoDetailVO postPhotoDetailVO = new PostPhotoDetailVO();
                postPhotoDetailVO.setPost_photo(postPhotoVO.getPost_photo());//파일 저장 인덱스
                postPhotoDetailVO.setPhoto_stre_cours(filePath);//파일 저장경로
                postPhotoDetailVO.setPhoto_flie_nm(saveFileName);//저장될 파일 이름
                postPhotoDetailVO.setOrg_photo_nm(originalFileName);//파일 진짜 이름
                postPhotoDetailVO.setPhoto_extsn(fileExt);//파일 확장자

                postPhotoDao.insertPostPhotoDetail(postPhotoDetailVO);

                try{
                    //임시파일 삭제
                    part.delete();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }

        return postPhotoVO;
    }

    @Override
    public PostPhotoVO getPostPhoto(PostPhotoVO postPhotoVO) {
        return postPhotoDao.getPostPhoto(postPhotoVO);
    }

    //PostPhotoVO{post_photo=13, post_photo_detail=null}
    @Override
    public PostPhotoDetailVO getPostPhotoDetail(PostPhotoDetailVO postPhotoDetailVO) {
        return postPhotoDao.getPostPhotoDetail(postPhotoDetailVO);
    }

    @Override
    public List<PostPhotoDetailVO> getPhotoList(int photoIndex) {
        return postPhotoDao.getPhotoList(photoIndex);
    }
}
