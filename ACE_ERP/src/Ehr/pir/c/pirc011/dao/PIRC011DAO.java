package Ehr.pir.c.pirc011.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRC011DAO extends AbstractDAO {
	/** 
	 * PIRC011DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRC011DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRC011_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRC011_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")                       // ���
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * �������� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRC011_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRC011_UPT");
	
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("BCT_CD"),							// ��ŵ��ڵ�
				vo.get("HF_NAM"),							// ȣ��
				vo.get("HFRE_CD"),                    	// ȣ�ֿ��ǰ����ڵ�
				vo.get("PER_ADR"),                    	// ����
				vo.get("ZIP_NO"),                     		// �������ȣ
				vo.get("ADDRESS"),                    	// ����ּ�1
				vo.get("ADR_CT"),                     	// ����ּ�2
				vo.get("RZI_NO"),                     		// �ǰ����������ȣ
				vo.get("RADR"),                       		// �ǰ������ּ�1
				vo.get("RADR_CT"),                    	// �ǰ������ּ�2
				vo.get("PHN_REG"),                    	// ������ȣ
				vo.get("PHN_NO"),                     	// ��ȭ��ȣ
				vo.get("EM_PHN_NO"),                 // �޴���
				vo.get("E_MAIL"),                     		// �̸����ּ�
				p_box.get("vusrid"),    // ������
				//p_box.get("SESSION_GUBUN"),    // ȸ�����
				vo.get("ENO_NO")                         // ���
		};
		
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}
}

