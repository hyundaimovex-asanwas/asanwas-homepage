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
import sales.menu.my.My310DTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;
import sales.org.util.StringUtil;

public class My310DAO extends CommonDAO {
	public My310DAO() {
		super(); 
	}
    
	//�Խù� ����Ʈ ��ȸ��
	public ArrayList list(My310DTO entity, String where_sql,int requestedPage,int pageSize, Connection conn) throws SQLException {
        
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		ArrayList arrBeans = new ArrayList();
		BaseDataClass data = null;
		//System.out.println("requestedPage!!!!!!--->" + requestedPage);
		//System.out.println("pageSize--->" + pageSize);
		//System.out.println("�˻� ������--->" + entity.getWhereSql());
	
		int chk_page = requestedPage - 1;
		try {
			/*PagingHelper helper = new PagingHelper(pageSize, 10);	// ����� Ÿ�µ���.
			helper.setCurpage(requestedPage);
			helper.setTotalcount(150);			//���� ������ ��ü�� ����� ���� �ϴµ�..��..;
			helper.setPageNav();*/
			//sales.common.StringUtil.printMsg("����",sql.toString(),this);
			// ����¡ ó��
			if(chk_page > 0){	//1�������� �ƴ� ���
				sql.append("SELECT BRD_NO,BRD_SUBJECT,BRD_CONTENTS,BRD_PASSWD,BRD_GU,DELYN ");
				sql.append(" ,REPLACE(SUBSTRING(CHAR(brd_cdate),1,10),'-','/')||' '||REPLACE(SUBSTRING(CHAR(brd_cdate),12,5),'.',':') AS BRD_CDATE");
				sql.append(" ,REAL_FILE,BRD_CREATOR,SYS_FILE,REF,REF_STEP,REF_LEVEL,BRD_VIEWCNT ");
				sql.append(" FROM SALES.TMY030   	");
				sql.append("WHERE BRD_GU   = '01' 	");
				sql.append("  AND DELYN    = 'N' 	");
				//sql.append("  AND REF_STEP = 0 		");
				sql.append(where_sql);	//�˻� ������ �κ�			
				sql.append("  AND BRD_NO NOT IN 	");
				sql.append("	  (SELECT BRD_NO FROM( ");
				sql.append("		   SELECT BRD_NO FROM SALES.TMY030 WHERE BRD_GU = '01' AND DELYN = 'N' AND REF_STEP = 0 ");
				sql.append(				where_sql);	//�˻� ������ �κ�			
				sql.append("			ORDER BY REF REF, REF_LEVEL, BRD_CDATE ");
				sql.append("			FETCH FIRST "+((requestedPage-1) * pageSize)+" ROWS ONLY) AS TMP ");
				sql.append("	  ) ");
				sql.append("ORDER BY REF, REF_LEVEL, BRD_CDATE ");
				sql.append("FETCH FIRST "+ pageSize +" ROWS ONLY ");
        
			} else { //1�������� ��
				sql.append("SELECT BRD_NO,BRD_SUBJECT,BRD_CONTENTS,BRD_PASSWD,BRD_GU,DELYN ");
				sql.append(" ,REPLACE(SUBSTRING(CHAR(brd_cdate),1,10),'-','/')||' '||REPLACE(SUBSTRING(CHAR(brd_cdate),12,5),'.',':') AS BRD_CDATE");
				sql.append(" ,REAL_FILE,BRD_CREATOR,SYS_FILE,REF,REF_STEP,REF_LEVEL,BRD_VIEWCNT ");
				sql.append(" FROM SALES.TMY030   	");
				sql.append("WHERE BRD_GU   = '01' 	");
				sql.append("  AND DELYN    = 'N' 	");
				//sql.append("  AND REF_STEP = 0 		");
				sql.append(where_sql);	//�˻� ������ �κ�
				sql.append("ORDER BY REF, REF_LEVEL, BRD_CDATE ");
				sql.append("FETCH FIRST "+ pageSize +" ROWS ONLY ");
			}        	
			pstmt =  new PreparedStatement(conn,sql.toString());
       
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


	//2008-03-14 �߰� by �ɵ��� : �Խù� ��ü ���� ī��Ʈ
	public ArrayList alllist(My310DTO entity, String where_sql,int requestedPage,int pageSize, Connection conn) throws SQLException {
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		ArrayList arrBeans = new ArrayList();
		BaseDataClass data = null;
        
		//System.out.println("requestedPage!!!!!!--->" + requestedPage);
		//System.out.println("pageSize--->" + pageSize);

		int chk_page = requestedPage - 1;
       
		try {
			// ��ü ��� ī��Ʈ
			sql.append("SELECT ");
			sql.append(" count(brd_no) as brd_no ");
			sql.append(" FROM SALES.TMY030   	");
			sql.append("WHERE BRD_GU   = '01' 	");	// 01: ���������̰�
			sql.append("  AND DELYN    = 'N' 	");	// ���� �ƴϰ�
			sql.append("  AND REF_STEP = 0 		"); // step=0 : �Ӹ����� �͵鸸 
			sql.append(where_sql);	//�˻� ������ �κ�
			        	
			pstmt =  new PreparedStatement(conn,sql.toString());
       
			rs = pstmt.executeQuery();
			while(rs.next()) {
				data = new BaseDataClass();
				data.setValues(rs);
				arrBeans.add(data);
			}
		}catch(Exception e){
			e.printStackTrace();
			LogUtil.error(e);
		}finally{
			if(rs    != null){try{   rs.close();}catch(SQLException e){}}
			if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
		}
	return arrBeans;
	}	

	//�̰� ���� �𸣰���.-_- ��ü ����Ʈ�ΰ�..
	public ArrayList mainlist(My310DTO entity, String where_sql,Connection conn) throws SQLException {
		java.sql.PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		ArrayList arrBeans = new ArrayList();
		BaseDataClass data = null; 

		sql.append(" SELECT ");
		sql.append(" BRD_NO,BRD_SUBJECT,CHAR(DATE(BRD_CDATE),ISO) BRD_CDATE,REAL_FILE,BRD_CREATOR,SYS_FILE,REF,REF_STEP,REF_LEVEL,BRD_VIEWCNT ");
		sql.append(" FROM SALES.TMY030  ");
		sql.append(" WHERE BRD_GU = ? ");
		sql.append("   AND DELYN = 'N' ");
		sql.append("   AND REF_STEP = 0 ");

		if(StringUtil.isNotNull(where_sql)){
			sql.append(where_sql);
		}
		sql.append(" ORDER BY BRD_NO DESC ");
        
		try {
			//sales.common.StringUtil.printMsg("����",sql.toString(),this);
        	//pstmt = conn.prepareStatement(sql.toString());
        	
			pstmt =  new PreparedStatement(conn,sql.toString());
			pstmt.setString(1, entity.getBrd_gu());
     		//System.out.println("����--->" + entity.getBrd_gu());

			rs = pstmt.executeQuery();
			while(rs.next()) {	// ���⼭ ���� ����.. �̰� �����ϳ�.. 
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

	//�Խù� ��ȸ��
	public My310DTO select(My310DTO entity, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		StringBuffer sql1 = new StringBuffer();
		My310DTO dto = new My310DTO();

		try {
			sql.append(" UPDATE SALES.TMY030 SET ");
			sql.append(" BRD_VIEWCNT = BRD_VIEWCNT+1");
			sql.append(" WHERE ");
			sql.append(" BRD_NO = ? ");
			//System.out.println("�� --------1-" + sql.toString());
			pstmt =  new PreparedStatement(conn,sql.toString());
			pstmt.setLong(1, entity.getBrd_no());

			pstmt.executeUpdate();
			pstmt.close();
            
			sql1.append(" SELECT ");
			sql1.append(" BRD_NO, BRD_GU, BRD_SUBJECT, BRD_CREATOR, CHAR(DATE(BRD_CDATE),ISO) BRD_CDATE, BRD_CONTENTS, REAL_FILE, SYS_FILE, ");
			sql1.append(" BRD_VIEWCNT, BRD_PASSWD, REF, REF_STEP, REF_LEVEL, DELYN ");
			sql1.append(" FROM SALES.TMY030  ");
			sql1.append(" WHERE BRD_NO = ? ");

			//System.out.println("�� -------2--" + sql1.toString());
			pstmt =  new PreparedStatement(conn,sql1.toString());
			pstmt.setLong(1, entity.getBrd_no());

			LogUtil.debug(pstmt.toString());
			rs = pstmt.executeQuery();
			//System.out.println("210DAO");
			if(rs.next()){
				//Setting Line 1
				dto.setBrd_no(rs.getLong("BRD_NO"));
				dto.setBrd_gu(rs.getString("BRD_GU"));
				dto.setBrd_subject(rs.getString("BRD_SUBJECT"));
				dto.setBrd_creater(rs.getString("BRD_CREATOR"));
				dto.setBrd_cdate2(rs.getString("BRD_CDATE"));
				dto.setBrd_contents(rs.getString("BRD_CONTENTS"));
				dto.setReal_file(rs.getString("REAL_FILE"));
				dto.setSys_file(rs.getString("SYS_FILE"));
				dto.setBrd_viewcnt(rs.getLong("BRD_VIEWCNT"));
				dto.setBrd_passwd(rs.getString("BRD_PASSWD"));
				dto.setRef(rs.getLong("REF"));
				dto.setRef_step(rs.getLong("REF_STEP"));
				dto.setRef_level(rs.getLong("REF_LEVEL"));
				dto.setDelyn(rs.getString("DELYN"));
			}
		}catch(Exception e){
			e.printStackTrace();
			LogUtil.error(e);
		}finally{
			if(rs    != null){try{   rs.close();}catch(SQLException e){}}
			if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
		}
		return dto;
	}

	public long insert(My310DTO dto, Connection conn) {
		PreparedStatement pstmt = null;
		PreparedStatement clopPstmt = null;
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		ResultSet rs = null;
		long brd_no = 0;
		long ret = 0;

		try {
			sql2.append(" SELECT COALESCE(MAX(BRD_NO),0) + 1 AS BRD_NO FROM SALES.TMY030 ");

            
			pstmt = new PreparedStatement(conn, sql2.toString());

			rs = pstmt.executeQuery();
			if (rs.next()){
				brd_no = rs.getLong("brd_no");
			}
			rs.close();
			pstmt.close();


			sql.append(" INSERT INTO SALES.TMY030(" +
								"BRD_NO,");
			sql.append(" BRD_GU, " +
					"	BRD_SUBJECT, " +
					"	BRD_CREATOR, " +
					"	BRD_CDATE, " +
					"	BRD_CONTENTS, " +
					"	REAL_FILE, " +
					"	SYS_FILE, ");
			sql.append(" BRD_VIEWCNT, " +
					"	BRD_PASSWD, " +
					"	REF, " +
					"	REF_STEP, " +
					"	REF_LEVEL, " +
					"	DELYN ");
			sql.append(" ) VALUES (");
			sql.append(" ?,?,?,?,CURRENT TIMESTAMP,?,?,?,?,");
			sql.append(" ?,?,?,?,'N')");

            
			//System.out.println("-----" + sql.toString());
			pstmt = new PreparedStatement(conn, sql.toString());
			
			int count = 1;
            
			pstmt.setLong(count++,brd_no);
			pstmt.setString(count++,dto.getBrd_gu());
			pstmt.setString(count++,dto.getBrd_subject());
			pstmt.setString(count++,dto.getBrd_creator());
			pstmt.setString(count++,dto.getBrd_contents());
			pstmt.setString(count++,dto.getReal_file());
			pstmt.setString(count++,dto.getSys_file());
			pstmt.setLong(count++,dto.getBrd_viewcnt());
			pstmt.setString(count++,dto.getBrd_passwd());
			pstmt.setLong(count++,brd_no);
			pstmt.setLong(count++,dto.getRef_step());
			pstmt.setLong(count++,dto.getRef_level());
			
			LogUtil.debug(pstmt.toString());
			
			
			ret = pstmt.executeUpdate();
            
			
			pstmt.close();

		}catch(Exception e){
			e.printStackTrace();
			LogUtil.error(e);
		}finally{
			if(rs        != null){try{       rs.close();}catch(SQLException e){}}
			if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
			if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
		}
		return ret;
	}

	public long rep_insert(My310DTO dto, Connection conn) {
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		StringBuffer sql3 = new StringBuffer();
		ResultSet rs = null;
		long brd_no = 0;
		long ret = 0;
        
		try {
			//System.out.println(dto.getBrd_gu());
			//System.out.println(dto.getRef());
			//System.out.println(dto.getRef_step());
			//System.out.println(dto.getRef_level());
			sql.append(" UPDATE SALES.TMY030 SET ");
			sql.append(" REF_STEP = REF_STEP + 1 ");
			sql.append(" WHERE ");
			sql.append(" BRD_GU = ? ");
			sql.append(" AND REF = ? ");
			sql.append(" AND REF_STEP > ? ");
            
			pstmt = new PreparedStatement(conn, sql.toString());

			pstmt.setString(1,dto.getBrd_gu());
			pstmt.setLong(2,dto.getRef());
			pstmt.setLong(3,dto.getRef_step());

			ret = pstmt.executeUpdate();
			
			//System.out.println("rep-insert----->" + sql.toString());
			pstmt.close();
			
			//System.out.println("brd_no=" +brd_no);
			//System.out.println("ref=" +ref);
			//System.out.println("ref_step=" +ref_step);
			//System.out.println("ref_level=" +ref_level);
			sql2.append(" SELECT COALESCE(MAX(BRD_NO),0)+1 BRD_NO FROM SALES.TMY030 ");

			pstmt = new PreparedStatement(conn, sql2.toString());
			//System.out.println("rep-select----->" + sql2.toString());
			rs = pstmt.executeQuery();
			if (rs.next()){
				brd_no = rs.getLong("brd_no");
			}
			rs.close();
			pstmt.close();
			//System.out.println("brd_no=" +brd_no);
			//System.out.println("-------------");
			//System.out.println(dto.getRef());
			//System.out.println(dto.getRef_step());
			//System.out.println(dto.getRef_step()+1);
			sql3.append(" INSERT INTO SALES.TMY030 (");
			sql3.append(" BRD_NO,BRD_GU, BRD_SUBJECT, BRD_CREATOR, BRD_CDATE, BRD_CONTENTS, REAL_FILE, SYS_FILE, ");
			sql3.append(" BRD_VIEWCNT, BRD_PASSWD, REF, REF_STEP, REF_LEVEL, DELYN ");
			sql3.append(" )VALUES(");
			sql3.append(" ?,?,?,?,CURRENT TIMESTAMP,?,?,?,");
			sql3.append(" ?,?,?,?,?,'N')");
			//System.out.println("-------------#########");
			pstmt = new PreparedStatement(conn, sql3.toString());
			//System.out.println("rep-chnsert----->" + sql3.toString());
			pstmt.setLong(1,brd_no);
			pstmt.setString(2,dto.getBrd_gu());
			pstmt.setString(3,dto.getBrd_subject());
			pstmt.setString(4,dto.getBrd_creator());
			pstmt.setString(5, "===>>" + StringUtil.strReplace(StringUtil.strReplace(dto.getBrd_contents(), "<P>", ""), "</P>", "<br>"));
			pstmt.setString(6,dto.getReal_file());
			pstmt.setString(7,dto.getSys_file());
			pstmt.setLong(8,dto.getBrd_viewcnt());
			pstmt.setString(9,dto.getBrd_passwd());
			pstmt.setLong(10,dto.getRef());
			pstmt.setLong(11,dto.getRef_step()+1);
			pstmt.setLong(12,dto.getRef_level()+1);

			LogUtil.debug(pstmt.toString());

			ret = pstmt.executeUpdate();

			pstmt.close();
		}catch (SQLException sqle){
				//System.out.println(sqle.getMessage());
		}catch(Exception e){
			LogUtil.error(e);
		}finally{
			if(rs        != null){try{       rs.close();}catch(SQLException e){}}
			if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
		}
		return ret;
	}

	public long update(My310DTO dto, Connection conn) {
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		long ret = 0;
		//System.out.println("111111111111"+dto.getBrd_contents().toString());
		try {
			sql.append(" UPDATE  SALES.TMY030 SET ");
			sql.append(" BRD_SUBJECT = ?,");
			sql.append(" BRD_CONTENTS = ? ,");
			sql.append(" REAL_FILE = ?,");
			sql.append(" SYS_FILE = ? ");
			sql.append(" WHERE ");
			sql.append(" BRD_NO = ? ");

			//System.out.println("update----->" + sql.toString());
			//System.out.println(dto.getBrd_contents().toString());
			pstmt = new PreparedStatement(conn, sql.toString());

			pstmt.setString(1,dto.getBrd_subject());
			pstmt.setString(2, StringUtil.strReplace(StringUtil.strReplace(dto.getBrd_contents(), "<P>", ""), "</P>", "<br>"));
			pstmt.setString(3,dto.getReal_file());
			pstmt.setString(4,dto.getSys_file());
			pstmt.setLong(5,dto.getBrd_no());

			LogUtil.debug(pstmt.toString());
			ret = pstmt.executeUpdate();
            
			pstmt.close();
		}catch(Exception e){
			LogUtil.error(e);
		}finally{
			if(rs        != null){try{       rs.close();}catch(SQLException e){}}
			if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
		}
		return ret;
	}

	public long delete(My310DTO dto, Connection conn)  {
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		long ret = 0;
	
		try {
		//System.out.println("delete---------->");
		//System.out.println(dto.getRef());
		//System.out.println(dto.getBrd_no());
		
		sql.append(" UPDATE SALES.TMY030 SET");
		sql.append(" DELYN  = 'Y' ");
		sql.append(" WHERE ");
		sql.append(" BRD_NO = ? ");
        
		//System.out.println("DELETE----->" + sql.toString());
		
			pstmt = new PreparedStatement(conn, sql.toString());
			pstmt.setLong(1, dto.getBrd_no());
			LogUtil.debug(pstmt.toString());

			ret = pstmt.executeUpdate();
			if(ret == 1){
				conn.commit();
			} else {
				conn.rollback();
			}
		}  catch(SQLException e)    {
			LogUtil.error(e);
		}finally{
			if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
		}
		return ret;
	}
}
