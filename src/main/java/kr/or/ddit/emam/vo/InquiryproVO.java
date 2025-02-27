package kr.or.ddit.emam.vo;

import java.time.LocalDate;

public class InquiryproVO {
    private int inquiry_index;
    private String inquirypro_con;
    private LocalDate inquirypro_date;

    public int getInquiry_index() {
        return inquiry_index;
    }

    public void setInquiry_index(int inquiry_index) {
        this.inquiry_index = inquiry_index;
    }

    public String getInquirypro_con() {
        return inquirypro_con;
    }

    public void setInquirypro_con(String inquirypro_con) {
        this.inquirypro_con = inquirypro_con;
    }

    public LocalDate getInquirypro_date() {
        return inquirypro_date;
    }

    public void setInquirypro_date(LocalDate inquirypro_date) {
        this.inquirypro_date = inquirypro_date;
    }
}
