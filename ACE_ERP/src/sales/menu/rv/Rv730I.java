package sales.menu.rv;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Rv730I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//�����
		arr_sql[0].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//	���ð�	
		arr_sql[1].append ("SELECT ''                 AS DEPART_TIME,			\n")
					.append ("		'��ü  '          AS DEPART_TIME_NM			\n")
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT R2.DEPART_TIME,			\n")
					.append ("		SALES.FMT_TIME(R2.DEPART_TIME) AS DEPART_TIME_NM			\n")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2			\n")
					.append ("	ON R2.GOODS_SID   = R1.GOODS_SID			\n")
					.append ("WHERE R1.SAUP_SID    = ?			\n")
					.append ("	AND R2.DEPART_DATE = ?			\n")
					.append ("GROUP BY R2.DEPART_TIME			\n");
		
		//��ǰ
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,    ")
					.append ("		'��ü  '           AS GOODS_NM    ")       
					.append ("FROM DUAL    ")
					.append ("UNION ALL    ")
					.append ("SELECT R1.GOODS_SID,    ")
					.append ("		MIN(R1.GOODS_NM)   AS GOODS_NM    ")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2    ")
					.append ("ON R2.GOODS_SID   = R1.GOODS_SID    ")
					.append ("WHERE R1.SAUP_SID    = ?    ")
					.append ("	AND R2.DEPART_DATE = ?    ")
					.append ("GROUP BY R1.GOODS_SID    ");
		
		//������
		arr_sql[3].append ("SELECT										\n")
					.append ("	'' DETAIL, '��ü  ' DETAIL_NM    \n")
					.append ("FROM DUAL                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		
		//��
		arr_sql[4].append ("SELECT ' '                 AS CLASS,			\n")          
					.append ("			'��ü  '      AS CLASS_NM			\n")         
					.append ("FROM DUAL			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT CLASS,			\n")
					.append ("			SALES.FN_DETAIL_NM('RV017', CLASS) AS CLASS_NM			\n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2			\n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE			\n")
					.append ("WHERE 1=1			\n");
	
		//��
		arr_sql[5].append ("SELECT ' '                 AS TEAMS,  				    \n")
					.append ("		'��ü  '          AS TEAMS_NM       				    \n")
					.append ("FROM DUAL  				    \n")
					.append ("UNION ALL  				    \n")
					.append ("SELECT TEAMS              AS TEAMS,  				    \n")
					.append ("		TEAMS              AS TEAMS_NM  				    \n")
					.append ("FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2  				    \n")
					.append ("		ON R2.DEPART_DATE  =  R1.DEPART_DATE  				    \n")
					.append ("WHERE 1=1				   \n");
   }

    
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command ","����ȸ",this);

    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
		String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
		String 	sClass	= HDUtil.nullCheckStr(greq.getParameter("sClass"));	
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){	
				//�⺻ �˻� ����
					if(dSets[i].getName().equals("ds2")){
						GauceDataSet ds1 = gis.read("DS2");
						//StringUtil.printMsg("arr_sql[0].toString()",arr_sql[0].toString(),this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					}
					if(dSets[i].getName().equals("ds3")){
						GauceDataSet ds1 = gis.read("DS3");
						//StringUtil.printMsg("arr_sql[1].toString()",arr_sql[1].toString(),this);								
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, sSaupSid);
						cstmt.setString(2, sDepartDate);
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					} 	
					if(dSets[i].getName().equals("ds4")){
						GauceDataSet ds1 = gis.read("DS4");
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, sSaupSid);
						cstmt.setString(2, sDepartDate);
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					} 	
					if(dSets[i].getName().equals("ds5")){
						GauceDataSet ds1 = gis.read("DS5");
						cstmt = conn.prepareCall(arr_sql[3].toString());
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					} 	
					if(dSets[i].getName().equals("ds6")){
						GauceDataSet ds1 = gis.read("DS6");
						int sCnt1 = 1;
						if (!"".equals(sDepartDate)) 
							arr_sql[4].append (" AND R1.DEPART_DATE = ? \n");
						if (!"".equals(sDepartTime)) 
							arr_sql[4].append (" AND R2.DEPART_TIME = ? \n");
							arr_sql[4].append ("GROUP BY CLASS			");

						cstmt = conn.prepareCall(arr_sql[4].toString());
						if (!"".equals(sDepartDate))
							cstmt.setString(sCnt1++, sDepartDate);
						if (!"".equals(sDepartTime))
							cstmt.setString(sCnt1++, sDepartTime);
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					} 	
					if(dSets[i].getName().equals("ds7")){
						GauceDataSet ds1 = gis.read("DS7");
						int sCnt1 = 1;
						if (!"".equals(sDepartDate)) 
							arr_sql[5].append (" AND R1.DEPART_DATE = ? \n");
						if (!"".equals(sDepartTime)) 
							arr_sql[5].append (" AND R2.DEPART_TIME = ? \n");
						if (!"".equals(sClass)) 
							arr_sql[5].append (" AND R2.CLASS = ? \n");
						arr_sql[5].append ("GROUP BY TEAMS    ORDER BY TEAMS				    ");
						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);								
						cstmt = conn.prepareCall(arr_sql[5].toString());
						if (!"".equals(sDepartDate))
							cstmt.setString(sCnt1++, sDepartDate);
						if (!"".equals(sDepartTime))
							cstmt.setString(sCnt1++, sDepartTime);
						if (!"".equals(sClass))
							cstmt.setString(sCnt1++, sClass);	
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
					} 			
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
							
							break;
				}
			 	//gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataBase */
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			// �˻��� ����
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			int 	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			int  	sGoodsSid	= HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
			String 	sCustGu	= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));
			String 	sClass	= HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String 	sTeams	= HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String 	sCustNm	= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));			
			String 	sStatus	= HDUtil.nullCheckStr(greq.getParameter("sStatus"));			


