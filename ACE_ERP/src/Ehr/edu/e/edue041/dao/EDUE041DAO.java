package Ehr.edu.e.edue041.dao;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DateUtil;
import Ehr.common.util.JSPUtil;

public class EDUE041DAO extends AbstractDAO {

	/**
	 * GUNA071DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE041DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 결재세부사항 조회(변경신청) 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE041_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * 결재정보
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE041_SHR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_APPROVAL_SHR");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
        Object[] bind = new Object[] {
        	p_box.get("REQ_NO")                     
        };

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}

	
	
	public void EDUE041_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR_PRINT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	public void EDUE041_SHR_PRINT2(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_SHR_PRINT2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	
	
	
	/**
	 * 결재 처리내용을 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("CPT_TAG")),				//비고 -> 필드전용  Container 역할
				p_box.get("vusrid"),
				p_box.get("SEQ_NO"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 동일 등록번호의 결재한개수세기(최종 T_DI_DILIGENCE)(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet EDUE041_CNT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_CNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE메소드 호출  **/
		return selectProcess(sql, bind);
	}
	/**
	 * T_DI_DILIGENCE 에 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT_01(String APP_YN, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * T_DI_DILIGENCE 에 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void EDUE041_UPT_02(String PIS_YYMMDD, GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE041_UPT_02");

		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +" = 'F',");


		Object[] sqlParam = new Object[] {
				sb.toString(),

		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				JSPUtil.rns(vo.get("ENO_NO")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

}

