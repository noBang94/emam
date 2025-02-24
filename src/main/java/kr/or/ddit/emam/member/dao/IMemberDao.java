package kr.or.ddit.emam.member.dao;

import kr.or.ddit.emam.vo.MemberVO;

public interface IMemberDao {
    // 아이디 중복검사
    public int getMemberIdCount(String memId);

    // 회원 정보
    public MemberVO getMember(String memId);

    // 회원 가입하기
    public int insertMember(MemberVO  memberVo);

    // 로그인 하기
    public MemberVO getLoginMember(MemberVO memberVo);
}

