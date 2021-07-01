package Ehr.pir.a.pira020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA020DAO extends AbstractDAO {
	/** 
	 * PIRA020DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA020DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �ڰݸ��� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA020_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ڰݸ��� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("QUA_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GAN_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �ڰݸ��� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ڰݸ��� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("QUA_CD"),                                 // �ڰݸ����ڵ�
				vo.get("GAN_YMD").replaceAll("-", ""),    		// ������� 
				vo.get("QUA_NO"),                                // ������ȣ
				vo.get("APP_ADM"),                              	// ����ó
				vo.get("ETG_YN"),                                 	// �������޿���
				p_box.get("vusrid"),            						// �Է���
				p_box.get("vusrid"),             					// ������
				vo.get("QUA_AMT"),                                // ����ݾ�			
		};
		
		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * �ڰݸ��� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ڰݸ��� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_UPT");
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {

				vo.get("QUA_NO"),                                // ������ȣ
				vo.get("APP_ADM"),                               // ����ó
				vo.get("ETG_YN"),                                 // �������޿���
				vo.get("QUA_AMT"),                              // ����ݾ�				
				p_box.get("vusrid"),            					   // ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("QUA_CD"),                                 // �ڰݸ����ڵ�
				vo.get("GAN_YMD").replaceAll("-", "")          // ������� 
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * �ڰݸ��� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ڰݸ��� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_DEL");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("QUA_CD"),                                 // �ڰݸ����ڵ�
				vo.get("GAN_YMD").replaceAll("-", "")     // ������� 
		};
		
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
		
	}
}
