package Ehr.gun.d.gund050.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUND050DAO extends AbstractDAO {
	/**
	 * GUND040DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND050DAO(String p_conn, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);

	}

	/**
	 * ���κ� ���� ���� ��Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUND050_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ� ���� ���� ��Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND050_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),	    	//
				p_box.get("DPT_CD"),	   		//
				p_box.get("SUBMIT_SHR"),		// 

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		//this.selectProcess(sql, bind, prop);
		return this.selectProcess(sql, bind, prop);
		//return this.selectProcessFirstRow(sql, bind, prop);
	}


}
