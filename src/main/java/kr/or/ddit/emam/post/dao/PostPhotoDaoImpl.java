package kr.or.ddit.emam.post.dao;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.post.service.IPostPhotoService;
import kr.or.ddit.emam.post.service.PostPhotoServiceImpl;
import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;
import kr.or.ddit.emam.vo.PostPhotoVO;
import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import java.util.Collection;

public class PostPhotoDaoImpl implements IPostPhotoDao {

    private static IPostPhotoDao postPhotoDao = new PostPhotoDaoImpl();
    private PostPhotoDaoImpl(){}
    public static IPostPhotoDao getInstance() {
        return postPhotoDao;
    }

    @Override
    public int insertPostPhoto(PostPhotoVO postPhotoVO) {
        SqlSession session = MyBatisUtil.getSqlSession(false);
        int cnt =0;
        try {
            cnt = session.insert("postphoto.insertphoto",postPhotoVO);
            if(cnt>0) {
                session.commit();
            }else {
                //실패시
            }
        } catch (PersistenceException e) {//실패시
            session.rollback();
            e.printStackTrace();
        }finally {
            session.close();
        }
        return cnt;
    }

    @Override
    public int insertPostPhotoDetail(PostPhotoDetailVO postPhotoDetailVO) {
        SqlSession session = MyBatisUtil.getSqlSession(false);
        int cnt =0;
        try {
            System.out.println("test");
            cnt = session.insert("postphoto.insertphopodetail",postPhotoDetailVO);
            if(cnt>0) {
                session.commit();
            }

        } catch (PersistenceException e) {
            session.rollback();
            e.printStackTrace();
        }finally {
            session.close();
        }
        return cnt;
    }

    @Override
    public PostPhotoVO getPostPhoto(PostPhotoVO postPhotoVO) {
        SqlSession session = MyBatisUtil.getSqlSession(true);
        try {
            postPhotoVO = session.selectOne("postphoto.getPostPhoto",postPhotoVO);
        } catch (PersistenceException e) {
            e.printStackTrace();
        }finally {
            session.close();
        }
        return postPhotoVO;
    }

    @Override
    public PostPhotoDetailVO getPostPhotoDetail(PostPhotoDetailVO postPhotoDetailVO) {
        SqlSession session = MyBatisUtil.getSqlSession(true);
        try {
            postPhotoDetailVO = session.selectOne("postphoto.getPostPhotoDetail",postPhotoDetailVO);
        } catch (PersistenceException e) {
            e.printStackTrace();
        }finally {
            session.close();
        }
        return postPhotoDetailVO;

    }
}
