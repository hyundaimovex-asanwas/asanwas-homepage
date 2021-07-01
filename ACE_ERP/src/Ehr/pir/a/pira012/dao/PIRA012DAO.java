package Ehr.pir.a.pira012.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA012DAO extends AbstractDAO {
	/**
	 * PIRA012DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA012DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA012_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA012_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")                       // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �λ���ǥ UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA012_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA012_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
                vo.get("HIR_CD"),                      // ä�뱸��
                vo.get("RHI_YMD"),                     // ���Ի���
                vo.get("NAT_CD"),                      // �����ڵ�
                vo.get("GROUP_CD"),                    // �׷���ڵ�
                vo.get("OK_ENO"),                      // ��õ�λ��
                vo.get("OK_MAN"),                      // ��õ�μ���
                vo.get("EDGR_CD"),                     // �з±����ڵ�
                vo.get("SCH_CD"),                      // �б��ڵ�
                vo.get("MAJ_CD"),                      // �а��ڵ�
                vo.get("GRD_CD"),                      // ���������ڵ�
                vo.get("GUR_YMD"),                     // ������
                vo.get("BCT_CD"),                      // ��ŵ�
                vo.get("HF_NAM"),                      // ȣ��
                vo.get("HFRE_CD"),                     // ȣ�ֿ��ǰ����ڵ�
                vo.get("PER_ADR"),                     // ����
                vo.get("JAJ_YMD"),                     // ���������߷���
                vo.get("FINJ_CD"),                     // ���������ڵ�
                vo.get("TMR_YMD"),                     // ������
                vo.get("TMR_DD"),                      // �����ϼ�
                vo.get("PAS_NO"),                      // ���ǹ�ȣ
                vo.get("PER_JOB"),                     // ������
                vo.get("PISS_YMD"),                    // �߱���
                vo.get("PCHG_YMD"),                    // ������
                vo.get("PDUE_YMD"),                    // ������
				p_box.get("vusrid"),            			// ������
				vo.get("ENO_NO")                       // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
}

