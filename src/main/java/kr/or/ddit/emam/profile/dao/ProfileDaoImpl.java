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

        return session.selectOne("profile.selectProfile", memId);
    }

    @Override
    public List<PostVO> selectPostList(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        return session.selectList("profile.selectPostList", memId);
    }

    @Override
    public int updateProfile(ProfileVO profileVO) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = session.update("profile.updateProfile", profileVO);
        session.commit();
        return result;

    }

    @Override
    public int selectPostCount(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        return session.selectOne("profile.selectPostCount", memId); // 새로운 쿼리 ID 사용
    }

    @Override
    public int updateProfilePostCount(ProfileVO profileVO) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = session.update("profile.updateProfilePostCount", profileVO); // 새로운 쿼리 ID 사용
        session.commit();
        return result;
    }
}