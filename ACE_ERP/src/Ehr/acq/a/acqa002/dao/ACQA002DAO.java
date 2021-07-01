package Ehr.acq.a.acqa002.dao;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA002DAO extends AbstractDAO {
	
	/**
	 * ACQA002DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA002DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA002_SHR_ACC(CBox p_box) throws CException {
		
		
		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"PC",
				"��ü ���� ��Ȳ",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"D",
				p_box.get("FILE_NM"),
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);				

	}		
	

	
}
