package kr.or.ddit.emam.member.service;

import kr.or.ddit.emam.member.dao.IMemberDao;
import kr.or.ddit.emam.member.dao.MemberDaoImpl;
import kr.or.ddit.emam.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {

    private IMemberDao dao;
    private static IMemberService  service;

    private MemberServiceImpl() {
        dao = MemberDaoImpl.getInstance();
    }

    public static IMemberService  getInstance() {
        if(service == null)  service = new MemberServiceImpl();

        return service;
    }

    @Override
    public MemberVO getLoginMember(MemberVO memberVo) {
        return dao.getLoginMember(memberVo);
    }

    @Override
    public int insertMember(MemberVO memberVo) {
        return dao.insertMember(memberVo);
    }

    @Override
    public int getMemberIdCount(String memId) {
        return dao.getMemberIdCount(memId);
    }

    @Override
    public MemberVO getMember(String memId) {
        return dao.getMember(memId);
    }

}
