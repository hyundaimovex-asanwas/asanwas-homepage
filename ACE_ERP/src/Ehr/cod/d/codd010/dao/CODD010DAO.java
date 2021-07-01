package Ehr.cod.d.codd010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODD010DAO extends AbstractDAO {
    /**
     * ACQA040DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CODD010DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 통합결재현황 조회
     * @param p_box CBox
     * @throws CException
     */
	public void CODD010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 프로그램 사용 로그 정보 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODD010_SHR");

		StringBuffer sb1 = new StringBuffer();
			sb1.append("APP_GBN LIKE '"+p_box.get("APP_GBN_SHR")+"'");

		Object[] sqlParam = new Object[] {
				sb1.toString(),
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {

				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),	
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),		
				p_box.get("ENO_NO_SHR"),					
				p_box.get("ENO_NO_SHR"),
				p_box.get("ENO_NO_SHR"),		
				p_box.get("ENO_NO_SHR"),				
				p_box.get("ENO_NO_SHR")
		};

		prop.add("APP_GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_TITLE", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
}
