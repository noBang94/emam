package kr.or.ddit.emam.vo;

import java.util.Date;

public class ReplyVO {

    private int reply_index;
    private int post_index;
    private Integer reply_parentreplyindex; // Integer 타입으로 변경 (NULL 값 허용)
    private String mem_id;
    private String reply_con;

    public String getReply_con() {
        return reply_con;
    }

    public void setReply_con(String reply_con) {
        this.reply_con = reply_con;
    }

    public Date getReply_date() {
        return reply_date;
    }

    public void setReply_date(Date reply_date) {
        this.reply_date = reply_date;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public int getPost_index() {
        return post_index;
    }

    public void setPost_index(int post_index) {
        this.post_index = post_index;
    }

    public int getReply_index() {
        return reply_index;
    }

    public void setReply_index(int reply_index) {
        this.reply_index = reply_index;
    }

    private Date reply_date;

    public Integer getReply_parentreplyindex() {
        return reply_parentreplyindex;
    }

    public void setReply_parentreplyindex(Integer reply_parentreplyindex) {
        this.reply_parentreplyindex = reply_parentreplyindex;
    }

}