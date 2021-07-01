package Ehr.edu.g.edug010.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG010DAO extends AbstractDAO {
	/**
	 * EDUG010DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG010DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                         // �α��λ��
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}



	/**
	 * INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������ �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // ���
				vo.get("EFFECT_TAG"),                        // ȿ��
				vo.get("CPT_TAG")                            // �������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}


	/**
	 * UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // ����������
				vo.get("CHASU_TXT"),                                  // ������
				vo.get("EDU_GBN_CD"),                                // ���������ڵ�
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // ������������
				vo.get("EDU_END_YMD").replaceAll("-",""),    // ������������
				vo.get("GOAL_TXT"),                                     // ��������
				vo.get("EDU_GBN_TXT"),                              // �������
				vo.get("PLACE_TXT"),                                   // �������
				vo.get("CONTENT_TXT"),                              // ��������
				vo.get("COST_AMT"),                                    // �������
				vo.get("FIX_NO"),                                          // �����ο�
				vo.get("INS_YN"),                                         // ȯ�޿���
				vo.get("RTN_AMT"),                                     // ȯ�޿����
				p_box.get("vusrid"),                         // ������
				vo.get("OBJ_TAG"),                           // ���
				vo.get("SITE_TAG"),                          // �������Ʈ
				vo.get("EFFECT_TAG"),                        // ȿ��
				vo.get("CPT_TAG"),                            // �������
				vo.get("ORD_NO"),                              // �Ϸù�ȣ
				vo.get("ENO_NO")                              // ���

		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	

	/**
	 * DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // �Ϸù�ȣ
				vo.get("ENO_NO")                                        // ���
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

}
