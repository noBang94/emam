package kr.or.ddit.emam.vo;

import java.util.List;

public class PostPhotoVO {
    private Long post_photo; //게시글 사진 번호

    //세부 사진 목록
    private List<PostPhotoDetailVO> postPhotoDetailList;

    public List<PostPhotoDetailVO> getPostPhotoDetailList() {
        return postPhotoDetailList;
    }

    public void setPostPhotoDetailList(List<PostPhotoDetailVO> postPhotoDetailList) {
        this.postPhotoDetailList = postPhotoDetailList;
    }

    public Long getPost_photo() {
        return post_photo;
    }

    public void setPost_photo(Long post_photo) {
        this.post_photo = post_photo;
    }

    @Override
    public String toString() {
        return "PostPhotoVO{" +
                "post_photo=" + post_photo +
                ", postPhotoDetailList=" + postPhotoDetailList +
                '}';
    }
}
