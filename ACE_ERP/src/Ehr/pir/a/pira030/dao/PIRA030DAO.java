package Ehr.pir.a.pira030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030DAO extends AbstractDAO {
	/** 
	 * PIRA030DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA030DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA030_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA030_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDGR_CD", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}
