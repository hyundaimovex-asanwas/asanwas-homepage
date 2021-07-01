package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import javax.naming.*;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import java.io.*;
import java.sql.*;

public class Ac750S extends SuperServlet {

	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//master
		arr_sql[1].append("CALL SALES.PR_AC750S_01(?,?,?,?,?,	 ?,?)");
		//detail
		arr_sql[2].append("CALL SALES.PR_AC750S_02(?,?,?,?,?,	 ?,?)");
		
//		��ǰ�Ǳ���
		arr_sql[3].append ("SELECT													\n")
					.append ("	' '		HEAD,												\n")
					.append ("	' '		DETAIL,												\n")
					.append ("	'��ü'	DETAIL_NM										\n")
					.append ("FROM DUAL                       \n")
				    .append ("UNION ALL                                   \n")
				    .append ("SELECT													\n")
					.append ("			HEAD,												\n")
					.append ("			DETAIL,												\n")
					.append ("			DETAIL_NM										\n")
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='AC003'											\n");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		 
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
            	}
			}
		//gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","��ȸ",this);		

		/* DataBase */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			// �˻��� ����
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String 	sGiftSeq	= HDUtil.nullCheckStr(greq.getParameter("sGiftSeq"));
			String 	sFrGiftNo	= HDUtil.nullCheckStr(greq.getParameter("sFrGiftNo"));
			String 	sToGiftNo	= HDUtil.nullCheckStr(greq.getParameter("sToGiftNo"));
			String  sDateSel	= HDUtil.nullCheckStr(greq.getParameter("sDateSel"));
			
			 for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//StringUtil.printMsg("call SALES.PR_AC750S_01","",this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*
					StringUtil.printMsg("sBgnDate",sBgnDate,this);
					StringUtil.printMsg("sEndDate",sEndDate,this);
					StringUtil.printMsg("sGiftSeq",sGiftSeq,this);
					StringUtil.printMsg("sFrGiftNo",sFrGiftNo,this);
					StringUtil.printMsg("sToGiftNo",sToGiftNo,this);
					StringUtil.printMsg("sDateSel",sDateSel,this);
					*/
					cstmt.setString(1, sBgnDate);
					cstmt.setString(2, sEndDate);
					cstmt.setString(3, sGiftSeq);
					cstmt.setString(4, sFrGiftNo);
					cstmt.setString(5, sToGiftNo);
					cstmt.setString(6, sDateSel);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					//StringUtil.printMsg("call SALES.PR_AC750S_02","",this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					/*
					StringUtil.printMsg("sBgnDate",sBgnDate,this);
					StringUtil.printMsg("sEndDate",sEndDate,this);
					StringUtil.printMsg("sGiftSeq",sGiftSeq,this);
					StringUtil.printMsg("sFrGiftNo",sFrGiftNo,this);
					StringUtil.printMsg("sToGiftNo",sToGiftNo,this);
					StringUtil.printMsg("sDateSel",sDateSel,this);
					*/
					cstmt.setString(1, sBgnDate);
					cstmt.setString(2, sEndDate);
					cstmt.setString(3, sGiftSeq);
					cstmt.setString(4, sFrGiftNo);
					cstmt.setString(5, sToGiftNo);
					cstmt.setString(6, sDateSel);	
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}							
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
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
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}