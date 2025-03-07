//PostServiceImpl
package kr.or.ddit.emam.post.service;

import kr.or.ddit.emam.post.dao.IPostDao;
import kr.or.ddit.emam.post.dao.PostDaoImpl;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.profile.service.IProfileService; // Import ProfileService interface
import kr.or.ddit.emam.profile.service.ProfileServiceImpl; // Import ProfileServiceImpl class

import java.util.List;

public class PostServiceImpl implements IPostService {
    //dao객체
    private IPostDao dao;
    //서비스객체
    private static IPostService service;

    private IProfileService profileService; // ProfileService instance 추가  //** 변경점 1 **//

    //생성자
    private PostServiceImpl() {
        dao = PostDaoImpl.getInstance();
        profileService = ProfileServiceImpl.getInstance(); // ProfileService 싱글톤 객체 얻어옴  //** 변경점 2 **//
    }

    public static IPostService getInstance() {
        if (service == null) service = new PostServiceImpl();
        return service;
    }

    @Override
    public int insertPost(PostVO postVo) {
        int result = dao.insertPost(postVo);
        if (result > 0) {
            profileService.updatePostCount(postVo.getMem_id()); // 게시글 등록 성공 시 게시글 수 업데이트  //** 변경점 3 **//
        }
        return result;
    }

    @Override
    public PostVO selectPost(int num) {
        return dao.selectPost(num);
    }

    @Override
    public List<PostVO> selectAllPost() {
        return dao.selectAllPost();
    }

    @Override
    public int deletePost(int num) {
        PostVO postVO = dao.selectOnePost(num); // 삭제 전에 회원 ID 필요  //** 변경점 4 **//
        int result = dao.deletePost(num);
        if (result > 0) {
            profileService.updatePostCount(postVO.getMem_id()); // 게시글 삭제 성공 시 게시글 수 업데이트  //** 변경점 5 **//
        }
        return result;
    }

    @Override
    public int updatePost(PostVO postVo) {
        return dao.updatePost(postVo);
    }

    //39
    @Override
    public PostVO getPost(int num) {return  dao.getPost(num);}

    @Override
    public List<PostVO> selectScrollPost(int page, int num) {return dao.selectScrollPost(page, num);}
}
