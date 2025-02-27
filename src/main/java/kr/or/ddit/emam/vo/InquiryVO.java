package kr.or.ddit.emam.vo;

import java.time.LocalDate;

public class InquiryVO {
    private int inquiry_index; //문의번호
    private String mem_id; //회원ID (문의자)
    private String inquiry_title; //문의제목
    private String inquiry_con; //문의내용
    private LocalDate inquiry_date; //문의일시
    private boolean inquiry_ispublic; //문의공개여부

    private long inquiry_photo = -1; //문의사진

    private MemberVO memberVo; //회원VO (문의자VO)

    public int getInquiry_index() {
        return inquiry_index;
    }

    public void setInquiry_index(int inquiry_index) {
        this.inquiry_index = inquiry_index;
    }

    public String getMem_id() { return mem_id; }

    public void setMem_id(String mem_id) { this.mem_id = mem_id; }

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

    public LocalDate getInquiry_date() { return inquiry_date; }

    public void setInquiry_date(LocalDate inquiry_date) { this.inquiry_date = inquiry_date; }

    public boolean getInquiry_ispublic() {
        return inquiry_ispublic;
    }

    public void setInquiry_ispublic(boolean inquiry_ispublic) {
        this.inquiry_ispublic = inquiry_ispublic;
    }

    public long getInquiry_photo() {
        return inquiry_photo;
    }

    public void setInquiry_photo(long inquiry_photo) {
        this.inquiry_photo = inquiry_photo;
    }

    public MemberVO getMemberVo() {
        return memberVo;
    }

    public void setMemberVo(MemberVO memberVo) {
        this.memberVo = memberVo;
    }
}