//			//StringUtil.printMsg("sSaupSid===",sSaupSid,this);
//			//StringUtil.printMsg("sGoodsSid===",sGoodsSid,this);
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){	
				//�⺻ �˻� ����
				if(dSets[i].getName().equals("ds1")){
				GauceDataSet ds1 = gis.read("DS1");
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							
							cstmt = conn.prepareCall("{call SALES.NPR_RV730I_01(?,?,?,?,?,   ?,?,?,?,?) }");
							cstmt.setString(1, sBgnDate);
							cstmt.setString(2, sDepartTime);
							cstmt.setInt   (3, sSaupSid);
							cstmt.setInt   (4, sGoodsSid);
							cstmt.setString(5, sCustGu);
							cstmt.setString(6, sClass);
							cstmt.setString(7, sTeams);
							cstmt.setString(8, sCustNm);							
							cstmt.setString(9, sStatus);		
							cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//����� ���� Ŀ��
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(10);	//Ŀ�� OUT param. 			
							gos.write(getDataSet(rs, ds1));
							
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
							break;
					}
				}
			 }
			 //gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;

		try{
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			/* DataSet */
			GauceDataSet inputDs 	= gis.read("DEFAULT");		//������ ����
			GauceDataSet msgDS 	= gis.read("msgDS");	//�ɼ� ����		
			
			if(inputDs!=null){
				
				int colNm_RsvSid           = inputDs.indexOfColumn("RSV_SID");
				int colNm_TourNo           = inputDs.indexOfColumn("TOUR_NO");
				int colNm_PageNo           = inputDs.indexOfColumn("PAGE_NO");
				int colNm_ConfirmYn        = inputDs.indexOfColumn("CONFIRM_YN");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				
				inner : {
					for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall("{call SALES.PR_RV730I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
						
							cstmt.setInt(1,    rows[i].getInt(colNm_RsvSid));
							cstmt.setString(2, rows[i].getString(colNm_TourNo));
							cstmt.setInt(3,    rows[i].getInt(colNm_PageNo));						
							cstmt.setString(4, rows[i].getString(colNm_ConfirmYn).equals("T") ? "Y" : "N");
							cstmt.setString(5, fParamEmpno);
							cstmt.setString(6, fParamIp);
							cstmt.setString(7, "3");
							cstmt.registerOutParameter(8,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(9,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 						
		
							cstmt.executeUpdate();
							
							//�޽���ó��
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									//StringUtil.printMsg("�����޽���",cstmt.getString(10),this);
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(10));								
									msgDS.addDataRow(row);
								}
							} else {
								//StringUtil.printMsg("���и޽���",cstmt.getString(10),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();
								row.addColumnValue(cstmt.getString(10));							
								msgDS.addDataRow(row);
								break inner;						
							}
							
							if(cstmt!=null) cstmt.close();
							break;
						}
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}