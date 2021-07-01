package Ehr.sag.d.sagd200.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGD200DAO extends AbstractDAO {

	/**
	 * SAGD200DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD200DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void SAGD200_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"sagd200",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	/**
	 * 급여테이블 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


	/**
	 * 급여테이블 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_SO(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_SO");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 적용일자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 출력문 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_PRINT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}




}
