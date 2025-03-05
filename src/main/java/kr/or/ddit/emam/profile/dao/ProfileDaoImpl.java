package kr.or.ddit.emam.profile.dao;

import java.util.List;
import kr.or.ddit.emam.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;

public class ProfileDaoImpl implements IProfileDao {

    private static IProfileDao dao;

    public static IProfileDao getInstance() {
        if (dao == null) dao = new ProfileDaoImpl();
        return dao;
    }

    private ProfileDaoImpl() {
    }

    @Override
    public ProfileVO selectProfile(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.emam.profile.dao.IProfileDao.selectProfile", memId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (session != null) session.close();
        }
    }

    @Override
    public List<PostVO> selectPostList(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectList("kr.or.ddit.emam.profile.dao.IProfileDao.selectPostList", memId);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            if (session != null) session.close();
        }
    }
}