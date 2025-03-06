package kr.or.ddit.emam.admin.service;

import kr.or.ddit.emam.admin.dao.AdminDaoImpl;
import kr.or.ddit.emam.admin.dao.IAdminDao;
import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public class AdminServiceImpl implements IAdminService {
    private IAdminDao dao;
    private static IAdminService service;

    private AdminServiceImpl() {
        dao = AdminDaoImpl.getInstance();
    }

    public static IAdminService getInstance() {
        if(service == null)  service = new AdminServiceImpl();
        return service;
    }

    // 관리자 로그인
    public AdminVO getLoginAdmin(AdminVO adminVo) {
        return dao.getLoginAdmin(adminVo);
    }

    // 관리자 회원관리
    public int getTotalMemberCount(String searchId) {
        return dao.getTotalMemberCount(searchId);
    }
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize) {
        return dao.getMemberList(memberVo, page, pageSize);
    }
    public int deleteMember(String memId) {
        return dao.deleteMember(memId);
    }

    //관리자 공지사항
    public NoticeVO getNotice(int noticeIndex) {
        return dao.getNotice(noticeIndex);
    }
    public int insertNotice(NoticeVO noticeVO) {
        return dao.insertNotice(noticeVO);
    }
    public int updateNotice(NoticeVO noticeVO) {
        return dao.updateNotice(noticeVO);
    }
    public List<NoticeVO> selectAllNotice(String getNotice) {
        return dao.selectAllNotice(getNotice);
    }
    @Override
    public List<NoticeVO> searchTitle(String searchTitle) {
        return dao.searchTitle(searchTitle);
    }
    @Override
    public int deleteNotice(int noticeIndex) {
        return dao.deleteNotice(noticeIndex);
    }

    //관리자 문의사항
    public List<InquiryVO> getInquiryList() {
        return dao.getInquiryList();
    }
    public InquiryVO getInquiryDetail(int inquiryIndex) {
        return dao.getInquiryDetail(inquiryIndex);
    }
    public int updateInquiryComment(InquiryVO inquiry) {
        return dao.updateInquiryComment(inquiry);
    }
    public List<InquiryVO> searchInquiryList(String searchTitle) {
        return dao.searchInquiryList(searchTitle);
    }

    // 관리자 메인화면 (대시보드)
    public int getTotalPosts() {
        return dao.getTotalPosts();
    }

    public int getTotalReports() {
        return dao.getTotalReports();
    }

    @Override
    public int getUnprocessedReportsCount() {
        return dao.getUnprocessedReportsCount();
    }

    @Override
    public int getUnprocessedInquiriesCount() {
        return dao.getUnprocessedInquiriesCount();
    }

    //

    @Override
    public int getNewMembersCount() {
        return dao.getNewMembersCount();
    }

    @Override
    public int getNewPostsCount() {
        return dao.getNewPostsCount();
    }

    @Override
    public int getNewReportsCount() {
        return dao.getNewReportsCount();
    }

    @Override
    public int getNewInquiriesCount() {
        return dao.getNewInquiriesCount();
    }
}