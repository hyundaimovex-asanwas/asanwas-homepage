package omsm.co;
/***********************************************************************
 * 	OMS 공지사항
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

public class m_co0030_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT GUBUN_CD,INPUT_DATE,INPUT_SEQ,OUTPUT_NO,INPUT_TIME  \n");
		    arr_sql[0].append ("       ,INPUT_NAME,TITLE,CONTENTS,ATT_FILE_NAME,ATT_FILE_SYS_NAME \n");
		    arr_sql[0].append ("       ,ATT_GB,LINE_FIX, INPUT_DATE||INPUT_TIME AS INPUT_DATETIME \n");
		    arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0040  \n");
		    arr_sql[0].append ("  WHERE GUBUN_CD = ?  \n");	
		    		    
		    arr_sql[1].append (" INSERT INTO OMS.T_CO0040 ( \n");
		    arr_sql[1].append ("  GUBUN_CD,INPUT_DATE,INPUT_SEQ,OUTPUT_NO,INPUT_TIME  \n");
		    arr_sql[1].append (" ,INPUT_NAME,TITLE,CONTENTS,ATT_FILE_NAME,ATT_FILE_SYS_NAME \n");
		    arr_sql[1].append (" ,ATT_GB,LINE_FIX \n");
		    arr_sql[1].append (" ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE \n");
		    arr_sql[1].append (" )VALUES( \n");
		    arr_sql[1].append ("  ?,?,?,?,?, \n");
		    arr_sql[1].append ("  ?,?,?,?,?, \n");
		    arr_sql[1].append ("  ?,?, \n");
		    arr_sql[1].append ("  ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP \n");
		    arr_sql[1].append ("  )  \n");
		    
		  //UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_CO0040 SET  \n");
			arr_sql[2].append ("  INPUT_TIME=? \n");
			arr_sql[2].append (" ,INPUT_NAME=? \n");
			arr_sql[2].append (" ,TITLE=?      \n");
			arr_sql[2].append (" ,CONTENTS=?   \n");
			arr_sql[2].append (" ,ATT_FILE_NAME=?   \n");
			arr_sql[2].append (" ,ATT_FILE_SYS_NAME=?   \n");
			arr_sql[2].append (" ,ATT_GB=?   \n");
			arr_sql[2].append (" ,LINE_FIX=?   \n");
			arr_sql[2].append (" ,UPDATE_ID=?  \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE GUBUN_CD =?  \n");
			arr_sql[2].append ("    AND INPUT_DATE=? \n");
			arr_sql[2].append ("    AND INPUT_SEQ=?  \n");
						
			//DELETE
			arr_sql[3].append (" DELETE FROM OMS.T_CO0040  \n");
			arr_sql[3].append ("  WHERE GUBUN_CD =?  \n");
			arr_sql[3].append ("    AND INPUT_DATE=? \n");
			arr_sql[3].append ("    AND INPUT_SEQ=?  \n");
		    	    
 	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		  rs	= null;
		
		conn.setAutoCommit(false);
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		
		String strUserid = HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		int intInput_seq=0;
		String strInput_time="";
		
		
		int colNm_GUBUN_CD                   = ds1.indexOfColumn("GUBUN_CD");   
		int colNm_INPUT_DATE                 = ds1.indexOfColumn("INPUT_DATE"); 
		int colNm_INPUT_SEQ                  = ds1.indexOfColumn("INPUT_SEQ");   
		int colNm_OUTPUT_NO                  = ds1.indexOfColumn("OUTPUT_NO");   
		int colNm_INPUT_TIME                 = ds1.indexOfColumn("INPUT_TIME");   
		int colNm_INPUT_NAME                 = ds1.indexOfColumn("INPUT_NAME"); 
		int colNm_TITLE                      = ds1.indexOfColumn("TITLE");   
		int colNm_CONTENTS                   = ds1.indexOfColumn("CONTENTS");   
		int colNm_ATT_FILE_NAME              = ds1.indexOfColumn("ATT_FILE_NAME");   
		int colNm_ATT_FILE_SYS_NAME          = ds1.indexOfColumn("ATT_FILE_SYS_NAME"); 
		int colNm_ATT_GB                     = ds1.indexOfColumn("ATT_GB");   
		int colNm_LINE_FIX                   = ds1.indexOfColumn("LINE_FIX");   
		int colNm_CREATE_ID                  = ds1.indexOfColumn("CREATE_ID");   
		int colNm_CREATE_DATE                = ds1.indexOfColumn("CREATE_DATE"); 
		int colNm_UPDATE_ID                  = ds1.indexOfColumn("UPDATE_ID");   
		int colNm_UPDATE_DATE                = ds1.indexOfColumn("UPDATE_DATE");   
	
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		StringBuffer sql = new StringBuffer();
		
		//TRY
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							stmt1 = null;
							rs1 = null;
							sql = new StringBuffer();
							
							sql.append( " SELECT NVL(MAX(INPUT_SEQ),0)+1, REPLACE(TO_CHAR(SYSDATE,'hh24:mi:ss'),':','') \n");
							sql.append( "   FROM OMS.T_CO0040 	                                                        \n");
							sql.append( "  WHERE GUBUN_CD ='"+ rows[i].getString(colNm_GUBUN_CD) +"'                    \n");
							sql.append( "    AND INPUT_DATE ="+ rows[i].getString(colNm_INPUT_DATE) +"                  \n");
							
							//System.out.println("sql::"+sql.toString());
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(sql.toString());

							while(rs1.next())	{
								intInput_seq = rs1.getInt(1);
								strInput_time = rs1.getString(2);
							}
							
							//System.out.println("intInput_seq::"+intInput_seq+":strInput_time:"+strInput_time);
							rs1.close();
							stmt1.close();
							
							sql=null;
							
							
							//System.out.println("arr_sql[1].toString()"+arr_sql[1].toString());
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_GUBUN_CD));
							cstmt.setString(2,  rows[i].getString(colNm_INPUT_DATE));
							cstmt.setInt(3,     intInput_seq);
							cstmt.setInt(4,     rows[i].getInt(colNm_OUTPUT_NO));
							cstmt.setString(5,  strInput_time);
							cstmt.setString(6,  rows[i].getString(colNm_INPUT_NAME));
							cstmt.setString(7,  rows[i].getString(colNm_TITLE));
							cstmt.setString(8,  rows[i].getString(colNm_CONTENTS));
							cstmt.setString(9,  rows[i].getString(colNm_ATT_FILE_NAME));
							cstmt.setString(10, rows[i].getString(colNm_ATT_FILE_SYS_NAME));
							cstmt.setString(11, rows[i].getString(colNm_ATT_GB));
							cstmt.setString(12, rows[i].getString(colNm_LINE_FIX));
							cstmt.setString(13, strUserid);
							cstmt.setString(14, strUserid);
														
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_INPUT_TIME));
							cstmt.setString(2,  rows[i].getString(colNm_INPUT_NAME));
							cstmt.setString(3,  rows[i].getString(colNm_TITLE));
							cstmt.setString(4,  rows[i].getString(colNm_CONTENTS));
							cstmt.setString(5,  rows[i].getString(colNm_ATT_FILE_NAME));
							cstmt.setString(6,  rows[i].getString(colNm_ATT_FILE_SYS_NAME));
							cstmt.setString(7,  rows[i].getString(colNm_ATT_GB));
							cstmt.setString(8,  rows[i].getString(colNm_LINE_FIX));
							cstmt.setString(9,  strUserid);
							cstmt.setString(10,  rows[i].getString(colNm_GUBUN_CD));
							cstmt.setString(11,  rows[i].getString(colNm_INPUT_DATE));
							cstmt.setInt(12,     rows[i].getInt(colNm_INPUT_SEQ));
							
							cstmt.executeUpdate();
														
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							//System.out.println("arr_sql[3].toString()"+arr_sql[3].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_GUBUN_CD));
							cstmt.setString(2,  rows[i].getString(colNm_INPUT_DATE));
							cstmt.setInt(3,     rows[i].getInt(colNm_INPUT_SEQ));
							
							cstmt.executeUpdate();
								
							if(cstmt!=null) cstmt.close();	
							break;
							
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			gos.close();	
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) { 
			conn.rollback();
			throw e;
		} finally {			
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
			
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
			String v_parm2		    = HDUtil.nullCheckStr(greq.getParameter("v_parm2"));
			
			//쿼리 WHERE 조건
			if(v_parm1.equals("1")){ //제목
				arr_sql[0].append ("  AND TITLE LIKE ?       \n");	
			}else if(v_parm1.equals("2")){//내용
				arr_sql[0].append ("  AND CONTENTS LIKE ?    \n");
			}else if(v_parm1.equals("3")){//작성자
				arr_sql[0].append ("  AND INPUT_NAME LIKE ?  \n");
			}
			
			arr_sql[0].append ("  ORDER BY LINE_FIX, INPUT_DATE, INPUT_SEQ   \n");
			/*
			StringUtil.printMsg("arr_sql[0]", arr_sql[0].toString(), this);
			StringUtil.printMsg("v_keyword", v_keyword, this);
			StringUtil.printMsg("v_parm1",   v_parm1,   this);
			StringUtil.printMsg("v_parm2",   v_parm2,   this);
			*/
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_keyword);
					if(!v_parm1.equals("0")&&!v_parm1.equals("")){
						cstmt.setString(2, "%"+v_parm2+"%");
					}
					rs = cstmt.executeQuery();     //DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
