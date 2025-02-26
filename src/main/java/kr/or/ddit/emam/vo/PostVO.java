package kr.or.ddit.emam.vo;

import java.time.LocalDate;

public class PostVO {
    private int post_index; //게시글 번호
    private String mem_id; //작성자 아이디
    private String post_con; // 게시글 내용
    private long post_photo = -1; //게시글 사진
    private String post_date; // 게시글 작성일
    private String post_visible; //게시글 공개 여부
    private int post_replycnt; //댓글 개수
    private int post_ilikecnt; //좋아요 수
    private int post_viewcnt; //조회 수

    private MemberVO memVo; //작성자 정보

    private PostVO postVo; //게시글 사진 정보

    public PostVO() {}
    
    public PostVO(String mem_id, String post_con, String post_visible){
        super();
        this.mem_id = mem_id;
        this.post_con = post_con;
        this.post_visible = post_visible;
    }

    public PostVO(int post_index, String mem_id, String post_con, String post_visible) {
        this.post_index = post_index;
        this.mem_id = mem_id;
        this.post_con = post_con;
        this.post_visible = post_visible;
    }

    public PostVO getPostVo() {
        return postVo;
    }

    public void setPostVo(PostVO postVo) {
        this.postVo = postVo;
    }

    public MemberVO getMemVo() {
        return memVo;
    }

    public void setMemVo(MemberVO memVo) {
        this.memVo = memVo;
    }

    public int getPost_index() {
        return post_index;
    }

    public void setPost_index(int post_index) {
        this.post_index = post_index;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getPost_con() {
        return post_con;
    }

    public void setPost_con(String post_con) {
        this.post_con = post_con;
    }

    public long getPost_photo() {
        return post_photo;
    }

    public void setPost_photo(long post_photo) {
        this.post_photo = post_photo;
    }

    public String getPost_date() {
        return post_date;
    }

    public void setPost_date(String post_date) {
        this.post_date = post_date;
    }

    public String getPost_visible() {
        return post_visible;
    }

    public void setPost_visible(String post_visible) {
        this.post_visible = post_visible;
    }

    public int getPost_replycnt() {
        return post_replycnt;
    }

    public void setPost_replycnt(int post_replycnt) {
        this.post_replycnt = post_replycnt;
    }

    public int getPost_ilikecnt() {
        return post_ilikecnt;
    }

    public void setPost_ilikecnt(int post_ilikecnt) {
        this.post_ilikecnt = post_ilikecnt;
    }

    public int getPost_viewcnt() {
        return post_viewcnt;
    }

    public void setPost_viewcnt(int post_viewcnt) {
        this.post_viewcnt = post_viewcnt;
    }

    @Override
    public String toString() {
        return "PostVO{" +
                "post_index=" + post_index +
                ", mem_id='" + mem_id + '\'' +
                ", post_con='" + post_con + '\'' +
                ", post_photo='" + post_photo + '\'' +
                ", post_date=" + post_date +
                ", post_visible='" + post_visible + '\'' +
                ", post_replycnt=" + post_replycnt +
                ", post_ilikecnt=" + post_ilikecnt +
                ", post_viewcnt=" + post_viewcnt +
                '}';
    }
}
