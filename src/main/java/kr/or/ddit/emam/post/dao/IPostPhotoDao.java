package kr.or.ddit.emam.post.dao;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;
import kr.or.ddit.emam.vo.PostPhotoVO;

import java.util.Collection;
import java.util.List;

public interface IPostPhotoDao {


    /**
     * 게시글 사진을 저장
     * @param postPhotoVO
     * @return
     */
    public int insertPostPhoto(PostPhotoVO postPhotoVO);

    /**
     * 게시글 사진 세부정보 저장
     * @param postPhotoDetailVO
     * @return
     */
    public int insertPostPhotoDetail(PostPhotoDetailVO postPhotoDetailVO);

    /**
     * 게시글 사진 조회
     * @param postPhotoVO
     * @return
     */
    public PostPhotoVO getPostPhoto(PostPhotoVO postPhotoVO);

    /**
     * 게시글 사진 상세 조회
     * @param postPhotoDetailVO
     * @return
     */
    public PostPhotoDetailVO getPostPhotoDetail(PostPhotoDetailVO postPhotoDetailVO);

    /**
     * 게시글에 대한 사진 리스트 조회
     * @param photoIndex
     * @return
     */
    public List<PostPhotoDetailVO> getPhotoList(int photoIndex);
}
