package kr.or.ddit.emam.vo;

public class NotificationVO {
    private int notification_index; //알림번호
    private String notification_toId; //알림수신회원ID
    private String notification_fromId; //알림대상회원ID
    private int notification_target; //알림행위대상번호(게시글번호, 문의번호 등)
    private String notification_type; //알림행위구분
    private String notification_con; //알림내용
    private String notification_date; //알림발생일시
    private int notification_isread; //알림확인여부(0=미확인 1=확인)

    public int getNotification_index() { return notification_index; }
    public void setNotification_index(int notification_index) { this.notification_index = notification_index; }

    public String getNotification_toId() { return notification_toId; }
    public void setNotification_toId(String notification_toId) { this.notification_toId = notification_toId; }

    public String getNotification_fromId() { return notification_fromId; }
    public void setNotification_fromId(String notification_fromId) { this.notification_fromId = notification_fromId;}

    public int getNotification_target() { return notification_target; }
    public void setNotification_target(int notification_target) { this.notification_target = notification_target; }

    public String getNotification_type() { return notification_type; }
    public void setNotification_type(String notification_type) { this.notification_type = notification_type; }

    public String getNotification_con() { return notification_con; }
    public void setNotification_con(String notification_con) { this.notification_con = notification_con; }

    public String getNotification_date() { return notification_date; }
    public void setNotification_date(String notification_date) { this.notification_date = notification_date; }

    public int getNotification_isread() { return notification_isread; }
    public void setNotification_isread(int notification_isread) { this.notification_isread = notification_isread; }
}
