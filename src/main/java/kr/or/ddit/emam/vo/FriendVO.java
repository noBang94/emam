package kr.or.ddit.emam.vo;

public class FriendVO {
    private int friend_index; //친구번호
    private String friend_toid; //친구신청한 회원ID
    private String friend_fromid; //친구신청받은 회원ID
    private String friend_reqdate; //친구신청한 일시
    private String friend_status; //친구상태

    public int getFriend_index() { return friend_index; }

    public void setFriend_index(int friend_index) { this.friend_index = friend_index; }

    public String getFriend_toid() { return friend_toid; }

    public void setFriend_toid(String friend_toid) { this.friend_toid = friend_toid; }

    public String getFriend_fromid() { return friend_fromid; }

    public void setFriend_fromid(String friend_fromid) { this.friend_fromid = friend_fromid; }

    public String getFriend_reqdate() { return friend_reqdate; }

    public void setFriend_reqdate(String friend_reqdate) { this.friend_reqdate = friend_reqdate; }

    public String getFriend_status() { return friend_status; }

    public void setFriend_status(String friend_status) { this.friend_status = friend_status; }
}
