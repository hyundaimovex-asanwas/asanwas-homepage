package pms.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pu040H_01 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			arr_sql[1].append (" {call PMS.PR_PU040H_01 (?,?,?,?)}");
			
			arr_sql[0].append ("SELECT 					 \n")
						  .append ("       VEND_CD,VEND_NM,VEND_ID,VEND_NO,VD_DIRECT,USE_TAG		 \n")
						  .append ("  FROM                      \n")
						  .append ("       ACCOUNT.GCZM_VENDER       \n")
						  .append (" WHERE 1=1 					\n")
						  .append ("   AND VEND_NM LIKE ?	\n");
				  
			
	}
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			try {
				for(int i=0; i<dSets.length;i++){
					
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("MASTER");
							String 	v_vend_nm		= HDUtil.nullCheckStr(greq.getParameter("v_vend_nm"));		//거래처명
			
							cstmt = conn.prepareCall(arr_sql[0].toString());
							cstmt.setString(1,  "%"+v_vend_nm+"%");
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1));
							break;
						}
					}
					gos.close();
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

			public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
			}
		}
