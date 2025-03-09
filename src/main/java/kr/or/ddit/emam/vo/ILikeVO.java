package kr.or.ddit.emam.vo;

public class ILikeVO {
    private int post_index;
    private String mem_id;
    private String like_date;

    public ILikeVO(int post_index, String mem_id) {
        this.post_index = post_index;
        this.mem_id = mem_id;
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

    public String getLike_date() {
        return like_date;
    }

    public void setLike_date(String like_date) {
        this.like_date = like_date;
    }
}
