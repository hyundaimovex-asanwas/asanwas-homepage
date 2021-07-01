package Ehr.pir.a.pira019.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA019DAO extends AbstractDAO {
	/** 
	 * PIRA019DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA019DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �ǰ����� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA019_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ǰ����� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EYE_LEF", ColumnProp.COLUMN_TYPE_DECIMAL , 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("EYE_RHT", ColumnProp.COLUMN_TYPE_DECIMAL , 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AB_HGT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �ǰ����� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ǰ����� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_INS");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("PRO_YMD").replaceAll("-", ""),   // �ǽ����� 
				vo.get("OCC_CD"),                                // �����ڵ�
				vo.get("EYE_LEF"),                                // �½÷� 
				vo.get("EYE_RHT"),                               // ��÷�
				vo.get("HEIGHT"),                                  // ����
				vo.get("WEIGHT"),                                 // ü��
				vo.get("AB_HGT"),                                 // ����
				vo.get("CBLD_CD"),                               // �����ڵ�
				vo.get("BLD_TYP"),                               // ������
				vo.get("XRY_RMK"),                               // X���Ұ�
				vo.get("BLD_PRE"),                               // ����
				vo.get("BLD_DAN"),                               // ���� 
				vo.get("PH"),                                         // pH
				vo.get("EXM_HSP"),                               // �˻纴��
				vo.get("DECISION"),                               // ����
				vo.get("SPEC"),                                     // ���
				vo.get("CHIT_AMT"),                               // ���
				p_box.get("vusrid"),            						// �Է���
				p_box.get("vusrid")             						// ������
		};
		
		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * �ǰ����� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ǰ����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_UPT");
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("EYE_LEF"),                                // �½÷� 
				vo.get("EYE_RHT"),                               // ��÷�
				vo.get("HEIGHT"),                                  // ����
				vo.get("WEIGHT"),                                 // ü��
				vo.get("AB_HGT"),                                 // ����
				vo.get("CBLD_CD"),                               // �����ڵ�
				vo.get("BLD_TYP"),                               // ������
				vo.get("XRY_RMK"),                               // X���Ұ�
				vo.get("BLD_PRE"),                               // ����
				vo.get("BLD_DAN"),                               // ���� 
				vo.get("PH"),                                         // pH
				vo.get("EXM_HSP"),                               // �˻纴��
				vo.get("DECISION"),                               // ����
				vo.get("SPEC"),                                     // ���
				vo.get("CHIT_AMT"),                               // ���
				p_box.get("vusrid"),            						// ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("PRO_YMD").replaceAll("-", "")    		// �ǽ����� 
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * �ǰ����� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �ǰ����� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_DEL");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("PRO_YMD").replaceAll("-", "")    // �ǽ����� 
		};
		
		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
		
	}
}
