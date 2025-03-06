package kr.or.ddit.emam.util.service;

import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;

public interface ISearchService {
    public List<MemberVO> getMemberListById(String searchId);
}
