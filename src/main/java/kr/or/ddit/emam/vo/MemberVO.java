package kr.or.ddit.emam.vo;

public class MemberVO {
    /*private String mem_mail;
    private String mem_job;
    private String mem_like;
    private String mem_memorial;
    private String mem_memorialday;
    private int mem_mileage;
    private String mem_delete;
    private String mem_id;
    private String mem_pass;
    private String mem_name;
    private String mem_regno1;
    private String mem_regno2;
    private String mem_bir;
    private String mem_zip;
    private String mem_add1;
    private String mem_add2;
    private String mem_hometel;
    private String mem_comtel;
    private String mem_hp;



    public String getMem_mail() {
        return mem_mail;
    }
    public void setMem_mail(String mem_mail) {
        this.mem_mail = mem_mail;
    }
    public String getMem_job() {
        return mem_job;
    }
    public void setMem_job(String mem_job) {
        this.mem_job = mem_job;
    }
    public String getMem_like() {
        return mem_like;
    }
    public void setMem_like(String mem_like) {
        this.mem_like = mem_like;
    }
    public String getMem_memorial() {
        return mem_memorial;
    }
    public void setMem_memorial(String mem_memorial) {
        this.mem_memorial = mem_memorial;
    }
    public String getMem_memorialday() {
        return mem_memorialday;
    }
    public void setMem_memorialday(String mem_memorialday) {
        this.mem_memorialday = mem_memorialday;
    }
    public int getMem_mileage() {
        return mem_mileage;
    }
    public void setMem_mileage(int mem_mileage) {
        this.mem_mileage = mem_mileage;
    }
    public String getMem_delete() {
        return mem_delete;
    }
    public void setMem_delete(String mem_delete) {
        this.mem_delete = mem_delete;
    }
    public String getMem_id() {
        return mem_id;
    }
    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }
    public String getMem_pass() {
        return mem_pass;
    }
    public void setMem_pass(String mem_pass) {
        this.mem_pass = mem_pass;
    }
    public String getMem_name() {
        return mem_name;
    }
    public void setMem_name(String mem_name) {
        this.mem_name = mem_name;
    }
    public String getMem_regno1() {
        return mem_regno1;
    }
    public void setMem_regno1(String mem_regno1) {
        this.mem_regno1 = mem_regno1;
    }
    public String getMem_regno2() {
        return mem_regno2;
    }
    public void setMem_regno2(String mem_regno2) {
        this.mem_regno2 = mem_regno2;
    }
    public String getMem_bir() {
        return mem_bir;
    }
    public void setMem_bir(String mem_bir) {
        this.mem_bir = mem_bir;
    }
    public String getMem_zip() {
        return mem_zip;
    }
    public void setMem_zip(String mem_zip) {
        this.mem_zip = mem_zip;
    }
    public String getMem_add1() {
        return mem_add1;
    }
    public void setMem_add1(String mem_add1) {
        this.mem_add1 = mem_add1;
    }
    public String getMem_add2() {
        return mem_add2;
    }
    public void setMem_add2(String mem_add2) {
        this.mem_add2 = mem_add2;
    }
    public String getMem_hometel() {
        return mem_hometel;
    }
    public void setMem_hometel(String mem_hometel) {
        this.mem_hometel = mem_hometel;
    }
    public String getMem_comtel() {
        return mem_comtel;
    }
    public void setMem_comtel(String mem_comtel) {
        this.mem_comtel = mem_comtel;
    }
    public String getMem_hp() {
        return mem_hp;
    }
    public void setMem_hp(String mem_hp) {
        this.mem_hp = mem_hp;
    }
    @Override
    public String toString() {
        return "MemberVO [mem_mail=" + mem_mail + ", mem_job=" + mem_job + ", mem_like=" + mem_like + ", mem_memorial="
                + mem_memorial + ", mem_memorialday=" + mem_memorialday + ", mem_mileage=" + mem_mileage
                + ", mem_delete=" + mem_delete + ", mem_id=" + mem_id + ", mem_pass=" + mem_pass + ", mem_name="
                + mem_name + ", mem_regno1=" + mem_regno1 + ", mem_regno2=" + mem_regno2 + ", mem_bir=" + mem_bir
                + ", mem_zip=" + mem_zip + ", mem_add1=" + mem_add1 + ", mem_add2=" + mem_add2 + ", mem_hometel="
                + mem_hometel + ", mem_comtel=" + mem_comtel + ", mem_hp=" + mem_hp + "]";
    }*/

    private String mem_id;
    private String mem_pw;
    private String mem_nickname;
    private String mem_name;
    private String mem_addr;
    private String mem_phone;
    private String mem_bir;
    private String mem_gen;
    private String mem_joindate;

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getMem_pw() {
        return mem_pw;
    }

    public void setMem_pw(String mem_pw) {
        this.mem_pw = mem_pw;
    }

    public String getMem_nickname() {
        return mem_nickname;
    }

    public void setMem_nickname(String mem_nickname) {
        this.mem_nickname = mem_nickname;
    }

    public String getMem_name() {
        return mem_name;
    }

    public void setMem_name(String mem_name) {
        this.mem_name = mem_name;
    }

    public String getMem_addr() {
        return mem_addr;
    }

    public void setMem_addr(String mem_addr) {
        this.mem_addr = mem_addr;
    }

    public String getMem_phone() {
        return mem_phone;
    }

    public void setMem_phone(String mem_phone) {
        this.mem_phone = mem_phone;
    }

    public String getMem_bir() {
        return mem_bir;
    }

    public void setMem_bir(String mem_bir) {
        this.mem_bir = mem_bir;
    }

    public String getMem_gen() {
        return mem_gen;
    }

    public void setMem_gen(String mem_gen) {
        this.mem_gen = mem_gen;
    }

    public String getMem_joindate() { return mem_joindate; }

    public void setMem_joindate(String mem_joindate) { this.mem_joindate = mem_joindate; }

    @Override
    public String toString() {
        return "MemberVO{" +
                "mem_id='" + mem_id + '\'' +
                ", mem_pw='" + mem_pw + '\'' +
                ", mem_nickname='" + mem_nickname + '\'' +
                ", mem_name='" + mem_name + '\'' +
                ", mem_addr='" + mem_addr + '\'' +
                ", mem_phone='" + mem_phone + '\'' +
                ", mem_bir='" + mem_bir + '\'' +
                ", mem_gen='" + mem_gen + '\'' +
                ", mem_joindate='" + mem_joindate + '\'' +
                '}';
    }
}

