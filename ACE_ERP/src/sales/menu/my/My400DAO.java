/*
 * ����¡ ó�� : 2008-01-18 �ɵ���
 * 
 */
package sales.menu.my;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;

import sales.menu.my.My400DTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;






public class My400DAO extends CommonDAO {
    public My400DAO() {
		super(); 
    }
    
    //�Խù� ����Ʈ ��ȸ��
    public ArrayList list(My400DTO entity, String where_sql,int requestedPage,int pageSize ,String v_login_id,String v_login_name,Connection conn) throws SQLException {
        
    	java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;
        
		//System.out.println("requestedPage!!!!!!--->" + requestedPage);
		//System.out.println("pageSize--->" + pageSize);
		//System.out.println("�˻� ������--->" + entity.getWhereSql());
		//System.out.println("v_login_id!!!!!!--->" + v_login_id);
		//System.out.println("v_login_name!!!!!!--->" + v_login_name);
		//System.out.println("v_login_nm!!!!!!--->" + v_login_name);
		
        int chk_page = requestedPage - 1;
		
        try {
			/*PagingHelper helper = new PagingHelper(pageSize, 10);	// ����� Ÿ�µ���.
			helper.setCurpage(requestedPage);
			helper.setTotalcount(150);			//���� ������ ��ü�� ����� ���� �ϴµ�..��..;
			helper.setPageNav();*/
        	
        	//sales.common.StringUtil.printMsg("����",sql.toString(),this);

			// ����¡ ó��
			// �������������� �α� ����ڰ� ���� ������ ������.20100520_�ڰ汹
			/*if(chk_page > 0){	//1�������� �ƴ� ���
				sql.append("SELECT ");
				sql.append(" V1.AP_M_SID ");
				sql.append(" ,SALES.FN_DETAIL_NM('AP001',V1.DOC_GU) AS DOC_GU_NM ");
				sql.append(" ,SALES.FN_LOGIN_NM(V1.I_EMPNO) AS I_EMPNM ");
				sql.append(" ,SUBSTRING(CHAR(V1.I_DATE), 3,8) AS I_DATE");
				sql.append("  FROM COMMON.V_APPROVE V1 ");
				sql.append(" WHERE V1.NOW_EMPNO = ? ");
				sql.append("  AND V1.AP_M_SID NOT IN 	");
				sql.append("	  (SELECT AP_M_SID FROM( ");
				sql.append("		   SELECT AP_M_SID FROM COMMON.V_APPROVE WHERE NOW_EMPNO='6080002' ");
				sql.append("			ORDER BY AP_M_SID DESC ");
				sql.append("			FETCH FIRST "+((requestedPage-1) * pageSize)+" ROWS ONLY) AS TMP ");
				sql.append("	  ) ");
				sql.append("ORDER BY V1.AP_M_SID DESC ");
				sql.append("FETCH FIRST "+ pageSize +" ROWS ONLY ");
        
			} else { //1�������� ��*/
        		sql.append("SELECT X.ap_m_sid, X.doc_gu_nm, X.I_empnm, X.I_Date FROM ( ");
				sql.append("SELECT RowNum as Rnum, ");
				sql.append(" V1.AP_M_SID ");
				sql.append(" ,SALES.FN_DETAIL_NM('AP001',V1.DOC_GU) AS DOC_GU_NM ");
				sql.append(" ,SALES.FN_LOGIN_NM(V1.I_EMPNO) AS I_EMPNM ");
				sql.append(" ,TO_CHAR(V1.I_DATE, 'YYMMDD') AS I_DATE");
				sql.append("  FROM COMMON.V_APPROVE V1 ");
				sql.append(" WHERE V1.NOW_EMPNO = ? ");
				sql.append("ORDER BY V1.AP_M_SID DESC ");
				sql.append(" ) X  WHERE X.Rnum > "+ (requestedPage-1)*pageSize +" and X.RNum <="+ requestedPage*pageSize );
			//}     
				//System.out.println("My400DAO==="+ sql.toString());
			pstmt =  new PreparedStatement(conn,sql.toString());
			pstmt.setString(1, v_login_id);
        	//System.out.println("����--->" + entity.getBrd_gu());

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
