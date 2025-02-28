package kr.or.ddit.emam.post.dao;

import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.PostVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class PostDaoImpl implements IPostDao {
    //싱글톤
    private static IPostDao dao;

    //생성자
    private PostDaoImpl() {};

    //객체 생성 및 리턴
    public static IPostDao getInstance() {
        if (dao == null) dao = new PostDaoImpl();
        return dao;
    }

    @Override
    public int insertPost(PostVO postVo) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.insert("post.insertPost",postVo);
             if(cnt > 0){
                 session.commit();
             }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return cnt;
    }
    //게시글 조회
    @Override
    public PostVO selectPost(int num) {
        PostVO postVo = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            postVo = session.selectOne("post.selectPost",num);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return postVo;
    }

    @Override
    public List<PostVO> selectAllPost() {
        List<PostVO> pList = new ArrayList<PostVO>();
        SqlSession session = MyBatisUtil.getSqlSession();
        try{
            pList = session.selectList("post.selectAllPost");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }

        return pList;
    }

    @Override
    public int deletePost(int num) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();

        try {
            cnt = session.delete("post.deletePost",num);
            if(cnt > 0){
                session.commit();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }

        return cnt;
    }

    @Override
    public int updatePost(PostVO postVo) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.update("post.updatePost",postVo);
            if(cnt > 0){
                session.commit();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }

        return cnt;
    }

    //39
    @Override
    public PostVO getPost(int num) {
        SqlSession session = MyBatisUtil.getSqlSession();
        PostVO pv = null;
        try{
            pv =session.selectOne("post.selectOnePost",num);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }

        return pv;
    }
}
