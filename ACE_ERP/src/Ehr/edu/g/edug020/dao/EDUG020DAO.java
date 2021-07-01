package Ehr.edu.g.edug020.dao;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG020DAO extends AbstractDAO {
	/**
	 * EDUG020DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				//p_box.get("ENO_NO")                         // �α��λ��
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // ���İ���
				p_box.get("TRA_WEEK")                        // SEQ��ȣ
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR_21(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_21");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         //

		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUG020_SHR_22(CBox p_box) throws CException {

		/** �ܺ� XML���� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_22");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         //

		};

		prop.add("PLAN_TXT", ColumnProp.COLUMN_TYPE_STRING , 4000, ColumnProp.CONSTRAINT_TB_NOTNULL);
		
        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	/**
	 *  INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // ���
				vo.get("CPT_TAG")                            // �������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	public void EDUG020_INS_OBJT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_INS_OBJT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                        // �����ڵ�
				vo.get("ENO_NO"),                                        // ����
				p_box.get("DPT_CD"),                                  // �Ҽ�
				p_box.get("JOB_CD"),                                  // ����
				p_box.get("vusrid"),                                 // �Է���
				p_box.get("vusrid")                                  // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 *  UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // ����������
				vo.get("ENO_NO")                              // ���

		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	/**
	 * ��û ���º���.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_UPT_00(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_UPT_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {
				vo.get("STS_GBN"),                                         // ȯ�޿���
				p_box.get("vusrid"),                                    // ������
				vo.get("ORD_NO")                                       // �Ϸù�ȣ
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
	public void EDUG020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // �Ϸù�ȣ
				vo.get("ENO_NO")                                        // ���
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

}
