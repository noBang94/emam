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

    // 로그인 하기
    public AdminVO getLoginAdmin(AdminVO adminVo) {
        return dao.getLoginAdmin(adminVo);
    }

    @Override
    public int getTotalMemberCount(String searchId) {
        return dao.getTotalMemberCount(searchId);
    }

    @Override
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize) {
        return dao.getMemberList(memberVo, page, pageSize);
    }

    @Override
    public int deleteMember(String memId) {
        return dao.deleteMember(memId);
    }

    @Override

    public NoticeVO getNotice(int noticeIndex) {
        return dao.getNotice(noticeIndex);
    }

    @Override
    public int insertNotice(NoticeVO noticeVO) {
        return dao.insertNotice(noticeVO);
    }

    @Override
    public int updateNotice(NoticeVO noticeVO) {
        return dao.updateNotice(noticeVO);
    }

    @Override
    public List<NoticeVO> selectAllNotice(String getNotice) {
        return dao.selectAllNotice(getNotice);
    }

    @Override
    public int deleteNotice(int noticeIndex) {
        return dao.deleteNotice(noticeIndex);
    }


    public List<InquiryVO> getInquiryList() {
        return dao.getInquiryList();
    }

    @Override
    public InquiryVO getInquiryDetail(int inquiryIndex) {
        return dao.getInquiryDetail(inquiryIndex);
    }

    @Override
    public int updateInquiryComment(InquiryVO inquiry) {
        return dao.updateInquiryComment(inquiry);
    }
}


