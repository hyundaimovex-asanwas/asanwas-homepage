package sales.menu.rm;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rm120S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//  ��ȸ 
		arr_sql[0].append("")
					.append("SELECT 																							\n")
					.append("	     CASE WHEN R2.ROOM_STATUS='OK' AND R2.RSV_SID IS NULL  THEN 	'1'	  						\n")// 'OK BLOCK'	   		OK ��
					.append("		 	  WHEN R2.ROOM_STATUS='OK' AND R2.RSV_SID IS NOT NULL THEN 	'2'							\n")// 'BLOCK BOOKING' 		������
					.append("			  WHEN R2.ROOM_STATUS='RA' 	  			    THEN 			'3'							\n")// 'NORMAL BOOKING'		�Ϲݿ���
					.append("			  WHEN R2.ROOM_STATUS='RR' 	  			    THEN 			'4'							\n")// 'OCUPIED ROOM'  		��������
					.append("			  WHEN R2.ROOM_STATUS='IV' 	  			    THEN 			'5'							\n")// 'INVENTORY'			�켱����
					.append("			  WHEN R2.ROOM_STATUS='OO' 	  			    THEN 			'6'							\n")// 'OUT OF ORDER' 		���尴��
					.append("			  ELSE 											 			'9'							\n")// 'EMPTY' 
					.append("		 END AS ROOM_STATUS_TXT																		\n")
					.append("   	   , R1.ROOM_SID													     					\n")// ���� ���̵�                                        
					.append("	   , R1.ROOM_NO * 1	                  AS ROOM_NO					 							\n")// ���ǹ�ȣ INT��     
					.append("	   , R3.DONG_NM || RTRIM(R1.ROOM_NO)  AS ROOM_NO2					 							\n")// ���ǹ�ȣ 5�ڸ�			             
					.append("	   , R1.ROOM_TYPE_SID																			\n") // ���� ���                                         
					.append("	   , R4.ROOM_GRADE_CD																			\n")					                                         
					.append("	   , R4.BED_TYPE_CD																			    \n")
					.append("	   , R4.ROOM_TYPE_CD																			    \n")					
					.append("	   , R2.RSV_SID	   			  		 			   	   											\n")// ���� ��ȣ   ,A.RSV_SID
					.append("	   , R2.BLOCK_SID																				\n")
					.append("	   , R2.ROOM_STATUS	 				  	 									  					\n")// ���� ����
					.append("	   , R2.KEY_SEQ																				   	\n")// ���ǻ����������̺� SID
					.append("	   , CASE WHEN R2.U_EMPNO='' THEN '2030004' ELSE COALESCE(R2.U_EMPNO,'2030004') END AS U_EMPNO 	\n")	    
					.append("  FROM SALES.TRM040 R1 LEFT OUTER JOIN SALES.TRM041 R2 											\n")					             
					.append("    ON (																							\n")								                                                        
					.append("        R2.ROOM_SID                        =  R1.ROOM_SID AND										\n")	     
					.append("        COALESCE(R2.BGN_DATE, ?) <= ?   AND														\n")	     
					.append("        COALESCE(R2.END_DATE, '99990101') >= ?														\n")		         
					.append("        )																							\n")		                                                      
					.append("  JOIN SALES.TRM020 R3 ON R3.DONG_SID      = R1.DONG_SID											\n")		         
					.append("  JOIN SALES.TRM030 R4 ON R4.ROOM_TYPE_SID = R1.ROOM_TYPE_SID 										\n")		     
					.append(" WHERE R1.USE_YN        =  'Y'																		\n")		     
					.append("   AND R1.UPJANG_SID    = ?																		\n")
					.append("   ORDER BY ROOM_NO2	    																		\n");

	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sDate 		= HDUtil.nullCheckStr(req.getParameter("sDate"));	// ���� 
		int sHotel 			= HDUtil.nullCheckNum(req.getParameter("sUpjang"));	// ȣ�� 
		
		StringUtil.printMsg("DATE - ", sDate, this);
		StringUtil.printMsg("HOTEL - ", sHotel, this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						
						
						StringUtil.printMsg("����",arr_sql[0].toString(), this);
					
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						
						stmt.setString(1, sDate);
						stmt.setString(2, sDate);
						stmt.setString(3, sDate);
						stmt.setInt(4, sHotel);
						
						rs = stmt.executeQuery();		
					}

					getDataSet(rs, ds1).flush();

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
