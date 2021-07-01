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
     * ACQA040DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CODD010DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���հ�����Ȳ ��ȸ
     * @param p_box CBox
     * @throws CException
     */
	public void CODD010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���α׷� ��� �α� ���� (��ȸ) SQL�� �о� �´� **/
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

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
}
