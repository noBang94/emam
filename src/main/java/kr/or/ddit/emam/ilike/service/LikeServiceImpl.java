package kr.or.ddit.emam.ilike.service;

import kr.or.ddit.emam.ilike.dao.ILikeDao;
import kr.or.ddit.emam.ilike.dao.LikeDaoImpl;
import kr.or.ddit.emam.vo.ILikeVO;

public class LikeServiceImpl implements ILikeService{

    private ILikeDao dao;
    private static ILikeService service;
    private LikeServiceImpl(){dao = LikeDaoImpl.getInstance();}

    public static ILikeService getInstance(){
        if(service == null){service = new LikeServiceImpl();}
        return service;
    }

    @Override
    public int likeCheck(ILikeVO ILikeVO) {return dao.likeCheck(ILikeVO);}

    @Override
    public int insertILike(ILikeVO ILikeVO) {return dao.insertILike(ILikeVO);}

    @Override
    public int deleteILike(ILikeVO ILikeVO) {return dao.deleteILike(ILikeVO);}

    @Override
    public int countLike(String postindex) {return dao.countLike(postindex);}
}
