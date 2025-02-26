package kr.or.ddit.emam.vo;

import java.util.List;

public class PostPhotoVO {
    private Long post_photo; //게시글 사진 번호

    //세부 사진 목록
    private List<PostPhotoDetailVO> post_photo_detail;

    public List<PostPhotoDetailVO> getPost_photo_detail() {
        return post_photo_detail;
    }

    public void setPost_photo_detail(List<PostPhotoDetailVO> post_photo_detail) {
        this.post_photo_detail = post_photo_detail;
    }

    public Long getPost_photo() {
        return post_photo;
    }

    public void setPost_photo(Long post_photo) {
        this.post_photo = post_photo;
    }
}
