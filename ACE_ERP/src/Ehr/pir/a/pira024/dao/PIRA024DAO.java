package Ehr.pir.a.pira024.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA024DAO extends AbstractDAO {
	/** 
	 * PIRA024DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA024DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �Ի������ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA024_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �Ի������ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING , 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �Ի������ INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �Ի������ ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", ""),    // �������� 
				vo.get("END_YMD").replaceAll("-", ""),    // �������� 
				vo.get("CMP_NAM"),                              // ȸ���
				vo.get("GRP_CD"),                                // �׷���ڵ�
				vo.get("DPT_NAM"),                              // �Ҽ�
				vo.get("JOB_CD"),                                // ����
				vo.get("CHG_JOB"),                              // ������
				vo.get("CAR_PCT"),                              // �����������
				vo.get("CAR_YY"),                                // ����������
				vo.get("CAR_MM"),                                // �����������
				vo.get("SAL_AMT"),                                // �޿� 
				vo.get("REMARK"),                                // ���
				p_box.get("vusrid"),            // �Է���
				p_box.get("vusrid")             // ������
		};
		
		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * �Ի������ UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �Ի������ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_UPT");
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),    // �������� 
				vo.get("CMP_NAM"),                              // ȸ���
				vo.get("GRP_CD"),                                // �׷���ڵ�
				vo.get("DPT_NAM"),                              // �Ҽ�
				vo.get("JOB_CD"),                                // ����
				vo.get("CHG_JOB"),                              // ������
				vo.get("CAR_PCT"),                              // �����������
				vo.get("CAR_YY"),                                // ����������
				vo.get("CAR_MM"),                                // �����������
				vo.get("SAL_AMT"),                                // �޿� 
				vo.get("REMARK"),                                // ���
				p_box.get("vusrid"),            // ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", "")     // �������� 
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * �Ի������ DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �Ի������ ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_DEL");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", "")     // �������� 
		};
		
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
		
	}
}
