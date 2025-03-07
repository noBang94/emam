package kr.or.ddit.emam.vo;

import java.util.Date;
import java.util.List;

public class ProfileVO {
    private String mem_id; // 회원 ID (MEMBER 테이블 PK, PROFILE 테이블 PK & FK)
    private String mem_nickname;
    private String mem_bir;
    private String profile_intro; // 자기소개
    private String profile_headerphoto; // 배경 사진 파일 경로
    private String profile_photo; // 프로필 사진 파일 경로
    private int profile_friendcnt; // 친구 수
    private int profile_postcnt; // 게시글 수
    private String profile_url; // URL 소개

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getMem_nickname() {
        return mem_nickname;
    }

    public void setMem_nickname(String mem_name) {
        this.mem_nickname = mem_name;
    }

    public String getMem_bir() {
        return mem_bir;
    }

    public void setMem_bir(String mem_bir) {
        this.mem_bir = mem_bir;
    }

    public String getProfile_intro() {
        return profile_intro;
    }

    public void setProfile_intro(String profile_intro) {
        this.profile_intro = profile_intro;
    }

    public String getProfile_headerphoto() {
        return profile_headerphoto;
    }

    public void setProfile_headerphoto(String profile_headerphoto) {
        this.profile_headerphoto = profile_headerphoto;
    }

    public String getProfile_photo() {
        return profile_photo;
    }

    public void setProfile_photo(String profile_photo) {
        this.profile_photo = profile_photo;
    }

    public int getProfile_friendcnt() {
        return profile_friendcnt;
    }

    public void setProfile_friendcnt(int profile_friendcnt) {
        this.profile_friendcnt = profile_friendcnt;
    }

    public int getProfile_postcnt() {
        return profile_postcnt;
    }

    public void setProfile_postcnt(int profile_postcnt) {
        this.profile_postcnt = profile_postcnt;
    }

    public String getProfile_url() {
        return profile_url;
    }

    public void setProfile_url(String profile_url) {
        this.profile_url = profile_url;
    }



    private MemberVO memberVO; // 회원 정보 (MemberVO 객체 포함, 닉네임, 프로필 사진 등 `PROFILE.JSP` 에 직접 바인딩)
    private List<PostVO> postList; // 게시글 목록 (프로필 페이지 게시글 목록 표시)


    // 기본 생성자
    public ProfileVO() {}


    // MemberVO getter, setter 추가
    public MemberVO getMemberVO() {
        return memberVO;
    }

    public void setMemberVO(MemberVO memberVO) {
        this.memberVO = memberVO;
    }

    // PostVO List getter, setter 추가
    public List<PostVO> getPostList() {
        return postList;
    }

    public void setPostList(List<PostVO> postList) {
        this.postList = postList;
    }


}