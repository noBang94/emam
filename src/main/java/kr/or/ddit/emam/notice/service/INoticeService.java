package kr.or.ddit.emam.notice.service;

import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public interface INoticeService {

    public NoticeVO getNotice(int noticeIndex);

    public int insertNotice(NoticeVO noticeVO);

    public int updateNotice(NoticeVO noticeVO);

    public List<NoticeVO> selectAllNotice(String getNotice);

    public List<NoticeVO> searchTitle(String searchTitle);

}

