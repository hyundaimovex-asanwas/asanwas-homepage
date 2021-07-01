package Ehr.edu.c.educ012.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUC012DAO extends AbstractDAO {
	/** 
	 * EDUC012DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUC012DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * ����������Ȳ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_01(CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_01");
		
		//System.out.println("EDUC012_SHR_01  =========================================== " + p_box);	    
		
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};
		
		return this.selectProcess(sql, bind, prop);
		
		
	}
	
	/**
	 * �系�����̷�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_02(CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_02");
		
		//System.out.println("EDUC012_SHR_02  =========================================== " + p_box);	    
		
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PLACE_CD")
		};
		
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * �系�����̷�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_03(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �İ��ε�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_03");
		
		//System.out.println("EDUC012_SHR_03  =========================================== " + p_box);	   
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
				p_box.get("ENO_NO"),
		};
		
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * �������̷�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUC012_SHR_05(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �İ��ε�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUC020_SHR_05");
		
		//System.out.println("EDUC012_SHR_05  =========================================== " + p_box);	   
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),				
				p_box.get("ENO_NO"),
		};
		
		return this.selectProcess(sql, bind, prop);
	}

}
