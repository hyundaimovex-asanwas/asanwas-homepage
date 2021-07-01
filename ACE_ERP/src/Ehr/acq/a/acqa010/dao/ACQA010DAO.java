package Ehr.acq.a.acqa010.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gauce.GauceDataSet;
import com.hmm.ejb.common.UtilDB;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA010DAO extends AbstractDAO {
	
	/**
	 * ACQA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR");

		/** 조회 조건에 따른 처리 **/
		//StringBuffer sb = new StringBuffer();

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		//Object[] sqlParam = new Object[] {
		//		sb.toString()
		//};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
                //JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	/**
	 * 문서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA010_SHR_01(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR");

		/** 조회 조건에 따른 처리 **/
		//StringBuffer sb = new StringBuffer();

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		//Object[] sqlParam = new Object[] {
		//		sb.toString()
		//};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);			
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	/**
	 * 결재 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA010_SHR_APP(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	
	
	
	
	
	
	/**
	 * 문서 정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
			JSPUtil.rns(vo.get("DOC_GB3")),
			JSPUtil.rns(vo.get("DOC_TITLE")),
			JSPUtil.rns(vo.get("DOC_REMARK")),
			"S",
			"1",
			JSPUtil.rns(vo.get("DOC_STATUS")),
			JSPUtil.rns(vo.get("FILE_KEY")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	
	
	
	
	
	/**
	 * 문서 정보를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("DOC_GB3")),
				JSPUtil.rns(vo.get("DOC_TITLE")),
				JSPUtil.rns(vo.get("DOC_REMARK")),
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(vo.get("APP_STATUS_CD")),
				JSPUtil.rns(vo.get("DOC_SEQ")),
				JSPUtil.rns(vo.get("DOC_STATUS")),
				JSPUtil.rns(vo.get("FILE_KEY")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("DOC_NO")),
				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	
	
	
	
	/**
	 * 결재자정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_INS_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_INS_APP");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),			//
				JSPUtil.rns(vo.get("SEQ_NO")),			//
				"S",
				JSPUtil.rns(p_box.get("vusrid")),		//상신자사번
				JSPUtil.rns(vo.get("ENO_NO")),			//결재자사번
				JSPUtil.rns(vo.get("DPT_CD")),			//결재자소속
				JSPUtil.rns(vo.get("JOB_CD")),			//결재자직위
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	
	
	
	
	/**
	 * 결재정보를 상신하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SUB");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);	

	}
	
	public void ACQA010_SUB2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SUB2");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);	

	}	
	
	
	
	/**
	 * 결재정보를 상신하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SMS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		//String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SMS");
		
		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		//Object[] bind = new Object[] {

		//		JSPUtil.rns(vo.get("DOC_TITLE")),				
		//		JSPUtil.rns(vo.get("ENO_NO")),
		//};

		System.out.println("############################################ query ############################################ ");
		
		
		Connection con = null;

        PreparedStatement pstmt = null;		
		
		
        StringBuffer query = new StringBuffer("INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 			\n");
				        query.append("	MT_REFKEY,											\n");
				        query.append("	DATE_CLIENT_REQ,									\n");
				        query.append("	CONTENT,											\n");
				        query.append("	CALLBACK,											\n");
				        query.append("	SERVICE_TYPE,										\n");
				        query.append("	BROADCAST_YN,										\n");
				        query.append("	MSG_STATUS,											\n");
				        query.append("	RECIPIENT_NUM,										\n");
				        query.append("	CARRIER)											\n");
				        query.append("	VALUES(												\n");
				        query.append("	'APS',												\n");
				        query.append(" 	GETDATE(),											\n");
				        query.append(" 	 ?,													\n");
				        query.append("	'0236693753',										\n");
				        query.append("	'0',												\n");
				        query.append("	'N',												\n");
				        query.append("	'1',												\n");
				        query.append("	 ?,													\n");			        
				        query.append("	 10001);											\n");	
																												

        
		System.out.println("###################### query: "+query.toString());
        
        
		/* SMS 보내는 부분 Start */

		String  DOC_TITLE		= JSPUtil.rns(vo.get("DOC_TITLE")); 		
		String  PHONE_NO		= JSPUtil.rns(vo.get("PHONE_NO")); 		
		String  Message 		= null;

		Message = "[현대아산 APS]" + DOC_TITLE + " 문서가 등록되었습니다.";					

		
        try {

            con = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");

            pstmt = con.prepareStatement(query.toString());

            pstmt.setString(1, Message);
            pstmt.setString(2, PHONE_NO);

            pstmt.executeUpdate();

            pstmt.close();
            con.close();	

        } catch( SQLException e) {
        	
            e.printStackTrace();

        } finally {
        	
            UtilDB.closeConnection(con, pstmt);
        }
		
		
		
		//con = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
		
        //StringUtil.printMsg("Message::",Message,this);								
		
		//cstmt_ms = con_sms.prepareCall(arr_sql[3].toString());

		//cstmt_ms.setString(1, Message);
		//cstmt_ms.setString(2, v_phone);
		
		//rs_ms = cstmt_ms.executeQuery();
		
		//gos.write(getDataSet(rs_ms, ds3));

		//rs_ms.close();
		//cstmt_ms.close();
		//con.close();		
		
		
		
		
		
		
		/** INSERT메소드 호출  **/
		//insertProcess(sql, bind);		

	}	
	

	
	/**
	 * 문서를 삭제하는  DAO메소드.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void ACQA010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid"))
				
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	
	
	/**
     * 결재자정보 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void ACQA010_DEL_APP(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_DEL_APP");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))				

		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	
}
