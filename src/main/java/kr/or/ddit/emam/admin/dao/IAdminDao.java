package kr.or.ddit.emam.admin.dao;

import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public interface IAdminDao {
    public AdminVO getLoginAdmin(AdminVO adminVo);
    int getTotalMemberCount(String searchId);
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize);
    public int deleteMember(String memId);

    public NoticeVO getNotice(int noticeIndex);
    public int insertNotice(NoticeVO noticeVO);
    public int updateNotice(NoticeVO noticeVO);
    public List<NoticeVO> selectAllNotice(String getNotice);
    public int deleteNotice(int noticeIndex);
    public List<InquiryVO> getInquiryList();
    public InquiryVO getInquiryDetail(int inquiryIndex);
    public int updateInquiryComment(InquiryVO inquiry);

}
