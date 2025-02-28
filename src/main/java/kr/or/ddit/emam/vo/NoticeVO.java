package kr.or.ddit.emam.vo;

public class NoticeVO {
    private int notice_index;
    private String notice_title;
    private String notice_con;
    private String notice_date;

    public int getNotice_index() {
        return notice_index;
    }

    public void setNotice_index(int notice_index) {
        this.notice_index = notice_index;
    }

    public String getNotice_title() {
        return notice_title;
    }

    public void setNotice_title(String notice_title) {
        this.notice_title = notice_title;
    }

    public String getNotice_con() {
        return notice_con;
    }

    public void setNotice_con(String notice_con) {
        this.notice_con = notice_con;
    }

    public String getNotice_date() {
        return notice_date;
    }

    public void setNotice_date(String notice_date) {
        this.notice_date = notice_date;
    }
}
