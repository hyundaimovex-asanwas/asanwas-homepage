package Ehr.pir.a.pira016.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA016DAO extends AbstractDAO {
	/**
	 * PIRA016DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA016DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �з»��� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA016_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �з»��� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDGR_CD", ColumnProp.COLUMN_TYPE_STRING , 1, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GRD_CD", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GURE_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �з»��� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �з»��� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("EDGR_CD"),                               // �з±����ڵ�
				vo.get("GURS_YMD").replaceAll("-", ""),  // ��������
				vo.get("GURE_YMD").replaceAll("-", ""),  // ��������
				vo.get("SCH_CD"),                                // �б��ڵ�
				vo.get("SCH_NAM"),                              // �б�
				vo.get("MAJ_CD"),                                 // �����ڵ�
				vo.get("MAJ_CD2"),                                 // ���������ڵ�
				vo.get("GRD_CD"),                                // �����ڵ�
				p_box.get("vusrid"),            					// �Է���
				p_box.get("vusrid")             					// ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * �з»��� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �з»��� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("GURS_YMD").replaceAll("-", ""),   // ��������
				vo.get("GURE_YMD").replaceAll("-", ""),   // ��������
				vo.get("SCH_CD"),                                // �б��ڵ�
				vo.get("SCH_NAM"),                              // �б�
				vo.get("MAJ_CD"),                                 // �����ڵ�
				vo.get("MAJ_CD2"),                                 // ���������ڵ�
				vo.get("GRD_CD"),                                // �����ڵ�
				p_box.get("vusrid"),            					// ������
				vo.get("ENO_NO"),                                // ���
				vo.get("EDGR_CD"),                              // �з±����ڵ�
				vo.get("GURE_YMD").replaceAll("-", ""),   // ��������
				vo.get("GRD_CD")                                 // �����ڵ�
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �λ縶���Ϳ� �����з»��� �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ縶���Ϳ� �����з»��� �ݿ� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_UPT_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // ���
				p_box.get("vusrid"),            					// ������
				vo.get("ENO_NO"),                                // ���
				p_box.get("vusrid"),            					// ������
				vo.get("ENO_NO")                                 // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �з»��� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �з»��� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // ���
				vo.get("EDGR_CD"),                              // �з±����ڵ�
				vo.get("GURE_YMD").replaceAll("-", ""),   // ��������
				vo.get("GRD_CD")                                 // �����ڵ�
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
