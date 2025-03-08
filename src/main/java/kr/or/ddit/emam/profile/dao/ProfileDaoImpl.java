package kr.or.ddit.emam.profile.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.MemberVO;
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
    public int insertProfile(MemberVO memberVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.insert("profile.insertProfile", memberVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
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
    @Override
    public List<MemberVO> selectFriend(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<MemberVO> friendList = null;
        try {
            friendList = session.selectList("friend.selectFriend", memId); // 쿼리 호출: "friend.selectFriend"
        } finally {
            session.close();
        }
        return friendList;
    }
    @Override
    public boolean isFriend(String loginMemberId, String profileOwnerId) {
        SqlSession session = MyBatisUtil.getSqlSession(); // MyBatisUtil.getSqlSession() 사용
        try {
            // 🚩 [핵심]: 친구 관계를 확인하는 SQL 쿼리 실행 (profile 네임스페이스 사용)
            int count = session.selectOne("profile.isFriendCheck", Map.of("loginMemberId", loginMemberId, "profileOwnerId", profileOwnerId));
            return count > 0; // 조회 결과가 1개 이상이면 친구, 아니면 친구 아님
        } finally {
            session.close();
        }
    }
}