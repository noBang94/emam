package kr.or.ddit.emam.vo;

public class PageVO {
    private int currentPage = 1;

    private int start; //표시될 게시글 번호 시작
    private int end; //표시될 게시글 번호 끝

    private  int startPage; //페이지 번호 시작
    private int endPage; //페이지 번호 끝
    private int totalPage; //전체 페이지 수
    private int count;

    private static int perList = 20; // 한 페이지에 보여줄 게시글 수
    private static int perPage = 5;	// 한 페이지에 보여줄 페이지 수

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public static int getPerList() {
        return perList;
    }

    public static void setPerList(int perList) {
        PageVO.perList = perList;
    }

    public static int getPerPage() {
        return perPage;
    }

    public static void setPerPage(int perPage) {
        PageVO.perPage = perPage;
    }
}
