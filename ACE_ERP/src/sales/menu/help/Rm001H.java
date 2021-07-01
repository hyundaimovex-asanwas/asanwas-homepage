package sales.menu.help;
/***********************************************************************
 * 	��ݰ��� ���� �ڵ� �� - 2017.02.13
************************************************************************/
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.*;

public class Rm001H extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
    public void makeSql(){
        for(int i=0; i<arr_sql.length; i++)
           arr_sql[i] = new StringBuffer();
		arr_sql[0].append ("SELECT 					\n")
				  .append ("	ROOM_TYPE_SID,      \n")
				  .append ("	ROOM_TYPE_CD,       \n")
				  .append ("	ROOM_TYPE_NM,       \n")
				  .append ("	T1.UPJANG_SID,         \n")
				  .append ("	STD_PERSONS,         \n")
				  .append ("	T2.UPJANG_NM,         \n")
				  .append ("	T1.DISPLAY_SEQ         \n")
				  .append ("FROM                    \n")
				  .append ("	SALES.TRM030 T1       \n")
				  .append ("	JOIN SALES.TRM010 T2 ON T1.UPJANG_SID=T2.UPJANG_SID      \n")
				  .append ("WHERE T1.USE_YN = 'Y'      \n");
		
		
		arr_sql[1].append ("(SELECT 					\n")
				  .append ("	0 ROOM_TYPE_SID,	\n")
				  .append ("	'��ü        ' ROOM_TYPE_CD,	\n")
				  .append ("	'����        ' ROOM_TYPE_NM,	\n")
				  .append ("	0 UPJANG_SID,		\n")
				  .append ("	0 STD_PERSONS,		\n")
				  .append ("	0 DISPLAY_SEQ		\n")
				  .append ("FROM DUAL				\n")
				  .append ("UNION ALL				\n")
				  .append ("SELECT 					\n")
				  .append ("	ROOM_TYPE_SID,      \n")
				  .append ("	ROOM_TYPE_CD,       \n")
				  .append ("	ROOM_TYPE_NM,       \n")
				  .append ("	UPJANG_SID,         \n")
				  .append ("	STD_PERSONS,        \n")
				  .append ("	DISPLAY_SEQ			\n")
				  .append ("FROM                    \n")
				  .append ("	SALES.TRM030        \n")
				  .append ("WHERE USE_YN = 'Y'      \n");
    }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	
	}

	
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
	
	
		try {
			GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
			

			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset(TRM030) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			int     s_RoomTypeSid	= HDUtil.nullCheckNum(greq.getParameter("s_RoomTypeSid"));
			String	s_RoomTypeCd	= HDUtil.nullCheckStr(greq.getParameter("s_RoomTypeCd"));
			String  s_RoomTypeNm	= HDUtil.nullCheckStr(greq.getParameter("s_RoomTypeNm"));
			int     s_UpjangSid 	= HDUtil.nullCheckNum(greq.getParameter("s_UpjangSid"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//ù��° �׸���
			int sCnt1 = 1;
			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					if (0!=s_RoomTypeSid) 
						arr_sql[0].append (" AND room_type_sid=? 		\n");
					if (!"".equals(s_RoomTypeCd)) 
						arr_sql[0].append (" AND (room_type_cd LIKE ? OR room_type_nm LIKE ?)	\n");
					if (0!=s_UpjangSid) {
						arr_sql[0].append (" AND T1.upjang_sid=?			\n");
					}
					arr_sql[0].append (" ORDER BY T2.SAUP_SID, T2.DISPLAY_SEQ, T1.DISPLAY_SEQ ");
					//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);

					// ���� ����
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					
					if (0!=s_RoomTypeSid)
						cstmt.setInt(sCnt1++, s_RoomTypeSid);
					if (!"".equals(s_RoomTypeCd)) {	
						cstmt.setString(sCnt1++, "%" + s_RoomTypeCd + "%");
						cstmt.setString(sCnt1++, "%" + s_RoomTypeCd + "%");
					}
					if (0!=s_UpjangSid)	
						cstmt.setInt(sCnt1++, s_UpjangSid);
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
					
					break;

				case 2: //��ݰ������� �˻�����(�����) �θ� �� ����..
					
					if (0!=s_RoomTypeSid) 
						arr_sql[1].append (" AND room_type_sid=? 		\n");
					if (!"".equals(s_RoomTypeCd)) 
						arr_sql[1].append (" AND (room_type_cd LIKE ? OR room_type_nm LIKE ?)	\n");
					if (0!=s_UpjangSid) {
						arr_sql[1].append (" AND upjang_sid=?			\n");
					}
					
					arr_sql[1].append (") ORDER BY DISPLAY_SEQ ");
					StringUtil.printMsg("arr_sql[1].toString()", arr_sql[1].toString(), this);
					
					// ���� ����
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					if (0!=s_RoomTypeSid)
						cstmt.setInt(sCnt1++, s_RoomTypeSid);
					if (!"".equals(s_RoomTypeCd)) {	
						cstmt.setString(sCnt1++, "%" + s_RoomTypeCd + "%");
						cstmt.setString(sCnt1++, "%" + s_RoomTypeCd + "%");
					}
					if (0!=s_UpjangSid)	
						cstmt.setInt(sCnt1++, s_UpjangSid);
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
					break;
			}
		} catch (SQLException sqle){
			//gres.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}

}
