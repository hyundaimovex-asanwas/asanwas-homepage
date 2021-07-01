package Ehr.pir.a.pira017.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA017DAO extends AbstractDAO {
	/** 
	 * PIRA017DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA017DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA017_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("GUB_CD"),                                 // ���������ڵ�
				vo.get("MIC_CD"),                                  // �����ڵ�
				vo.get("LOC_CD"),                                 // ����û�ڵ�
				vo.get("MIL_CD"),                                  // �����ڵ�
				vo.get("ENL_YMD").replaceAll("-", ""),    // �����Ⱓ(FROM) 
				vo.get("MIL_YMD").replaceAll("-", ""),     // �����Ⱓ(TO)
				vo.get("YSE_CD"),                                 // ���������ڵ�
				vo.get("GRADE"),                                   // ����ڵ�
				vo.get("MIL_NO"),                                 // ����
				vo.get("MBK_CD"),                                // �����ڵ�
				vo.get("MIL_DES"),                                // ��������
				vo.get("REMARK"),                                // ��Ÿ����
				p_box.get("vusrid"),            					// �Է���
				p_box.get("vusrid")             					// ������
		};
		
		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * �������� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_UPT");
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("GUB_CD"),                                 // ���������ڵ�
				vo.get("MIC_CD"),                                  // �����ڵ�
				vo.get("LOC_CD"),                                 // ����û�ڵ�
				vo.get("MIL_CD"),                                  // �����ڵ�
				vo.get("ENL_YMD").replaceAll("-", ""),    // �����Ⱓ(FROM) 
				vo.get("MIL_YMD").replaceAll("-", ""),     // �����Ⱓ(TO)
				vo.get("YSE_CD"),                                 // ���������ڵ�
				vo.get("GRADE"),                                   // ����ڵ�
				vo.get("MIL_NO"),                                 // ����
				vo.get("MBK_CD"),                                // �����ڵ�
				vo.get("MIL_DES"),                                // ��������
				vo.get("REMARK"),                                // ��Ÿ����
				p_box.get("vusrid"),            					// ������
				vo.get("ENO_NO")                                 // ���
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * �������� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_DEL");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO")                                 // ���
		};
		
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
		
	}
}
