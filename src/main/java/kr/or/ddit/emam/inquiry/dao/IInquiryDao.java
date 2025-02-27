package kr.or.ddit.emam.inquiry.dao;

import kr.or.ddit.emam.vo.InquiryVO;

import java.util.List;
import java.util.Map;

public interface IInquiryDao {
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
}
