package Ehr.cod.e.code061.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE061DAO extends AbstractDAO {
	/**
	 * PIRC021DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE061DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}


	/**
	 * ��Ÿ���系��
	 * @param p_box
	 * @throws CException
	 */
	public void CODE061_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE061_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
		};

		prop.add("SD_GBN", ColumnProp.COLUMN_TYPE_STRING , 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * ��Ÿ��������
	 * @param p_box
	 * @throws CException
	 */
	public void CODE061_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE061_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

}
