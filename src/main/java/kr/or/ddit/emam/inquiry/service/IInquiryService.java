package kr.or.ddit.emam.inquiry.service;

import kr.or.ddit.emam.vo.InquiryVO;
import kr.or.ddit.emam.vo.PageInquiryVO;

import java.util.List;
import java.util.Map;

public interface IInquiryService {
    //문의 작성
    public int insertInquiry(InquiryVO inquiryVo);

    //문의 삭제
    public int deleteInquiry(int num);

    //문의 수정
    public int updateInquiry(InquiryVO inquiryVo);

    //문의 보기
    public InquiryVO getInquiry(int num);

    //문의 리스트 - 검색 포함
    public List <InquiryVO> selectByPage(Map<String, Object> map);

    //전체 문의글 갯수 구하기
    public int totalCount(Map<String, Object> map);

    //페이지별 정보 구하기 (페이지, 제목 검색 키워드, 내 문의 보기 체크 시 현재 로그인한 계정ID)
    public PageInquiryVO pageInquiry(int page, String sword, String myInquiry);
}