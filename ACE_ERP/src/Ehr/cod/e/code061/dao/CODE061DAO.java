package Ehr.cod.e.code061.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE061DAO extends AbstractDAO {
	/**
	 * PIRC021DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE061DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}


	/**
	 * 기타수당내역
	 * @param p_box
	 * @throws CException
	 */
	public void CODE061_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE061_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
		};

		prop.add("SD_GBN", ColumnProp.COLUMN_TYPE_STRING , 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * 기타공제내역
	 * @param p_box
	 * @throws CException
	 */
	public void CODE061_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE061_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

}
