package Ehr.acq.a.acqa001.dao;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA001DAO extends AbstractDAO {
	
	/**
	 * ACQA001DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA001DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA001_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR");

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
	public GauceDataSet ACQA001_SHR_01(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR");

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
				
                JSPUtil.rns(p_box.get("DOC_GB1")),				
                JSPUtil.rns(p_box.get("DOC_GB2")),
                JSPUtil.rns(p_box.get("DOC_GB3"))				
                //JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };
		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	/**
	 * 문서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA001_SHR_ACC(CBox p_box) throws CException {
		
		
		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"PC",
				"전체 진행 현황",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S",
				""
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);				

	}		
	
	/**
	 * 결재 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA001_SHR_APP(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR_APP");

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
	public void ACQA001_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_INS");

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
	public void ACQA001_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_UPT");

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
	public void ACQA001_INS_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_INS_APP");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),			//
				JSPUtil.rns(vo.get("SEQ_NO")),			//
				"A",
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
	public void ACQA001_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SUB");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);	

	}
	
	

	
	/**
	 * 문서를 삭제하는  DAO메소드.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void ACQA001_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_DEL");

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
	public void ACQA001_DEL_APP(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_DEL_APP");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))				

		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	
}
