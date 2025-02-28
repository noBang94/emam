package kr.or.ddit.emam.post.service;

import kr.or.ddit.emam.post.dao.IPostDao;
import kr.or.ddit.emam.post.dao.PostDaoImpl;
import kr.or.ddit.emam.vo.PostVO;

import java.util.List;

public class PostServiceImpl implements IPostService {
    //dao객체
    private IPostDao dao;
    //서비스객체
    private static IPostService service;

    //생성자
    private PostServiceImpl() {
        dao = PostDaoImpl.getInstance();
    }

    public static IPostService getInstance() {
        if (service == null) service = new PostServiceImpl();
        return service;
    }

    @Override
    public int insertPost(PostVO postVo) {
        return dao.insertPost(postVo);
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
        return dao.deletePost(num);
    }

    @Override
    public int updatePost(PostVO postVo) {
        return dao.updatePost(postVo);
    }

    //39
    @Override
    public PostVO getPost(int num) {return  dao.getPost(num);}
}
