package kr.or.ddit.emam.member.service;

import kr.or.ddit.emam.vo.MemberVO;

public interface IMemberService {
    // 아이디 중복검사
    public int getMemberIdCount(String memId);

    // 회원 정보
    public MemberVO getMember(String memId);

    // 회원 가입하기
    public int insertMember(MemberVO  memberVo);

    // 로그인 하기
    public MemberVO getLoginMember(MemberVO memberVo);

    // 비밀번호 찾기
    public MemberVO getMemberByEmail(String email);
    void updatePassword(MemberVO memberVo);

    //닉네임 중복검사
    public boolean getMemberNicknameCount(String nickname);
}
