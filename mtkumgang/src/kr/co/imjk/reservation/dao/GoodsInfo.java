/*
 * Created on 2006. 9. 7.
 * 
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.reservation.bean.Goods_bean;

/**
 * @author IMJK R&D  이소연 대리
 *
 * 2015-03-18 수정 심동현
 */
public class GoodsInfo  extends DAOHome{  

	
    /**
     * 게시물 갯수
     * @param part String 검색할 디비컬럼
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author IMJK R&D  이소연 대리
     */
	public int getCount(String part) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		String query = "";
        String subSql =" ";
		int totalCount = 0;
		
		if(!part.equals("")){
			subSql = " AND G_CORNER ='"+part+"'\n";
		}
		query = new StringBuffer()
			.append(" SELECT COUNT(*) AS TOTAL   \n")
			.append(" FROM ASAN.NORTHGOODS       \n")
			.append(" WHERE IDX > 0              \n")
			.append(subSql).toString(); 
		
		try {
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
			rs = pstmt.executeQuery();

			if(rs.next()){
				totalCount = rs.getInt("TOTAL");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return totalCount;

	 }
	
	
	
    /**
     * 리스트
     * @param part 검색할 디비컬럼
     * @return rtnValue int 총갯수
     * @throws DbException
     * @throws Exception
     * @author IMJK R&D  이소연 대리
     */
    public Goods_bean[] getGoodsList(int requestedPage, int pageSize, String part) throws  Exception{
       
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Goods_bean bean = null;
        Collection list = null; 
        String subSql =" ";
        String tempPart = "";
        StringBuffer query = null;
        int chk_page = requestedPage-1;
        
		if(!part.equals("")){
			subSql = " AND G_CORNER ='"+part+"'\n";
		}
		
		StringBuffer sql = new StringBuffer();
        sql.append("SELECT * FROM ( \n");
        sql.append(" SELECT RowNum as RNUM, X.* FROM ( \n");        
			sql.append(" SELECT IDX, G_CORNER, G_IMGFILE , G_NAME , G_STD , G_PRICE \n");
			sql.append(" FROM ASAN.NORTHGOODS WHERE IDX > 0 \n");
			sql.append(  subSql);
			sql.append(" ORDER BY IDX DESC \n");
	        sql.append("      ) X \n");
	    sql.append(" )X1 \n");
        sql.append("WHERE X1.RNum > "+ (requestedPage-1)*pageSize +" and X1.RNum <= "+ requestedPage*pageSize +" \n");
        
        try {
        	
        	//System.out.println("--------------------------"+sql);
        	
        	pstmt = dbconn.prepareStatement(sql.toString());
           
            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Goods_bean());
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Goods_bean [])list.toArray(new Goods_bean[0]);        
    }
    
    
	 /**
     * 조회수증가
     * @param idx 일련번호
     * @return exe int 1:성공 , 0:실패
     * @throws DbException
     * @throws Exception
     * @author IMJK R&D  이소연 대리
     */
	 public void updateReadnum(int idx) throws DbException , Exception {
		 Connection dbconn = getConnection();	
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;        
	     int result  = 0;
	
			StringBuffer sql = new StringBuffer();
	
			try {
				sql.append(" UPDATE ASAN.NORTHGOODS  \n");	
				sql.append(" SET G_VIEWCNT = G_VIEWCNT + 1  \n");		
				sql.append(" WHERE IDX = ?  ");		
				
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,idx);
				
				result = pstmt.executeUpdate();
				pstmt.close();
	
			} catch (SQLException e) {
	     	e.printStackTrace();
	         throw new DbException(e.getMessage());
	     }
	 } 
 
 
    /**
     *  상세보기
     * @param idx 일련번호
     * @return Goods_bean []
     * @throws DbException
     * @throws Exception
     * @author IMJK R&D  이소연 대리
     */
	public Goods_bean [] getGoodsView(int idx) 
        throws DbException , Exception 
    {
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Collection list = null;
        
        // SQL
		String query = new StringBuffer()
			.append(" SELECT                                              \n")
			.append(" IDX , G_CORNER , G_NAME , G_STD,	G_PRICE,          \n")
			.append(" G_MAKER, G_FUNCTION , G_ELEMENT, G_USAGE,           \n")
			.append(" G_ETC , G_BIGO , G_IMGFILE, G_DATE, G_VIEWCNT       \n")
            .append(" G_UNIT , G_KIND                                     \n")
			.append(" FROM ASAN.NORTHGOODS                                \n")
			.append("  WHERE IDX = ?			                            ").toString(); 

        try {         
            pstmt = dbconn.prepareStatement(query);
            // 변수 바인딩
            pstmt.setInt(1, idx); 

            // 결과 담기
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Goods_bean());
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Goods_bean [])list.toArray(new Goods_bean[0]);
    } 
 
}