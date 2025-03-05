package kr.or.ddit.emam.vo;

import java.util.Date;
import java.util.List;

public class ProfileVO {
    private String memId; // 회원 ID (MEMBER 테이블 PK, PROFILE 테이블 PK & FK)
    private String profileIntro; // 자기소개
    private String profileHeaderphoto; // 배경 사진 파일 경로
    private String profilePhoto; // 프로필 사진 파일 경로
    private int profileFriendcnt; // 친구 수
    private int profilePostcnt; // 게시글 수
    private String profileUrl; // URL 소개

    public Date getMemBir() {
        return memBir;
    }

    public void setMemBir(Date memBir) {
        this.memBir = memBir;
    }

    public String getProfileUrl() {
        return profileUrl;
    }

    public void setProfileUrl(String profileUrl) {
        this.profileUrl = profileUrl;
    }

    public int getProfilePostcnt() {
        return profilePostcnt;
    }

    public void setProfilePostcnt(int profilePostcnt) {
        this.profilePostcnt = profilePostcnt;
    }

    public int getProfileFriendcnt() {
        return profileFriendcnt;
    }

    public void setProfileFriendcnt(int profileFriendcnt) {
        this.profileFriendcnt = profileFriendcnt;
    }

    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }

    public String getProfileHeaderphoto() {
        return profileHeaderphoto;
    }

    public void setProfileHeaderphoto(String profileHeaderphoto) {
        this.profileHeaderphoto = profileHeaderphoto;
    }

    public String getProfileIntro() {
        return profileIntro;
    }

    public void setProfileIntro(String profileIntro) {
        this.profileIntro = profileIntro;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    private Date memBir; // 생일 (MEMBER 테이블 MEM_BIR 컬럼 값 가져와서 사용, Date 타입으로 변경)


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


    @Override
    public String toString() {
        return "ProfileVO{" +
                "memId='" + memId + '\'' +
                ", profileIntro='" + profileIntro + '\'' +
                ", profileHeaderphoto='" + profileHeaderphoto + '\'' +
                ", profilePhoto='" + profilePhoto + '\'' +
                ", profileFriendcnt=" + profileFriendcnt +
                ", profilePostcnt=" + profilePostcnt +
                ", profileUrl='" + profileUrl + '\'' +
                ", memBir=" + memBir +
                ", memberVO=" + memberVO +
                ", postList=" + postList +
                '}';
    }
}