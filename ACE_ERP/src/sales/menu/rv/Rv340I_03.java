package sales.menu.rv;
/*
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
*/

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

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


public class Rv340I_03 extends SuperServlet {

	public void makeSql() {
		StringUtil.printMsg("����������","---------------------------------------", this);
	
		for(int i=0; i<arr_sql.length; i++){
			arr_sql[i] = new StringBuffer();
		}

		//��ȸ
		arr_sql[0].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");

		//�Ա���ȸ(������ȸ)
		arr_sql[1].append (" {call SALES.PR_RV340i_01 (?, ?, ?)}");

		arr_sql[2].append (" {call SALES.PR_RV340i_02 (?, ?, ?)}");
		 
		arr_sql[3].append (" {call SALES.PR_RV340i_03 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");			

	}
		
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) 	throws ServletException, Exception {
		StringUtil.printMsg("�ʱ�ȭ","000000000000000000000000000000000000", this);
	}		
		
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		StringUtil.printMsg("��ȸ","1111111111111111111111111111111111", this);
	}

//	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		//StringUtil.printMsg("����","2222222222222222222222222222222222222222", this);			
	//}
	
	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("MASTER");
		StringUtil.printMsg("����","2222222222222222222222222222222222222222", this);

		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		int 	sSaupSid	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
	}	
	
	
	
	
	
};//public class....