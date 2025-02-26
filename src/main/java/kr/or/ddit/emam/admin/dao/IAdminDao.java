package kr.or.ddit.emam.admin.dao;

import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;

public interface IAdminDao {
    public AdminVO getLoginAdmin(AdminVO adminVo);
    int getTotalMemberCount(String searchId);
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize);
    public int deleteMember(String memId);
}
