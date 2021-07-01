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
	 * EDUE030DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ����������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ����������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE030_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("EDU_CD")),
				JSPUtil.rns(p_box.getString("FIELD_CD")),
				JSPUtil.rns(p_box.getString("SHAPE_CD"))
		};

		//prop.add("EDU_TERM", ColumnProp.COLUMN_TYPE_STRING , 25, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("CLOSE_YN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	
}
