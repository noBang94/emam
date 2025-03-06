package kr.or.ddit.emam.vo;

public class UsersettingsVO {
    private String mem_id; //회원ID
    private int set_friend; //친구신청알림여부 (0=NO / 1=YES)
    private int set_ilike; //좋아요알림여부
    private int set_reply; //댓글알림여부
    private int set_chat; //채팅알림여부
    private int set_bir; //생일공개여부

    public String getMem_id() { return mem_id; }
    public void setMem_id(String mem_id) { this.mem_id = mem_id; }

    public int getSet_friend() { return set_friend; }
    public void setSet_friend(int set_friend) { this.set_friend = set_friend;}

    public int getSet_ilike() { return set_ilike; }
    public void setSet_ilike(int set_ilike) { this.set_ilike = set_ilike; }

    public int getSet_reply() { return set_reply; }
    public void setSet_reply(int set_reply) { this.set_reply = set_reply; }

    public int getSet_chat() { return set_chat; }
    public void setSet_chat(int set_chat) { this.set_chat = set_chat; }

    public int getSet_bir() { return set_bir; }
    public void setSet_bir(int set_bir) { this.set_bir = set_bir; }
}
