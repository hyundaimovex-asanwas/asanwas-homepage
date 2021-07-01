/**************************************************************************************
 * �ý��۸�		: ������ ���
 * ���α׷�ID 	: am200i
 * J  S  P		: am200i
 * �� �� ��		: am200i
 * [��  ��   ��  ��][������] ����
 * [2011-01-10][�ڰ汹] ����������� �־ ������ ��� �� �����ϴ� ȭ��
 **************************************************************************************/
package common;

import java.io.FileOutputStream;
import java.io.InputStream;
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

public class Am200I extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		/*
		 * ������ ��ȸ
		 */
		arr_sql[1].append("SELECT item_sid			    												\n")	/* ������SID      	*/
	      		  .append("		 ,item_cd        												 				\n")	/* �׸��ڵ�          	*/
	      		  .append("		 ,asset_cd      												 				\n")	/* �ڻ��ڵ�          	*/
	      		  .append("		 ,item_nm     												 					\n")	/* ǰ��                 	*/
	      		  .append("		 ,model_nm      												 				\n")	/* �𵨸�	         	*/
	      		  .append("		 ,made_company        													\n")	/* ������ 	        	*/
	      		  .append("		 ,cpu         												 					\n")	/* cpu		         	*/
	      		  .append("		 ,mainboard        															\n")	/* ���κ���         	*/
	      		  .append("		 ,hdd    																		\n")	/* hdd  				    */
	      		  .append("		 ,ram  																			\n")	/* ram	              	*/
	      		  .append("		 ,graphic         																\n")	/* �׷���ī��       	*/
	      		  .append("		 ,powersupply      															\n")	/* �Ŀ����ö���    	*/
	      		  .append("		 ,dvd         																	\n")	/* dvd                  	*/
	      		  .append("		 ,win_serial         															\n")	/* ������Ű          	*/
	      		  .append("		 ,remarks         																\n")	/* ���  		        */
	      		  .append("		 ,i_empno       																\n")	/* �Է���             	*/
	      		  .append("		 ,i_date        																	\n")	/* �Է��Ͻ�          	*/
	      		  .append("		 ,u_empno      																\n")	/* ������             	*/
	      		  .append("		 ,u_date     																	\n")	/* �����Ͻ�         	*/
	      		  
	      		  .append("FROM  common.it_item 															\n")
	      		  .append("WHERE 1 = 1 																		\n");
	      		  
		/*
		 * ������ ���
		 */
		arr_sql[4].append("INSERT INTO common.it_item  (")
				  .append("				 item_cd        	\n")		/* ������ȣ		        	*/
				  //.append("				,asset_cd      	\n")		/* �ڻ��ڵ�                	*/
				  .append("				,item_nm      		\n")		/* ǰ�� 		                 	*/
				  .append("				,model_nm      	\n")		/*�𵨸� 			        	*/
				  .append("				,made_company        \n")	/* ������ 	   		     	*/
				  .append("				,cpu         		\n")		/* cpu         					*/
				  .append("				,mainboard        \n")		/* ���κ���         			*/
				  .append("				,hdd    				\n")		/* �ϵ��ũ    			*/
				  .append("				,ram  				\n")		/* ��               				*/
				  .append("				,graphic         	\n")		/* �׷���ī��                */
				  .append("				,powersupply     \n")		/* �Ŀ����ö���             */
				  .append("				,dvd         		\n")		/* dvd                   		*/
				  .append("				,win_serial         \n")		/* ������Ű                    */
				  .append("				,remarks        	\n")		/* ���     						*/
				  .append("		 		,u_date       		\n") 	/* ������������             */
	      		  .append("		 		,u_empno       	\n")		/* ���������ڻ��          */
	      		  .append("			)							\n")
				  
				  .append("VALUES							\n")
				  .append("			(	    					\n")
				  .append("				?,?,?,?,?,			\n")	
				  .append("				?,?,?,?,?,			\n")
				  .append("				?,?,?,CURRENT TIMESTAMP,?	\n")
				  .append("			)");
		
	
		/*
		 * ������ ����
		 */
		arr_sql[7].append("UPDATE common.it_item 		SET				\n")
				  .append("		 item_cd		= ?     							\n")	/* ������ȣ	         	*/
				  .append("		,item_nm		= ?     							\n")	/* ǰ��                  	*/
				  .append("		,model_nm		= ?    				 		\n")	/* �𵨸�       		  	*/
				  .append("		,made_company			= ?     			\n")	/* ������    		     	*/
				  .append("		,cpu      	= ?  									\n")	/* cpu         				*/
				  .append("		,mainboard	= ?    							\n")	/* ���κ���     			*/
				  .append("		,hdd	= ?  											\n")	/* �ϵ��ũ            */
				  .append("		,ram        = ?										\n")	/* ��                   		*/
				  .append("		,graphic      = ?									\n")	/* �׷���ī��            */
				  .append("		,powersupply         = ?						\n")	/* �Ŀ����ö���         */
				  .append("		,dvd         = ?									\n")	/* dvd                   	*/
				  .append("		,win_serial         = ?							\n")	/* ������Ű   			*/
				  .append("		,remarks		= ?								\n")	/* ��� 						*/
				  .append("		,u_date        	= CURRENT TIMESTAMP		\n")	/* ������������ */
	      		  .append("		,u_empno       	= ?							\n")	/* ���������ڻ��      */
	      		  .append ("WHERE   item_sid 	= ?       						\n");
				  

		 arr_sql[10].append("DELETE FROM common.it_item WHERE item_sid = ?");	
		 
			}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}
	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		String sItem_cd 	= HDUtil.nullCheckStr(req.getParameter("sItem_cd"));	// ������ȣ
		String sItem_nm 	= HDUtil.nullCheckStr(req.getParameter("sItem_nm")); 	// ǰ��
		String sModel_nm 	= HDUtil.nullCheckStr(req.getParameter("sModel_nm")); // �𵨸� 
		//StringUtil.printMsg("������ȣ",sItem_cd,this);
		//StringUtil.printMsg("ǰ�� ",sItem_nm,this);
		//StringUtil.printMsg("�𵨸� ",sModel_nm,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					if ("DS1".equals(gauceName)) {
						if (!"".equals(sItem_cd)) { // ������ȣ
							 arr_sql[1].append("		 AND item_cd  =		? 	\n");	//������ȣ
						}
						if (!"".equals(sItem_nm)) { // ǰ��
							 arr_sql[1].append("		 AND item_nm = 	?  \n");	// ǰ�� 
						}
						if (!"".equals(sModel_nm)) { // �𵨸� 
							 arr_sql[1].append("		 AND model_nm  =  ?  \n");	// �𵨸� 
						}
						 arr_sql[1].append("		 ORDER BY item_cd					\n");
		
						 // ���� ����
				  		 
						//StringUtil.printMsg("QUERY",arr_sql[1].toString(),this);
						stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
						// ����
						if (!"".equals(sItem_cd)) {
							stmt.setString(sCnt1++, sItem_cd);		// ������ȣ
						}
						if (!"".equals(sItem_nm)) { 
							stmt.setString(sCnt1++, sItem_nm );	// ǰ�� 
						}
						if (!"".equals(sModel_nm)) { 
							 stmt.setString(sCnt1++, sModel_nm);	// �𵨸� 
						}
					}
					rs = stmt.executeQuery();		// Query ����
					getDataSet(rs, ds1).flush();
					sCnt1 = 1;
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
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		int fClientSid = 0;
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_ItemSid  	           	= ds1.indexOfColumn("item_sid".toUpperCase());
				int colNm_ItemCd      	        = ds1.indexOfColumn("item_cd".toUpperCase());
				int colNm_ItemNm              	= ds1.indexOfColumn("item_nm".toUpperCase());
				//int colNm_AssetCd              	= ds1.indexOfColumn("asset_cd".toUpperCase());
				int colNm_ModelNm              = ds1.indexOfColumn("model_nm".toUpperCase());
				int colNm_MadeCompany      = ds1.indexOfColumn("made_company".toUpperCase());
				int colNm_Cpu                 		= ds1.indexOfColumn("cpu".toUpperCase());
				int colNm_MainBoard             = ds1.indexOfColumn("mainboard".toUpperCase());
				int colNm_Hdd            			= ds1.indexOfColumn("hdd".toUpperCase());
				int colNm_Ram          			= ds1.indexOfColumn("ram".toUpperCase());
				int colNm_Graphic                 = ds1.indexOfColumn("graphic".toUpperCase());
				int colNm_PowerSupply          = ds1.indexOfColumn("powersupply".toUpperCase());
				int colNm_Dvd                 		= ds1.indexOfColumn("dvd".toUpperCase());
				int colNm_WinSerial               = ds1.indexOfColumn("win_serial".toUpperCase());
				int colNm_Remarks               = ds1.indexOfColumn("remarks".toUpperCase());
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[4].toString());	//common.it_item ����
					
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(iCnt++, colNm_ItemCd);
							stmt.bindColumn(iCnt++, colNm_ItemNm);
							//stmt.bindColumn(iCnt++, colNm_AssetCd);
							stmt.bindColumn(iCnt++, colNm_ModelNm);
							stmt.bindColumn(iCnt++, colNm_MadeCompany);
							stmt.bindColumn(iCnt++, colNm_Cpu);
							stmt.bindColumn(iCnt++, colNm_MainBoard);
							stmt.bindColumn(iCnt++, colNm_Hdd);
							stmt.bindColumn(iCnt++, colNm_Ram);
							stmt.bindColumn(iCnt++, colNm_Graphic);
							stmt.bindColumn(iCnt++, colNm_PowerSupply);
							stmt.bindColumn(iCnt++, colNm_Dvd);
							stmt.bindColumn(iCnt++, colNm_WinSerial);
							stmt.bindColumn(iCnt++, colNm_Remarks);
							stmt.setString(iCnt++, iParamEmpno);
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[7].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_ItemCd);
							stmt.bindColumn(uCnt++, colNm_ItemNm);
							//stmt.bindColumn(uCnt++, colNm_AssetCd);
							stmt.bindColumn(uCnt++, colNm_ModelNm);
							stmt.bindColumn(uCnt++, colNm_MadeCompany);
							stmt.bindColumn(uCnt++, colNm_Cpu);
							stmt.bindColumn(uCnt++, colNm_MainBoard);
							stmt.bindColumn(uCnt++, colNm_Hdd);
							stmt.bindColumn(uCnt++, colNm_Ram);
							stmt.bindColumn(uCnt++, colNm_Graphic);
							stmt.bindColumn(uCnt++, colNm_PowerSupply);
							stmt.bindColumn(uCnt++, colNm_Dvd);
							stmt.bindColumn(uCnt++, colNm_WinSerial);
							stmt.bindColumn(uCnt++, colNm_Remarks);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.bindColumn(uCnt++, colNm_ItemSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[10].toString());
							stmt.setGauceDataRow(rows[i]);
							stmt.bindColumn(dCnt++, colNm_ItemSid);
							
							// ��������
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							break;
					}
				
				}
			}	
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}
	}
}