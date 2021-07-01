/*
* [ 수정일자 ][수정자] 내용
* [2012-02-07][심동현] EHR 연결해서 근태현황을 가져오자
*/
package common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;

import common.VacDTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;
import java.sql.Connection;





public class VacDAO extends CommonDAO {
    public VacDAO() {
		super(); 
    }
    
    //게시물 리스트 조회시
    public ArrayList list(VacDTO entity, String where_sql,int requestedPage,int pageSize ,String v_login_id,String v_dptcd,Connection conn) throws SQLException {
        
    	java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

		Calendar c = Calendar.getInstance();
		
		int day = c.get(java.util.Calendar.DAY_OF_WEEK);
		
		int plusNum = 0;
		
		if(day==6){
			plusNum=3;	//6이 금요일 +3 = 월
		}else if(day==7){
			plusNum=2;	//7이 토요일 +2 = 월
		}else{
			plusNum=1;	//나머지는 모두 다음날 
		}
		
		
		//String[] weekDay={"일","월","화","수","목","금","토"};
		//System.out.println("day_of_week>>" + java.util.Calendar.DAY_OF_WEEK);
		//System.out.println("DAY>" + day);, 7이 토요일 +1
		//System.out.println("DAte" + weekDay[day-1]);

		
        try {
			/*PagingHelper helper = new PagingHelper(pageSize, 10);	// 여기는 타는데욤.
			helper.setCurpage(requestedPage);
			helper.setTotalcount(150);			//여기 데이터 전체의 행수가 들어가야 하는데..움..;
			helper.setPageNav();*/
        	
			//근태현황 조회 조회
			sql.append("SELECT B.ENO_NO,                                                                 \n")
			   .append("       B.ENO_NM,                                                                 \n")
			   .append("       B.JOB_CD,                                                                 \n")
			   
			   
			   .append("       	 CASE WHEN B.JOB_CD = '700' THEN '사원'	 								\n")
			   .append("       	      WHEN B.JOB_CD = '890' THEN '사원'	 								\n")			   
			   .append("       	  ELSE ASNHR.SF_GET_COMMNAME('01','A2',B.JOB_CD) END AS JOB_NM,			\n")


			 //.append("       SF_GET_COMMNAME('01','A2',B.JOB_CD) AS JOB_NM,                            \n")
			   .append("       B.DPT_CD,                                                                 \n")
			   .append("       SF_GET_DPTNAME('01','A4',B.DPT_CD) AS DPT_NM,                             \n")
			   .append("       LV AS DAY,                                                  				 \n")//-- 날짜 
			   .append("       CASE WHEN COL_NEW = 'E' THEN '출장'                                       \n")
			   .append("            WHEN COL_NEW = 'F' THEN '교육'                                   	 \n")
			   .append("            WHEN COL_NEW = 'G' THEN '훈련'                                   	 \n")
			   .append("            WHEN COL_NEW = 'H' THEN '연차'                                       \n")
			   .append("            WHEN COL_NEW = 'I' THEN '경조휴가'                                   \n")
			   .append("            WHEN COL_NEW = 'P' THEN '오전반차'                                   \n")
			   .append("            WHEN COL_NEW = 'R' THEN '오후반차'                                   \n")		      
			   .append("            WHEN COL_NEW = 'M' THEN '연차'                                       \n")
			   .append("            ELSE '정상'                                                          \n")
			   .append("            END  AS VAC,                                                         \n")
			   .append("       TO_CHAR(TO_DATE(PIS_YMD,'YYYYMMDD'),'dy') AS DY							 \n")
			   .append(" FROM                                                                            \n")
			   .append("         (                                                                       \n")
			   .append("          SELECT ENO_NO,                                                         \n")
			   .append("                     ENO_NM,                                                     \n")
			   .append("                     DPT_CD,                                                     \n")
			   .append("                     LV,                                                         \n")
			   .append("                     PIS_YY || PIS_MM || lpad(lv, 2, '0') AS PIS_YMD,            \n")
			   .append("                     DECODE(lv,1,AT1_CD,                                         \n")
			   .append("                                           2,AT2_CD,                             \n")
			   .append("                                           3,AT3_CD,                             \n")
			   .append("                                           4,AT4_CD,                             \n")
			   .append("                                           5,AT5_CD,                             \n")
			   .append("                                           6,AT6_CD,                             \n")
			   .append("                                           7 , AT7_CD,                           \n")
			   .append("                                           8 , AT8_CD,                           \n")
			   .append("                                           9 , AT9_CD,                           \n")
			   .append("                                           10, AT10_CD,                          \n")
			   .append("                                           11, AT11_CD,                          \n")
			   .append("                                           12, AT12_CD,                          \n")
			   .append("                                           13, AT13_CD,                          \n")
			   .append("                                           14, AT14_CD,                          \n")
			   .append("                                           15, AT15_CD,                          \n")
			   .append("                                           16, AT16_CD,                          \n")
			   .append("                                           17, AT17_CD,                          \n")
			   .append("                                           18, AT18_CD,                          \n")
			   .append("                                           19, AT19_CD,                          \n")
			   .append("                                           20, AT20_CD,                          \n")
			   .append("                                           21, AT21_CD,                          \n")
			   .append("                                           22, AT22_CD,                          \n")
			   .append("                                           23, AT23_CD,                          \n")
			   .append("                                           24, AT24_CD,                          \n")
			   .append("                                           25, AT25_CD,                          \n")
			   .append("                                           26, AT26_CD,                          \n")
			   .append("                                           27, AT27_CD,                          \n")
			   .append("                                           28, AT28_CD,                          \n")
			   .append("                                           29, AT29_CD,                          \n")
			   .append("                                           30, AT30_CD,                          \n")
			   .append("                                           31, AT31_CD                           \n")
			   .append("                            ) col_new                                            \n")
			   .append("            FROM                                                                 \n")
			   .append("         (                                                                       				\n")
			   .append("         SELECT B.ENO_NM, A.*                                                    				\n")
			   .append("         FROM T_DI_DILIGENCE A,T_CM_PERSON B                                     				\n")
			   .append("         WHERE  A.DPT_CD = B.DPT_CD                                              				\n")
			   .append("         AND    PIS_YY || PIS_MM >= substr(TO_CHAR((SYSDATE), 'YYYYMMDD' ), 1, 6)  				\n")
			   .append("         AND    PIS_YY || PIS_MM <= substr(TO_CHAR((SYSDATE)+"+plusNum+", 'YYYYMMDD' ),1,6) 	\n")
			   .append("         AND    A.ENO_NO = B.ENO_NO                                              				\n")
			   .append("         AND    B.DPT_CD = ( SELECT B.DPT_CD                                   					\n")
			   .append("                     		   FROM T_CM_PERSON A, T_CM_DEPT B               					\n")
			   .append("         					  WHERE A.DPT_CD = B.DPT_CD 										\n")
			   .append("								AND B.CD_GBN = 'A4' AND A.ENO_NO = ? )          				\n")
			   .append("         )                                                                       				\n")
			   .append("         ,(SELECT LEVEL lv FROM dual CONNECT BY LEVEL <= 31)                     				\n")
			   .append(" ) A,                                                                            				\n")
			   .append(" T_CM_PERSON B,                                                                  				\n")
			   .append(" T_CM_DEPT C,                                                            						\n")//-- 부서 
			   .append(" T_CM_DEPT D                                                         							\n")//-- 지역본부 
			   .append(" WHERE   A.DPT_CD = C.DPT_CD  																	\n")
			   .append(" AND     A.ENO_NO = B.ENO_NO                                      								\n")
			   .append(" AND     C.UPDPT_CD = D.DPT_CD                                    								\n")
			   .append(" AND     PIS_YMD >= substr(TO_CHAR((SYSDATE), 'YYYYMMDD' ),1,8)    								\n")
			   .append(" AND     PIS_YMD <= substr(TO_CHAR((SYSDATE)+"+plusNum+", 'YYYYMMDD' ),1,8)  					\n")
			   .append(" AND     COL_NEW NOT IN ('W','Y')  																\n")
			   .append(" ORDER BY LV, JOB_CD, ENO_NO       																\n");


			pstmt =  new PreparedStatement(conn,sql.toString());
			
			pstmt.setString(1, v_login_id);	//'C830' --기획홍보부   
			
			//sales.common.StringUtil.printMsg("사번",v_login_id,this);
			//sales.common.StringUtil.printMsg("쿼리",sql.toString(),this);

        	rs = pstmt.executeQuery();
        	
	        while(rs.next()) {
	            data = new BaseDataClass();
	            data.setValues(rs);
	            arrBeans.add(data);
	        }
	        //System.out.println(sql.toString());

	    }catch(Exception e){
	    	e.printStackTrace();
	        LogUtil.error(e);
	    }finally{
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	    }
    return arrBeans;
    }


}
