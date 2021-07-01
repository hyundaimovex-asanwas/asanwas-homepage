package Ehr.cod.b.codb010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODB010DAO extends AbstractDAO {

	/**
	 * CODB010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODB010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 코드,코드명에 따른 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODB010_SHR(CBox p_box) throws CException {

		//System.out.println("p_box=================="+p_box);

		//System.out.println("COMM_CD=================="+p_box.getString("COMM_CD"));			
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_SHR");  			

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
	    
			 JSPUtil.rns(p_box.getString("COMM_CD")),
			 JSPUtil.rns(p_box.getString("COMM_CD"))	        

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 코드에 따른 공통코드 상세 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODB010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 공통코드 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD")),//pk
				JSPUtil.rns(vo.get("COMM_NM")),
				JSPUtil.rns(vo.get("COMM_NM2")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns3(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),
				JSPUtil.rns(vo.get("EXT_01")),
				JSPUtil.rns(vo.get("EXT_02")),
				JSPUtil.rns(vo.get("EXT_03")),
				JSPUtil.rns(vo.get("EXT_04")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("REMARK2")),
				JSPUtil.rns(vo.get("REMARK3")),
				JSPUtil.rns(vo.get("OTH_DEC")),
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 공통코드 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("COMM_NM")),
				JSPUtil.rns(vo.get("COMM_NM2")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns3(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),
				JSPUtil.rns(vo.get("EXT_01")),
				JSPUtil.rns(vo.get("EXT_02")),
				JSPUtil.rns(vo.get("EXT_03")),
				JSPUtil.rns(vo.get("EXT_04")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("REMARK2")),
				JSPUtil.rns(vo.get("REMARK3")),
				JSPUtil.rns(vo.get("OTH_DEC")),
				JSPUtil.rns(p_box.get("vusrid")),//수정자
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD"))//pk
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 공통코드 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("COMM_CD"))//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}