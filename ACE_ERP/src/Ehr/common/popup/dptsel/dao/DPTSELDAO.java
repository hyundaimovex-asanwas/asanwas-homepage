package common.popup.dptsel.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class DPTSELDAO extends AbstractDAO {
	/** 
	 * DPTSELDAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public DPTSELDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
	
	/**
	 * �μ�Ʈ�� ��ȸ�� ����   DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void DPTSEL_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "DPTSEL_SHR");
		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
		};
		
		prop.add("DPT_CD", ColumnProp.COLUMN_TYPE_STRING, 6, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
}
