package kr.or.ddit.emam.util.dao;

import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;

public interface ISearchDao {
    public List<MemberVO> getMemberListById(String searchId);
}
