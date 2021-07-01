/**************************************************************************************
 * 시스템명		: 전산기기 등록
 * 프로그램ID 	: am200i
 * J  S  P		: am200i
 * 서 블 릿		: am200i
 * [수  정   일  자][수정자] 내용
 * [2011-01-10][박경국] 전산기기관리에 있어서 전산기기 등록 및 관리하는 화면
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
		 * 전산기기 조회
		 */
		arr_sql[1].append("SELECT item_sid			    												\n")	/* 전산기기SID      	*/
	      		  .append("		 ,item_cd        												 				\n")	/* 항목코드          	*/
	      		  .append("		 ,asset_cd      												 				\n")	/* 자산코드          	*/
	      		  .append("		 ,item_nm     												 					\n")	/* 품목                 	*/
	      		  .append("		 ,model_nm      												 				\n")	/* 모델명	         	*/
	      		  .append("		 ,made_company        													\n")	/* 제조사 	        	*/
	      		  .append("		 ,cpu         												 					\n")	/* cpu		         	*/
	      		  .append("		 ,mainboard        															\n")	/* 메인보드         	*/
	      		  .append("		 ,hdd    																		\n")	/* hdd  				    */
	      		  .append("		 ,ram  																			\n")	/* ram	              	*/
	      		  .append("		 ,graphic         																\n")	/* 그래픽카드       	*/
	      		  .append("		 ,powersupply      															\n")	/* 파워서플라이    	*/
	      		  .append("		 ,dvd         																	\n")	/* dvd                  	*/
	      		  .append("		 ,win_serial         															\n")	/* 윈도우키          	*/
	      		  .append("		 ,remarks         																\n")	/* 비고  		        */
	      		  .append("		 ,i_empno       																\n")	/* 입력자             	*/
	      		  .append("		 ,i_date        																	\n")	/* 입력일시          	*/
	      		  .append("		 ,u_empno      																\n")	/* 수정자             	*/
	      		  .append("		 ,u_date     																	\n")	/* 수정일시         	*/
	      		  
	      		  .append("FROM  common.it_item 															\n")
	      		  .append("WHERE 1 = 1 																		\n");
	      		  
		/*
		 * 전산기기 등록
		 */
		arr_sql[4].append("INSERT INTO common.it_item  (")
				  .append("				 item_cd        	\n")		/* 고유번호		        	*/
				  //.append("				,asset_cd      	\n")		/* 자산코드                	*/
				  .append("				,item_nm      		\n")		/* 품목 		                 	*/
				  .append("				,model_nm      	\n")		/*모델명 			        	*/
				  .append("				,made_company        \n")	/* 제조사 	   		     	*/
				  .append("				,cpu         		\n")		/* cpu         					*/
				  .append("				,mainboard        \n")		/* 메인보드         			*/
				  .append("				,hdd    				\n")		/* 하드디스크    			*/
				  .append("				,ram  				\n")		/* 램               				*/
				  .append("				,graphic         	\n")		/* 그래픽카드                */
				  .append("				,powersupply     \n")		/* 파워서플라이             */
				  .append("				,dvd         		\n")		/* dvd                   		*/
				  .append("				,win_serial         \n")		/* 윈도우키                    */
				  .append("				,remarks        	\n")		/* 비고     						*/
				  .append("		 		,u_date       		\n") 	/* 최종수정일자             */
	      		  .append("		 		,u_empno       	\n")		/* 최종수정자사번          */
	      		  .append("			)							\n")
				  
				  .append("VALUES							\n")
				  .append("			(	    					\n")
				  .append("				?,?,?,?,?,			\n")	
				  .append("				?,?,?,?,?,			\n")
				  .append("				?,?,?,CURRENT TIMESTAMP,?	\n")
				  .append("			)");
		
	
		/*
		 * 전산기기 수정
		 */
		arr_sql[7].append("UPDATE common.it_item 		SET				\n")
				  .append("		 item_cd		= ?     							\n")	/* 고유번호	         	*/
				  .append("		,item_nm		= ?     							\n")	/* 품목                  	*/
				  .append("		,model_nm		= ?    				 		\n")	/* 모델명       		  	*/
				  .append("		,made_company			= ?     			\n")	/* 제조사    		     	*/
				  .append("		,cpu      	= ?  									\n")	/* cpu         				*/
				  .append("		,mainboard	= ?    							\n")	/* 메인보드     			*/
				  .append("		,hdd	= ?  											\n")	/* 하드디스크            */
				  .append("		,ram        = ?										\n")	/* 램                   		*/
				  .append("		,graphic      = ?									\n")	/* 그래픽카드            */
				  .append("		,powersupply         = ?						\n")	/* 파워서플라이         */
				  .append("		,dvd         = ?									\n")	/* dvd                   	*/
				  .append("		,win_serial         = ?							\n")	/* 윈도우키   			*/
				  .append("		,remarks		= ?								\n")	/* 비고 						*/
				  .append("		,u_date        	= CURRENT TIMESTAMP		\n")	/* 최종수정일자 */
	      		  .append("		,u_empno       	= ?							\n")	/* 최종수정자사번      */
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
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		String sItem_cd 	= HDUtil.nullCheckStr(req.getParameter("sItem_cd"));	// 고유번호
		String sItem_nm 	= HDUtil.nullCheckStr(req.getParameter("sItem_nm")); 	// 품목
		String sModel_nm 	= HDUtil.nullCheckStr(req.getParameter("sModel_nm")); // 모델명 
		//StringUtil.printMsg("고유번호",sItem_cd,this);
		//StringUtil.printMsg("품목 ",sItem_nm,this);
		//StringUtil.printMsg("모델명 ",sModel_nm,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					if ("DS1".equals(gauceName)) {
						if (!"".equals(sItem_cd)) { // 고유번호
							 arr_sql[1].append("		 AND item_cd  =		? 	\n");	//고유번호
						}
						if (!"".equals(sItem_nm)) { // 품목
							 arr_sql[1].append("		 AND item_nm = 	?  \n");	// 품목 
						}
						if (!"".equals(sModel_nm)) { // 모델명 
							 arr_sql[1].append("		 AND model_nm  =  ?  \n");	// 모델명 
						}
						 arr_sql[1].append("		 ORDER BY item_cd					\n");
		
						 // 쿼리 실행
				  		 
						//StringUtil.printMsg("QUERY",arr_sql[1].toString(),this);
						stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
						// 조건
						if (!"".equals(sItem_cd)) {
							stmt.setString(sCnt1++, sItem_cd);		// 고유번호
						}
						if (!"".equals(sItem_nm)) { 
							stmt.setString(sCnt1++, sItem_nm );	// 품목 
						}
						if (!"".equals(sModel_nm)) { 
							 stmt.setString(sCnt1++, sModel_nm);	// 모델명 
						}
					}
					rs = stmt.executeQuery();		// Query 실행
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
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
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
							stmt = conn.getGauceStatement(arr_sql[4].toString());	//common.it_item 저장
					
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
							// 쿼리실행
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
							
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[10].toString());
							stmt.setGauceDataRow(rows[i]);
							stmt.bindColumn(dCnt++, colNm_ItemSid);
							
							// 쿼리실행
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