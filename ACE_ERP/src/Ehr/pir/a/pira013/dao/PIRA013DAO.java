package Ehr.pir.a.pira013.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA013DAO extends AbstractDAO {
	/**
	 * PIRA013DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA013DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA013_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA013_SHR");

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
	public void PIRA013_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA013_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("ZIP_NO").replaceAll("-", ""),      // �������ȣ
				vo.get("ADDRESS"),                             // ����ּ�1
				vo.get("ADR_CT"),                                // ����ּ�2
				vo.get("RZI_NO").replaceAll("-", ""),       // �ǰ����������ȣ
				vo.get("RADR"),                                    // �ǰ������ּ�1
				vo.get("RADR_CT"),                              // �ǰ������ּ�2
				vo.get("PHN_REG"),                             // ������ȣ
				vo.get("PHN_NO"),                               // ��ȭ��ȣ
				vo.get("EM_PHN_NO"),                        // �޴���
				vo.get("E_MAIL"),                                 // �̸����ּ�
				vo.get("HOU_CD"),                               // �ְ������ڵ�
				vo.get("ROM_CNT"),                             // ���
				vo.get("HIU_NO"),                                // �ǰ���������ȣ
				vo.get("LAN_SPA"),                             // ����(���)
				vo.get("FLR_SPA"),                              // �ǹ�(���)
				vo.get("ABA_CD"),                               // �޿����������ڵ�
				vo.get("MOV_AMT"),                            // ����(����)
				vo.get("MOVP_AMT"),                          // �ε���(����)
				vo.get("ACC_NO"),                               // �޿����¹�ȣ
				p_box.get("vusrid"),          					// ������
				vo.get("ENO_NO")                               // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}


	/**
	 * �α��λ�� ������ �λ縶���� ������ �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA013_INS(CBox p_box) throws CException {

		/** �ܺ� XML���� �α��λ�� ������ �����ϰų� �����ϴ� SQL ���� **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		//System.out.println("--->");
		//System.out.println(p_box.get("ENO_NO"));
		//System.out.println(p_box.get("HEAD_CD"));
		//System.out.println(p_box.get("DPT_CD"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                        					// ȸ�����
				{"IN", "", p_box.get("ENO_NO"), ""},                     // ���
				{"IN", "", p_box.get("HEAD_CD"), ""},                   // �����ڵ�
				{"IN", "", p_box.get("DPT_CD"), ""},                     // �μ��ڵ�
				{"IN", "", p_box.get("vusrid"), ""}                         // ���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}
}
