package Ehr.gun.e.gune010.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class GUNE010DAO extends AbstractDAO {
	/**
	 * GUNA012DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 자동결재선 조회
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_APP(CBox p_box) throws CException {

		/** 외부 XML에서 자동결재선 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_APP");

		
		/** 조회 조건(조건2)에 따른 처리 #2  상태**/
		StringBuffer sb1 = new StringBuffer();
		//String dptcd = JSPUtil.rns(p_box.get("DPT_CD"));

		if (p_box.get("DPT_CD").equals("II25")) {
			sb1.append("AND B.DPT_CD = 'II20'\n");
			sb1.append("AND B.DUTY_CD = '41'");
		}
		else if (p_box.get("DPT_CD").equals("II35")) {
			sb1.append("AND B.DPT_CD = 'II33'\n");
			sb1.append("AND B.DUTY_CD = '04'");
		}
		else if (p_box.get("DPT_CD").equals("II55")) {
			sb1.append("AND B.DPT_CD = 'II45'\n");	
			sb1.append("AND B.DUTY_CD = '41'");
		}
		else {
			sb1.append("AND A.DPT_CD = B.DPT_CD\n");
			sb1.append("AND B.DUTY_CD = '41'");
		}
		
		Object[] sqlParam = new Object[] {
				sb1.toString(),
		
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),
				
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),				
				
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),	
		};

		 this.selectProcessFirstRow(sql, bind, prop);

	}
	
	/**
	 * 주차 조회
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_WK(CBox p_box) throws CException {

		/** 외부 XML에서 자동결재선 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_WK");
		
		String REG_YMD  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", ""));
		
		String PIS_YM  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", "").substring(0, 4));		

		
		
		//System.out.println(REG_YMD);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				REG_YMD,
				PIS_YM
		};

		 this.selectProcessFirstRow(sql, bind, prop);

	}	
	/**
	 * 사원 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 당월 연장근무 누적시간을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_ACC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_ACC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("WEEK_NO")),
				JSPUtil.rns(p_box.get("ENO_NO"))
		};
        
		prop.add("WEEK_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HOL_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ALL_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 당월 연장근무 등록가능일자를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNE010_SHR_OTD(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_OTD");
		
		String REG_YMD  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", ""));
				
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				REG_YMD
		};

		//return this.selectProcessFirstRow(sql, bind, prop);
		return this.selectProcess(sql, bind, prop);
		
		
	}
	
	/**
	 * 당월 연장근무 누적시간을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_MAX(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_MAX");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				//JSPUtil.rns(p_box.get("WEEK_NO")),
				//JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * 연장근무 내역을 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_UPT_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_UPT_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("STR_REG_YMD")),
				JSPUtil.rns(vo.get("STR_OVR_TIME")),
				JSPUtil.rns(vo.get("END_REG_YMD")),
				JSPUtil.rns(vo.get("END_OVR_TIME")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(vo.get("GUBN")),
				JSPUtil.rns(vo.get("WEEK_TOT_TIME")),
				JSPUtil.rns(vo.get("HOL_TOT_TIME")),
				JSPUtil.rns(vo.get("ALL_TOT_TIME")),
				JSPUtil.rns(vo.get("WEEK_OF_YEAR")),
				JSPUtil.rns(vo.get("OVR_TIME")),
				JSPUtil.rns(p_box.get("APP_YN")),
				JSPUtil.rns(vo.get("JOB_CD")),
				
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
		
	/**
	 * 결재선을 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_UPT_APP_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_UPT_APP_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(p_box.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				//JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * SMS 전송하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 * @throws SQLException 
	 */
	public void GUNE010_SMS(CBox p_box) throws CException, SQLException {

        PreparedStatement pstmt = null;
        
        StringBuffer query = new StringBuffer();
        
		Connection conn;
		//System.out.print("---------------------------   444444444444444444   ---------");
		//System.out.print(p_box);	
		try{
			
			conn = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");

				// SMS 발송
				query.append ("	INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 			\n");
				query.append ("		MT_REFKEY,                               	\n");
				query.append ("		DATE_CLIENT_REQ,                            \n");
				query.append ("		CONTENT,                             		\n");
				query.append ("		CALLBACK, 									\n");
				query.append ("		SERVICE_TYPE,                               \n");
				query.append ("		BROADCAST_YN,                               \n");
				query.append ("		MSG_STATUS,                             	\n");
				query.append ("		RECIPIENT_NUM, 								\n");				
				query.append ("		CARRIER )									\n");				
				query.append ("	VALUES (										\n");
				query.append ("		'FAM',  									\n");
				query.append ("		GETDATE(),  								\n");
				query.append ("		'TEST',                                     \n");				
				query.append ("		'0236693900', 								\n");
				query.append ("		'0',  										\n");
				query.append ("		'N',  										\n");
				query.append ("		'1',  										\n");		
				query.append ("		'01095001915',								\n");					
				query.append ("		10001 ); 									\n");		
				
				//Log.main.println(query.toString());
				pstmt = conn.prepareStatement(query.toString());
				
				//pstmt.setString(++colCnt, ENO_NO);		//사원번호
				
				ResultSet rs = pstmt.executeQuery();



		}finally {

			
			
		}		
		
		
		pstmt.close();
		conn.close();
		
		
	}	
	
	
	

}
