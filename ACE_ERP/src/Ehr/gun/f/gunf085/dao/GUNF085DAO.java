package Ehr.gun.f.gunf085.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class GUNF085DAO extends AbstractDAO {

	/**
	 * GUNE011DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF085DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 한달 근무내용  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNF085_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),						
				p_box.get("ENO_NO"),
				p_box.get("REQ_NO"),				
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	
	
	/**
	 * 한달 근무 결재자정보  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNF085_SHR_01(CBox p_box) throws CException {

		//System.out.println("==================="+p_box);		
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				"O2",
								
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK1", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	
	/**
	 * 개별 근무 결재자정보  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNF085_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				"O3",
								
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK1", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	
	
	/**
	 * 연장근무 결재자정보(결재여부) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNF085_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),						//결재여부
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 					//수정자
				JSPUtil.rns(vo.get("REQ_NO")),						//품의번호
				JSPUtil.rns(p_box.get("vusrid"))	   				//사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 연장근무 결재 정보(결재여부) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNF085_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_UPT_02");

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),					//결재여부		
				JSPUtil.rns(p_box.get("vusrid")), 				//결재자 사번
				JSPUtil.rns(vo.get("REQ_NO")),					//신청번호
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	
	
	/**
	 * 개별상신 결재자정보(결재여부) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNF085_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_UPT_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),						//결재여부
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 					//수정자
				JSPUtil.rns(vo.get("REQ_NO")),						//품의번호
				JSPUtil.rns(p_box.get("vusrid"))	   				//사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 개별상신 결재 정보(결재여부) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNF085_UPT_04(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF085_UPT_04");

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),					//결재여부		
				JSPUtil.rns(p_box.get("vusrid")), 				//결재자 사번
				JSPUtil.rns(vo.get("REQ_NO")),					//신청번호
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	
	
}

