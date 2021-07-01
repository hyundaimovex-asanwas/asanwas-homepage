package sales.menu.help;
/**********************************************************************************
 * ������ �˾� 
 **********************************************************************************/

import java.io.File;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Rm003H extends SuperServlet {
	public void makeSql() {
		arr_sql[0].append("SELECT 																	\n")
				  .append("		  T3.UPJANG_SID													\n	")
				  .append("      ,T3.UPJANG_NM                 			/* �����         */			\n")
				  .append("      ,T1.FLOORS                    			/* ������         */			\n")
				  .append("      ,T1.ROOM_NO                   			/* ���ǹ�ȣ       */			\n")
				  .append("      ,T2.ROOM_TYPE_CD              			/* ����Ÿ��       */			\n")
				  .append("      ,T2.ROOM_TYPE_NM              			/* ����Ÿ�Ը�     */			\n")
				  .append("      ,T1.ROOM_SID                  			/* ���� SID      */	 		\n")
				  .append("  FROM 																	\n")
				  .append("       SALES.TRM040 T1													\n")
				  .append("      ,SALES.TRM030 T2													\n")
				  .append("      ,SALES.TRM010 T3													\n")
				  .append(" WHERE 1 = 1																\n")
				  .append("   AND T1.ROOM_TYPE_SID = T2.ROOM_TYPE_SID   /* ����Ÿ�� SID  */	  		\n")
				  .append("   AND T1.UPJANG_SID    = T3.UPJANG_SID      /* ����     SID  */		    \n")
				  .append("   AND T1.USE_YN = 'Y'    											    \n");
	}
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		System.out.println("# Command : ��ȸ");
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter ����
		 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
		 **********************************************************************************/

		// �˻��� ����
		String sRoomNo			= HDUtil.nullCheckStr(req.getParameter("sRoomNo"));
		String sUpjangSid			= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));			
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = new GauceDataSet("DEFAULT");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
		 
						if (!"".equals(sRoomNo)) 
							arr_sql[0].append( " AND T1.ROOM_NO LIKE ?");
						
						if (!"".equals(sUpjangSid)) 
							arr_sql[0].append( " AND T3.UPJANG_SID = ? ");
						arr_sql[0].append("ORDER bY T3.UPJANG_NM,INTEGER(T1.ROOM_NO)");											
						System.out.println("sRoomNo=======>"+sRoomNo);
						System.out.println("sUpjangSid=======>"+sUpjangSid);
System.out.println("arr_sql[0].toString() : " + arr_sql[0].toString());
						//���� ����
						stmt = conn.getGauceStatement(arr_sql[0].toString()); 
		
						if (!"".equals(sRoomNo)) {
							stmt.setString(sCnt1++, sRoomNo + "%");
						}			
						
						if (!"".equals(sUpjangSid)) {
							stmt.setString(sCnt1++, sUpjangSid);
						}
						rs = stmt.executeQuery(); // DataSet set
						getDataSet(rs, ds1).flush();
					}
					break;
	
			}
		} catch (SQLException sqle){
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
	
}
