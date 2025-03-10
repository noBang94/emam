package kr.or.ddit.emam.notice.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NoticeDaoImpl implements INoticeDao {
    private static INoticeDao dao;

    private NoticeDaoImpl() {
    }

    public static INoticeDao getInstance() {
        if (dao == null) dao = new NoticeDaoImpl();
        return dao;
    }

    @Override
    public NoticeVO getNotice(int noticeIndex) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("notice.getNotice", noticeIndex);
        }
    }

    @Override
    public List<NoticeVO> selectAllNotice(String getNotice) { // 전체 공지 조회
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> noticelist = null;

        try {
            noticelist = session.selectList("notice.selectAllNotice");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return noticelist;
    }

    @Override
    public List<NoticeVO> searchTitle(Map<String, Object> params) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("notice.searchTitle", params);
        }
    }
}
