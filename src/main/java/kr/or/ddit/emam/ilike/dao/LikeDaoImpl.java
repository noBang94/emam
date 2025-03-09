package kr.or.ddit.emam.ilike.dao;

import kr.or.ddit.emam.ilike.service.ILikeService;
import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.ILikeVO;
import org.apache.ibatis.session.SqlSession;

public class LikeDaoImpl implements ILikeDao {
    private static ILikeDao dao;
    private LikeDaoImpl(){}
    public static ILikeDao getInstance(){
        if(dao == null){dao = new LikeDaoImpl();}
        return dao;
    }

    @Override
    public int likeCheck(ILikeVO ILikeVO) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.selectOne("like.Likecheck",ILikeVO);
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
    public int insertILike(ILikeVO ILikeVO) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.insert("like.insertLike",ILikeVO);
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

    @Override
    public int deleteILike(ILikeVO ILikeVO) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.delete("like.deleteLike",ILikeVO);
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
    public int countLike(String postindex) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.selectOne("like.LikeCount",postindex);
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
}
