package kr.or.ddit.emam.post.service;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.vo.PostPhotoDetailVO;
import kr.or.ddit.emam.vo.PostPhotoVO;

import java.util.Collection;

public interface IPostPhotoService {

    /**
     * 게시글 사진 목록을 저장하기 위한 메서드
     * @param parts Part 컬렉션겍체
     * @return 게시글 사진이 저장된 post_photo 정보를 담은 PostPhotoVO 객체
     */
    public PostPhotoVO savePostPhoto(Collection<Part> parts);

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

}
