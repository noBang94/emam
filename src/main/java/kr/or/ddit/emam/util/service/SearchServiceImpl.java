package kr.or.ddit.emam.util.service;

import kr.or.ddit.emam.util.dao.ISearchDao;
import kr.or.ddit.emam.util.dao.SearchDaoImpl;
import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;

public class SearchServiceImpl implements ISearchService {
    private ISearchDao dao;
    private static ISearchService service;

    private SearchServiceImpl() {
        dao = SearchDaoImpl.getInstance();
    }

    public static ISearchService getInstance() {
        if(service == null)  service = new SearchServiceImpl();
        return service;
    }

    @Override
    public List<MemberVO> getMemberListById(String searchId) {
        return dao.getMemberListById(searchId);
    }
}