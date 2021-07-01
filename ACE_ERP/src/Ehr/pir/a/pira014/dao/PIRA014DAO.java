package Ehr.pir.a.pira014.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA014DAO extends AbstractDAO {
	/**
	 * PIRA014DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA014DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA014_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA014_SHR");

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
	public void PIRA014_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA014_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("HOBBY"),                       // ���
				vo.get("SPEC_CD"),                     // Ư��
				vo.get("PART_CD"),                     // �ι�
				vo.get("WED_YMD"),                     // ��ȥ�����
				vo.get("REL_CD"),                      // ����
				vo.get("COM_PHN_REG"),                 // ȸ����ȭ��ȣ(����)
				vo.get("COM_PHN_NO"),                  // ȸ����ȭ��ȣ
				vo.get("COM_PHN_IN"),                  // ������ȣ
				vo.get("RET_CD"),                      // ��������
				vo.get("RET_YMD"),                     // �����
				vo.get("RETP_YMD"),                    // �����
				vo.get("RETM_CD"),                     // �����ġ�ڵ�
				vo.get("RETM_REM"),                    // ��ġ�ڻ��
				vo.get("RETM_YMD"),                    // �����ġ��
				vo.get("LSE_YY"),                      // �ټӳ��
				vo.get("LSE_MM"),                      // �ټӿ���
    			vo.get("HIRR_YMD"),                    // �����ݱ�����
				vo.get("MID_YMD1"),                    // �������ߵ�������1
				vo.get("MRE_AMT"),                     // �ߵ�����ݾ�1
				vo.get("RAM_YMD"),                     // ������
				vo.get("MID_YMD2"),                    // �������ߵ�������2
				vo.get("MRE_AMT2"),                    // �ߵ�����ݾ�2
				vo.get("RAM_YMD2"),                    // ������2
				vo.get("MID_YMD3"),                    // �������ߵ�������3
				vo.get("MRE_AMT3"),                    // �ߵ�����ݾ�3
				vo.get("RAM_YMD3"),                    // ������3
				vo.get("COC_NAM"),                     // ����ó
				vo.get("REMARK"),                      // ���
				vo.get("REG_CD"),                      // �ٹ����� - �μ��ڵ� ���� ����  �������� 2011.05.1
				p_box.get("vusrid"),            			// ������
				vo.get("ENO_NO")                       // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
}
