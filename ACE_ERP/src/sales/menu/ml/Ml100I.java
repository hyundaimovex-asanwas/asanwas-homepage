package sales.menu.ml;

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

public class Ml100I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append ("SELECT  \n")           
					  .append (" ITEM_SID, CATE1 AS CATE1, CATE2 AS CATE2, BRAND AS BRAND, ITEM_NM AS ITEM_NM \n")
					  .append (" ,MAKER, MADEIN, CASE WHEN DSP_YN='Y' THEN 'T' ELSE 'F' END DSP_YN       \n")
					  .append (" , CASE WHEN USE_YN='Y' THEN 'T' ELSE 'F' END USE_YN        \n")
					  .append (" ,SELLER_CD, SELLER_SID, CASE WHEN TAX_YN='Y' THEN 'T' ELSE 'F' END TAX_YN, CURRENCY_CD           \n")
					  .append (" ,AMT_UNIT, AMT_NET, AMT_VAT, AMT_EMP                  \n")
					  .append (" ,REMARKS 					\n")
					  .append (" FROM SALES.TML100	\n");
				  
		arr_sql[2].append("CALL SALES.PR_ML100I_01(?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?)");		//업데이트  18개		  		
		arr_sql[3].append("CALL SALES.PR_ML100I_02(?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?)");		//인서트하기  17개	
		arr_sql[4].append("CALL SALES.PR_ML100I_03(?)");		//인서트하기  17개	
	
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
			}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		//int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 상품 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		 String 		v_cate1		= HDUtil.nullCheckStr(req.getParameter("v_cate1"));
		// int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		// String	v_menu_cd	 	= HDUtil.nullCheckStr(req.getParameter("v_menu_cd"));
		 
		 StringUtil.printMsg("v_cate1=", v_cate1, this);

	
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				StringUtil.printMsg("gauceName++=", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
/*
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(sCnt1++, v_cate1);
						*/
						
						if (!"".equals(v_cate1))
							arr_sql[1].append (" WHERE cate1 = ? \n");
						stmt = conn.getGauceStatement(arr_sql[1].toString());	
						if (!"".equals(v_cate1))
							stmt.setString(sCnt1++, v_cate1);						
						//StringUtil.printMsg("sCnt1++=", sCnt1++, this);
					//	cstmt.setInt(sCnt1++, v_upjang_sid);
					//	cstmt.setString(sCnt1++, v_menu_cd);
					
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

		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;
		//StringUtil.printMsg("입력",this);
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		//String iParamEmpno = fParamEmpno;
		//String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DEFAULT");	

		try{
			//내부 변수
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_item_sid			=ds1.indexOfColumn("ITEM_SID"); 
				int colNm_cate1			=ds1.indexOfColumn("CATE1");       
				int colNm_cate2		= ds1.indexOfColumn("CATE2");       
				int colNm_brand		= ds1.indexOfColumn("BRAND");							 
				int colNm_item_nm		= ds1.indexOfColumn("ITEM_NM");
				int colNm_maker		=ds1.indexOfColumn("MAKER"); 
				int colNm_madein		=ds1.indexOfColumn("MADEIN");		
				int colNm_dsp_yn			=ds1.indexOfColumn("DSP_YN");       
				int colNm_use_yn		= ds1.indexOfColumn("USE_YN");       
				int colNm_seller_cd		= ds1.indexOfColumn("SELLER_CD");							 
				int colNm_seller_sid		= ds1.indexOfColumn("SELLER_SID");
				int colNm_tax_yn		=ds1.indexOfColumn("TAX_YN"); 
				int colNm_currency_cd		=ds1.indexOfColumn("CURRENCY_CD");	
				int colNm_amt_unit			=ds1.indexOfColumn("AMT_UNIT");       
				int colNm_amt_net		= ds1.indexOfColumn("AMT_NET");       
				int colNm_amt_vat		= ds1.indexOfColumn("AMT_VAT");							 
				int colNm_amt_emp		= ds1.indexOfColumn("AMT_EMP");
				int colNm_remarks		=ds1.indexOfColumn("REMARKS"); 
			
								
				//int colNm_U_EMPNO    	=	ds1.indexOfColumn("U_EMPNO");		//최종수정자사번
				//int colNm_U_IP       	=	ds1.indexOfColumn("U_IP");			//최종수정IP  
				
				for(int i = 0; i < rows.length; i++) {
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);

						if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT) {
									
							StringUtil.printMsg("insert type=", "1", this);								
							cstmt = conn.prepareCall(arr_sql[3].toString());																
					/*		StringUtil.printMsg("회차       - ",rows[i].getString(colNm_use_seq)	, this); 
							StringUtil.printMsg("수량       - ",rows[i].getString(colNm_menu_cnt)	, this);
							StringUtil.printMsg("업장명       - ",rows[i].getString(colNm_upjang_sid)	, this); 
							StringUtil.printMsg("메뉴정보       - ",rows[i].getString(colNm_menu_sid)	, this); 
							StringUtil.printMsg("시작일자       - ",rows[i].getString(colNm_bgn_date)	, this); 
							StringUtil.printMsg("종료일자       - ",rows[i].getString(colNm_end_date)	, this); 
							
						*/
							cstmt.setString(1, rows[i].getString(colNm_cate1));
							cstmt.setString(2, rows[i].getString(colNm_cate2));	
							cstmt.setString(3, rows[i].getString(colNm_brand));	
							cstmt.setString(4, rows[i].getString(colNm_item_nm));	
							cstmt.setString(5, rows[i].getString(colNm_maker));	
							cstmt.setString(6, rows[i].getString(colNm_madein));	
						//	cstmt.setString(7, rows[i].getString(colNm_dsp_yn));								
							if (  rows[i].getString(colNm_dsp_yn).equals("T") ) {
								cstmt.setString(7, "Y");
							} else {
								cstmt.setString(7, "N");
							}												
							//cstmt.setString(8, rows[i].getString(colNm_use_yn));	
							if (  rows[i].getString(colNm_use_yn).equals("T") ) {
								cstmt.setString(8, "Y");
							} else {
								cstmt.setString(8, "N");
							}												
							cstmt.setString(9, rows[i].getString(colNm_seller_cd));		
							cstmt.setInt(10, rows[i].getInt(colNm_seller_sid));
							//cstmt.setString(11, rows[i].getString(colNm_tax_yn));							
							if (  rows[i].getString(colNm_tax_yn).equals("T") ) {
								cstmt.setString(11, "Y");
							} else {
								cstmt.setString(11, "N");
							}													
							cstmt.setString(12, rows[i].getString(colNm_currency_cd));	
							cstmt.setInt(13, rows[i].getInt(colNm_amt_unit));
							cstmt.setInt(14, rows[i].getInt(colNm_amt_net));
							cstmt.setInt(15, rows[i].getInt(colNm_amt_vat));
							cstmt.setInt(16, rows[i].getInt(colNm_amt_emp));
							cstmt.setString(17, rows[i].getString(colNm_remarks));		
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							
							} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT) {
				         if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
							cstmt = conn.prepareCall(arr_sql[2].toString());		
							cstmt.setString(1, rows[i].getString(colNm_cate1));
							cstmt.setString(2, rows[i].getString(colNm_cate2));	
							cstmt.setString(3, rows[i].getString(colNm_brand));	
							cstmt.setString(4, rows[i].getString(colNm_item_nm));	
							cstmt.setString(5, rows[i].getString(colNm_maker));	
							cstmt.setString(6, rows[i].getString(colNm_madein));	
						//	cstmt.setString(7, rows[i].getString(colNm_dsp_yn));								
							if (  rows[i].getString(colNm_dsp_yn).equals("T") ) {
								cstmt.setString(7, "Y");
							} else {
								cstmt.setString(7, "N");
							}												
							//cstmt.setString(8, rows[i].getString(colNm_use_yn));	
							if (  rows[i].getString(colNm_use_yn).equals("T") ) {
								cstmt.setString(8, "Y");
							} else {
								cstmt.setString(8, "N");
							}												
							cstmt.setString(9, rows[i].getString(colNm_seller_cd));		
							cstmt.setInt(10, rows[i].getInt(colNm_seller_sid));
							//cstmt.setString(11, rows[i].getString(colNm_tax_yn));							
							if (  rows[i].getString(colNm_tax_yn).equals("T") ) {
								cstmt.setString(11, "Y");
							} else {
								cstmt.setString(11, "N");
							}													
							cstmt.setString(12, rows[i].getString(colNm_currency_cd));	
							cstmt.setInt(13, rows[i].getInt(colNm_amt_unit));
							cstmt.setInt(14, rows[i].getInt(colNm_amt_net));
							cstmt.setInt(15, rows[i].getInt(colNm_amt_vat));
							cstmt.setInt(16, rows[i].getInt(colNm_amt_emp));
							cstmt.setString(17, rows[i].getString(colNm_remarks));
							cstmt.setInt(18, rows[i].getInt(colNm_item_sid));		
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
				         }//job_update				
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
					   cstmt = conn.prepareCall(arr_sql[4].toString());		
					   cstmt.setInt(1, rows[i].getInt(colNm_item_sid));		
					   cstmt.executeUpdate();
					   if(cstmt!=null) cstmt.close();
					}//job_delete									         
				         			   
				}//for(int i=0; i<row.length; i++)
			}//if ds1!=
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{	

	}//apply
			
}//super servlet
