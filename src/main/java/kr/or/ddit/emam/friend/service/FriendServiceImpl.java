package kr.or.ddit.emam.friend.service;

import kr.or.ddit.emam.friend.dao.FriendDaoImpl;
import kr.or.ddit.emam.friend.dao.IFriendDao;
import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;
import java.util.Map;

public class FriendServiceImpl implements IFriendService {

    //dao객체
    private IFriendDao dao;

    //자신의 객체
    private static IFriendService service;

    //생성자 - dao객체 얻기
    private FriendServiceImpl() { dao = FriendDaoImpl.getInstance(); }

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IFriendService getInstance() {
        if (service == null) service = new FriendServiceImpl();
        return service;
    }

    //상대와 내가 현재 친구 상호작용이 있는 상태인지 확인(0 = 친구아님 / 1 = 신청중이거나 이미 친구임)
    @Override
    public int checkFriend(FriendVO friendVo) { return dao.checkFriend(friendVo); }

    //상대와 나의 현재 친구상태에 대한 친구번호(index) 구함
    public int indexFriend(FriendVO friendVo) { return dao.indexFriend(friendVo); }

    @Override
    public int statusFriend(FriendVO friendVo) { return dao.statusFriend(friendVo); }

    @Override
    public int requestFriend(FriendVO friendVo) { return dao.requestFriend(friendVo); }

    @Override
    public int yesFriend(int friend_index) { return dao.yesFriend(friend_index); }

    @Override
    public int deleteFriend(int friend_index) { return dao.deleteFriend(friend_index); }

    @Override
    public List<MemberVO> selectFriend(String mem_id) { return dao.selectFriend(mem_id); }

    @Override
    public int totalFriend(String mem_id) { return dao.totalFriend(mem_id); }
}
