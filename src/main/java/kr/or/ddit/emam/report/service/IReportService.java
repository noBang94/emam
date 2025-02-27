package kr.or.ddit.emam.report.service;

import kr.or.ddit.emam.vo.ReportVO;

public interface IReportService {
    //신고하기
    public int insertReport(ReportVO reportVO);
}
