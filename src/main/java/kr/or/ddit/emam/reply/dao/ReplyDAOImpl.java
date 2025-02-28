package kr.or.ddit.emam.reply.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ReplyVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class ReplyDAOImpl implements IReplyDAO {

    private static IReplyDAO dao;
    private ReplyDAOImpl() {}
    public static IReplyDAO getInstance() { // 싱글톤 instance 반환 메소드
        if (dao == null) dao = new ReplyDAOImpl();
        return dao;
    }

    @Override
    public int insertReply(ReplyVO replyVO) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.insert("reply.insertReply",replyVO);
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
    public int updateReply(ReplyVO replyVO) {
        int cnt = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            cnt = session.update("reply.updateReply",replyVO);
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
    public List<ReplyVO> selectReplyListByPostIndex(int postIndex) {
        List<ReplyVO> RList = new ArrayList<ReplyVO>();
        SqlSession session = MyBatisUtil.getSqlSession();
        try{
            RList = session.selectList("reply.selectAllreply");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }

        return RList;
    }
}