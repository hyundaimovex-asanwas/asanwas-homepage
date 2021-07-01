package Ehr.pir.a.pira015.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA015DAO extends AbstractDAO {
	/**
	 * PIRA015DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA015DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA015_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA015_SHR");

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
	public void PIRA015_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA015_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("GET_RSN"),                       // ������
				vo.get("HIR_PATH"),                       // ä����
				vo.get("SAN_YMD"),                       // ��������
				vo.get("SAN_NAM"),                       // �󺴸�
				vo.get("HDC_CD"),                         // �������
				vo.get("HDC_GRA"),                       // ��ֵ��
				vo.get("SAN_HIS"),                         // ���ź���
				vo.get("SAN_REM"),                       // �߻�����
				vo.get("JAN_YMD"),                        // ���������
				vo.get("TRG_CD"),                         // �����������
				vo.get("JHDC_CD"),                       // �������
				vo.get("JHDC_GRA"),                     // ��ֵ��
				vo.get("SER_STS"),                       // ��������
				vo.get("JOB_OCC"),                      // �ٹ�����
				vo.get("MPVA_CD"),                      // ���ƴ��
				p_box.get("vusrid"),     					// ������
				vo.get("ENO_NO")                          // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
}
