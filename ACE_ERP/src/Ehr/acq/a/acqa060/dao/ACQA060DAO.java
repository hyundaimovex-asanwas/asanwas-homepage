package Ehr.acq.a.acqa060.dao;


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


public class ACQA060DAO extends AbstractDAO {
	
	/**
	 * ACQA060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}


	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA060_SHR_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA060_SHR");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.get("DOC_GB2")),
                JSPUtil.rns(p_box.get("DOC_GB3"))
        };

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA060_SHR_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA060_SHR_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	
	
	
	
	
	

	
	




	
}
