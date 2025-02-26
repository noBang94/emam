package kr.or.ddit.emam.vo;

public class PostPhotoDetailVO {
    private long   post_photo = -1;          //게시글 사진 번호
    private int    post_photo_sn = 1;       //게시글 사진 번호 의 순번
    private String photo_stre_cours;    //사진 저장경로
    private String photo_flie_nm;       // 저장 될 파일 이름
    private String org_photo_nm;        //원본 사진 이름
    private String photo_extsn;         // 사진 확장자 .. 파일일때 사용하던것

    //질문
//    private String p //사진 내용
    
    public long getPost_photo() {
        return post_photo;
    }

    public void setPost_photo(long post_photo) {
        this.post_photo = post_photo;
    }

    public int getPost_photo_sn() {
        return post_photo_sn;
    }

    public void setPost_photo_sn(int post_photo_sn) {
        this.post_photo_sn = post_photo_sn;
    }

    public String getPhoto_stre_cours() {
        return photo_stre_cours;
    }

    public void setPhoto_stre_cours(String photo_stre_cours) {
        this.photo_stre_cours = photo_stre_cours;
    }

    public String getPhoto_flie_nm() {
        return photo_flie_nm;
    }

    public void setPhoto_flie_nm(String photo_flie_nm) {
        this.photo_flie_nm = photo_flie_nm;
    }

    public String getOrg_photo_nm() {
        return org_photo_nm;
    }

    public void setOrg_photo_nm(String org_photo_nm) {
        this.org_photo_nm = org_photo_nm;
    }

    public String getPhoto_extsn() {
        return photo_extsn;
    }

    public void setPhoto_extsn(String photo_extsn) {
        this.photo_extsn = photo_extsn;
    }
}
