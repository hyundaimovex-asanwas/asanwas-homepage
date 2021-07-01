package Ehr.but.a.buta070.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class BUTA070DAO extends AbstractDAO {

	/**
	 * BUTA070DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 여비지급기준 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA070_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		prop.add("GBN_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 여비지급기준 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("GBN_CD"),//pk
				vo.get("GBN_NAME"),
				vo.get("EXP_AMT1"),
				vo.get("EXP_AMT2"),
				vo.get("EXP_AMT3"),
				vo.get("EXP_AMT4"),
				vo.get("EXP_AMT5"),
				vo.get("EXP_AMT6"),
				p_box.get("vusrid"),//입력자
				p_box.get("vusrid")//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 여비지급기준 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("GBN_NAME"),
				vo.get("EXP_AMT1"),
				vo.get("EXP_AMT2"),
				vo.get("EXP_AMT3"),
				vo.get("EXP_AMT4"),
				vo.get("EXP_AMT5"),
				vo.get("EXP_AMT6"),
				p_box.get("vusrid"),//수정자
				vo.get("GBN_CD")//pk
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 여비지급기준 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("GBN_CD")//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
}
