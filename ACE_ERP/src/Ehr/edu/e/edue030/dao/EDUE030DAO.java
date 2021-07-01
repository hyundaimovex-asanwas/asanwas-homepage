package Ehr.edu.e.edue030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;


public class EDUE030DAO extends AbstractDAO {
	/**
	 * EDUE030DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 현재모집과정 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 현재모집과정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("EDU_CD")),
				JSPUtil.rns(p_box.getString("FIELD_CD")),
				JSPUtil.rns(p_box.getString("SHAPE_CD"))
		};

		//prop.add("EDU_TERM", ColumnProp.COLUMN_TYPE_STRING , 25, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("CLOSE_YN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
}
