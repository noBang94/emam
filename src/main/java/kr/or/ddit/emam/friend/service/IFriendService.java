package kr.or.ddit.emam.friend.service;

import kr.or.ddit.emam.vo.FriendVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;
import java.util.Map;

public interface IFriendService {
    //상대와 내가 현재 친구 상호작용이 있는 상태인지 확인(0 = 친구아님 / 1 = 신청중이거나 이미 친구임)
    public int checkFriend(Map<String, String> map);

    //상대와 나의 현재 친구상태(0 = 신청중 / 1 = 친구) 확인
    public int statusFriend(Map<String, String> map);

    //친구 신청
    public int requestFriend(FriendVO friendVo);

    //친구 신청 승인
    public int yesFriend(int friend_index);

    //친구 신청 거절 / 삭제
    public int deleteFriend(int friend_index);

    //친구 목록 조회
    public List<MemberVO> selectFriend(String mem_id);

    //친구 수 조회
    public int totalFriend(String mem_id);
}
