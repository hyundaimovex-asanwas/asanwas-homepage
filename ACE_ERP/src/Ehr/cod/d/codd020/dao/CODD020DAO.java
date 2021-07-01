package Ehr.cod.d.codd020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class CODD020DAO extends AbstractDAO {
    /**
     * ATCB013DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CODD020DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���հ�����Ȳ ��ȸ
     * @param p_box CBox
     * @throws CException
     */
	public void CODD020_SHR(CBox p_box ) throws CException {
		
		String eno_no = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		String str_ymd = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String end_ymd = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String app_yn = JSPUtil.rns(p_box.get("APP_YN_SHR"));
		
		/** �ܺ� XML���� ���α׷� ��� �α� ���� (��ȸ) SQL�� �о� �´� **/
		
		String sql = XmlSqlUtils.getSQL("cod", "CODD020_SHR");


		Object[] bind = new Object[] {
				str_ymd,
				end_ymd,
				eno_no,

				str_ymd,
				end_ymd,
				eno_no,

				str_ymd,
				end_ymd,
				eno_no,

				app_yn

		};

		prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PENO_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ENO_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
	
}

