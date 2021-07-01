package Ehr.common.popup.education.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class EDUCATIONDAO extends AbstractDAO {

	/**
	 * EDUCATIONDAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUCATIONDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 과정코드 조회
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("COMM_CD")),
				JSPUtil.rns(p_box.getString("COMM_CD"))
                //JSPUtil.rns(p_box.get("COMM_CD"))
                //,JSPUtil.rns(p_box.get("COMM_CD"))
		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 차수 조회
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR_01(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			   JSPUtil.rns(p_box.get("EDU_CD"))
		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	/**
	 * 과정코드 조회
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR_C(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR_C");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("EDU_CD")),
				JSPUtil.rns(p_box.getString("EDU_CD"))				
               //JSPUtil.rns(p_box.get("EDU_CD"))
               //,JSPUtil.rns(p_box.get("EDU_CD"))
		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


}
