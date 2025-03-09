package kr.or.ddit.emam.friend.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class FriendDaoImpl implements IFriendDao {

    //싱글톤
    private static IFriendDao dao;

    private FriendDaoImpl() {}

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IFriendDao getInstance() {
        if (dao == null) dao = new FriendDaoImpl();
        return dao;
    }

    //상대와 내가 현재 친구 상호작용이 있는 상태인지 확인(0 = 친구아님 / 1 = 신청중이거나 이미 친구임)
    @Override
    public int checkFriend(FriendVO friendVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("friend.checkFriend", friendVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }

    //상대와 나의 현재 친구상태(null = 친구아님 / 0 = 신청중 / 1 = 친구) 확인
    @Override
    public int statusFriend(FriendVO friendVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("friend.statusFriend", friendVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }

    //상대와 나의 현재 친구상태에 대한 친구번호(index) 구함
    @Override
    public int indexFriend(FriendVO friendVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("friend.indexFriend", friendVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }


    //친구 신청
    @Override
    public int requestFriend(FriendVO friendVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.insert("friend.requestFriend", friendVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //친구 신청 승인
    @Override
    public int yesFriend(int friend_index) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("friend.yesFriend", friend_index);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //친구 신청 거절 / 삭제
    @Override
    public int deleteFriend(int friend_index) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.delete("friend.deleteFriend", friend_index);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //친구 목록 조회
    @Override
    public List<MemberVO> selectFriend(String mem_id) {
        List<MemberVO> list = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            list = session.selectList("friend.selectFriend", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    //친구 수 조회
    @Override
    public int totalFriend(String mem_id) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("friend.totalFriend", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }
}
