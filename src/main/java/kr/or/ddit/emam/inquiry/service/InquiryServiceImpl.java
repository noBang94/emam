package kr.or.ddit.emam.inquiry.service;

import kr.or.ddit.emam.inquiry.dao.IInquiryDao;
import kr.or.ddit.emam.inquiry.dao.InquiryDaoImpl;
import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.PageInquiryVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InquiryServiceImpl implements IInquiryService {

    //dao객체
    private IInquiryDao dao;

    //자신의 객체
    private static IInquiryService service;

    //생성자 - dao객체 얻기
    private InquiryServiceImpl() {
        dao = InquiryDaoImpl.getInstance();
    }

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IInquiryService getInstance() {
        if(service == null) service = new InquiryServiceImpl();
        return service;
    }

    //문의 작성
    @Override
    public int insertInquiry(InquiryVO inquiryVo) {
        return dao.insertInquiry(inquiryVo);
    }

    //문의 삭제
    @Override
    public int deleteInquiry(int num) {
        return dao.deleteInquiry(num);
    }

    //문의 수정
    @Override
    public int updateInquiry(InquiryVO inquiryVo) {
        return dao.updateInquiry(inquiryVo);
    }

    //문의 보기
    @Override
    public InquiryVO getInquiry(int num) {
        return dao.getInquiry(num);
    }

    //문의 리스트 - 검색 포함
    @Override
    public List<InquiryVO> selectByPage(Map<String, Object> map) {
        return dao.selectByPage(map);
    }

    //전체 문의글 갯수 구하기
    @Override
    public int totalCount(Map<String, Object> map) {
        return dao.totalCount(map);
    }

    //페이지별 정보 구하기 (페이지, 제목 검색 키워드, 내 문의 보기 체크 시 현재 로그인한 계정ID)
    @Override
    public PageInquiryVO pageInquiry(int page, String sword, String myInquiry) {
        //전체 문의글 갯수 구하기
        Map<String, Object> map = new HashMap<>();
        map.put("sword", sword);
        map.put("myInquiry", myInquiry);
        int count = this.totalCount(map);

        //전체 페이지수 구하기
        int totalPage = (int)Math.ceil((double)count / PageInquiryVO.getPerList());
        if(page > totalPage ) page= totalPage;

        //start, end 구하기
        int start = (page - 1) * PageInquiryVO.getPerList() + 1;
        int end = start + PageInquiryVO.getPerList() - 1;
        if(end > count) end = count;

        //시작페이지, 끝페이지 구하기
        int perPage = PageInquiryVO.getPerPage();
        int startPage = ((page - 1) / perPage * perPage) + 1;
        int endPage = startPage + perPage- 1;
        if(endPage > totalPage)  endPage = totalPage;

        PageInquiryVO pageInquiryVo = new PageInquiryVO();
        pageInquiryVo.setCurrentPage(page);
        pageInquiryVo.setStart(start);
        pageInquiryVo.setEnd(end);

        pageInquiryVo.setStartPage(startPage);
        pageInquiryVo.setEndPage(endPage);
        pageInquiryVo.setTotalPage(totalPage);

        return pageInquiryVo;
    }

}
