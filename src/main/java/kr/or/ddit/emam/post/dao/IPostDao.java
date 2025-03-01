package kr.or.ddit.emam.post.dao;

import kr.or.ddit.emam.vo.PostVO;
import oracle.jdbc.proxy.annotation.Post;

import java.util.List;

public interface IPostDao {
    //게시글 작성하기
    public int insertPost(PostVO postVo);

    //게시글 조회
    public PostVO selectPost(int num);

    //게시글 전체 조회
    public List<PostVO> selectAllPost();

    //게시글 삭제
    public int deletePost(int num);
    
    //게시글 수정
    public int updatePost(PostVO postVo);

    //게시글에 정보 가져오기
    public PostVO getPost(int num);
}
