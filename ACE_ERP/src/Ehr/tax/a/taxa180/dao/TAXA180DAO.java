package Ehr.tax.a.taxa180.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class TAXA180DAO extends AbstractDAO {
	/**
	 * TAXA180DAO ������
	 * @param p_conn	   Connection
	 * @param p_tr		   TrBox
	 * @throws CException
	 */
	public TAXA180DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void TAXA180_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ���̺� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("tax", "TAXA180_SHR");

		//System.out.println(p_box);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM_TO").replaceAll("-", ""), 				
				p_box.get("PIS_YM_FR").replaceAll("-", ""), 
				p_box.get("ENO_NO")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	public void TAXA180_SHR2(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ���̺� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("tax", "TAXA180_SHR2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
}
