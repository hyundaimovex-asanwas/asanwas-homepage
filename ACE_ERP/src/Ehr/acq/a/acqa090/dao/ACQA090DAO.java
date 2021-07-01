package Ehr.acq.a.acqa090.dao;


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


public class ACQA090DAO extends AbstractDAO {
	
	/**
	 * ACQA090DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA090DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}


	
	/**
	 * 문서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA090_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_SHR");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO_SHR"))				

        };
		
		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	/**
	 * 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA090_SHR_APP(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_SHR_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		//prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	
	/**
	 * 결재 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA090_SHR_APP2(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_SHR_APP2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		//prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	
	
	/**
	 * 정보를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA090_APP_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_APP_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid")),

				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	
	/**
	 * 동일 문서번호의 결재한개수세기(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet ACQA090_APP_CNT(GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_APP_CNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),				//문서번호
				JSPUtil.rns(vo.get("REQ_NO")),				//문서번호
				JSPUtil.rns(vo.get("REQ_NO")),				//품의번호

		};

		/** UPDATE메소드 호출  **/
		return selectProcess(sql, bind);
	}

	
	
	public void ACQA090_APP_END(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA090_APP_END");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("REQ_NO")),

		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	
	
}
