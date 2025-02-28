package kr.or.ddit.emam.vo;

import java.time.LocalDate;
import java.util.Date;

public class InquiryVO {
    private int inquiry_index; //문의번호
    private String mem_id; //회원ID (문의자)
    private String inquiry_title; //문의제목
    private String inquiry_con; //문의내용
    private String inquiry_date; //문의일시
    private int inquiry_ispublic;
    private long inquiry_photo = -1; //문의사진
    private Date inquiry_comment_date;
    private String inquiry_comment;
    private MemberVO memberVo;

    public MemberVO getMemberVo() {
        return memberVo;
    }

    public void setMemberVo(MemberVO memberVo) {
        this.memberVo = memberVo;
    }

    public int getInquiry_index() {
        return inquiry_index;
    }

    public void setInquiry_index(int inquiry_index) {
        this.inquiry_index = inquiry_index;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getInquiry_title() {
        return inquiry_title;
    }

    public void setInquiry_title(String inquiry_title) {
        this.inquiry_title = inquiry_title;
    }

    public String getInquiry_con() {
        return inquiry_con;
    }

    public void setInquiry_con(String inquiry_con) {
        this.inquiry_con = inquiry_con;
    }

    public String getInquiry_date() {
        return inquiry_date;
    }

    public void setInquiry_date(String inquiry_date) {
        this.inquiry_date = inquiry_date;
    }

    public int getInquiry_ispublic() {
        return inquiry_ispublic;
    }

    public void setInquiry_ispublic(int inquiry_ispublic) {
        this.inquiry_ispublic = inquiry_ispublic;
    }

    public long getInquiry_photo() {
        return inquiry_photo;
    }

    public void setInquiry_photo(long inquiry_photo) {
        this.inquiry_photo = inquiry_photo;
    }

    public Date getInquiry_comment_date() {
        return inquiry_comment_date;
    }

    public void setInquiry_comment_date(Date inquiry_comment_date) {
        this.inquiry_comment_date = inquiry_comment_date;
    }

    public String getInquiry_comment() {
        return inquiry_comment;
    }

    public void setInquiry_comment(String inquiry_comment) {
        this.inquiry_comment = inquiry_comment;
    }
}