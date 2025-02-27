package kr.or.ddit.emam.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class ReportVO {
    private int reportId;
    private String toId;
    private String fromId;
    private String reportContent;
    private String reportType;
    private String reportPath;
    private Date reportDate; // 신고 하는날 타입 날짜로 지정 해야함 수정 예정
    private String reportStatus;
    private Date reportProdate; // 신고 응답하는 날 타입 날짜로 지정 해야함 수정 예정
    private String reportPhoto;

    /*
    public ReportVO(String toId, String reportContent, String reportType, String reportPhoto) {
        this.toId = toId;
        this.reportContent = reportContent;
        this.reportType = reportType;
        this.reportPhoto = reportPhoto;
    }
    */

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId;
    }

    public String getFromId() {
        return fromId;
    }

    public void setFromId(String fromId) {
        this.fromId = fromId;
    }

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public String getReportPath() {
        return reportPath;
    }

    public void setReportPath(String reportPath) {
        this.reportPath = reportPath;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public String getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(String reportStatus) {
        this.reportStatus = reportStatus;
    }

    public Date getReportProdate() {
        return reportProdate;
    }

    public void setReportProdate(Date reportProdate) {
        this.reportProdate = reportProdate;
    }

    public String getReportPhoto() {
        return reportPhoto;
    }

    public void setReportPhoto(String reportPhoto) {
        this.reportPhoto = reportPhoto;
    }
}