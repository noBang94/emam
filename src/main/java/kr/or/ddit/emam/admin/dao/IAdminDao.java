package kr.or.ddit.emam.admin.dao;

import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public interface IAdminDao {
    //관리자 로그인
    public AdminVO getLoginAdmin(AdminVO adminVo);

    //관리자 회원관리
    int getTotalMemberCount(String searchId);
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize);
    public int deleteMember(String memId);

    // 관리자 공지사항
    public NoticeVO getNotice(int noticeIndex);
    public int insertNotice(NoticeVO noticeVO);
    public int updateNotice(NoticeVO noticeVO);
    public List<NoticeVO> selectAllNotice(String getNotice);
    public List<NoticeVO> searchTitle(String searchTitle);
    public int deleteNotice(int noticeIndex);

    //관리자 문의사항
    public List<InquiryVO> getInquiryList();
    public InquiryVO getInquiryDetail(int inquiryIndex);
    public int updateInquiryComment(InquiryVO inquiry);
    public List<InquiryVO> searchInquiryList(String searchTitle);

    //관리자 메인화면
    public int getTotalPosts();
    public int getTotalReports();
    public int getUnprocessedReportsCount();
    public int getUnprocessedInquiriesCount();

    public int getNewMembersCount();
    public int getNewPostsCount();
    public int getNewReportsCount();
    public int getNewInquiriesCount();
}
;