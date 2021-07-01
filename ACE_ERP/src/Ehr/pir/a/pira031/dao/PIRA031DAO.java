package Ehr.pir.a.pira031.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class PIRA031DAO extends AbstractDAO {
	/**
	 * PIRA031DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA031DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �޿����� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA031_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};


		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ȣ�����̺� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA031_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ȣ�����̺�  ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("OCC_CD"),                                     // ����
				p_box.get("JOB_CD"),                                      // ����
				p_box.get("HOB_CD"),                                     // ȣ��
				p_box.get("APY_YMD").replaceAll("-", "")         // ȣ��ǥ����
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �޿����� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT3")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * �޿����� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("BAS_AMT"),                               // �⺻��
				vo.get("OSE_AMT"),                               // �ڱⰳ��/����
				vo.get("APP_CD"),                                 // �߷ɱ����ڵ�
				vo.get("DUT_AMT"),                               // ��å����
				vo.get("RUN_AMT"),                               // �߱ټ���
				vo.get("JOB_CD"),                                  // �����ڵ�
				vo.get("OT_AMT"),                                  // �ð��ܼ���
				vo.get("MH_AMT"),                                 // �������
				vo.get("HOB_CD"),                                 // ȣ���ڵ�
				vo.get("WEL_AMT"),                               // ��������
				vo.get("LSEV_AMT"),                             // �ټӼ���
				vo.get("BNS_AMT"),                             // �󿩼���
				p_box.get("vusrid"),            // ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("CHN_YMD").replaceAll("-", ""),    // ��������
				vo.get("SEQ_NO")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}
	/**
	 * �޿����� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT_ETC(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT_ETC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("ETC_AMT"),                               // ��Ÿ����(�����)
				vo.get("ETC_AMT3"),                               // ��Ÿ����(�Ĵ�)
				p_box.get("vusrid"),            // ������
				vo.get("OCC_CD"),                                 // ��������
				vo.get("JOB_CD"),                                 // ����
				vo.get("HOB_CD"),                                 // �����ڵ�
				vo.get("APY_YMD").replaceAll("-", "")    // ��������
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �޿����̺� �������� ������Ʈ�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("ENO_NO"))//pk

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �޿����̺� �������� ������Ʈ�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public int PIRA031_SHR_COUNT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR_COUNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO"))//pk

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		GauceDataSet ds = this.selectProcess(sql, bind, prop);
		return ds.getDataRowCnt();

	}


	/**
	 * �⺻��, ��������, �ð��ܼ���, �󿩱� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT0(GauceValueObject vo, CBox p_box) throws CException {


		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql0 = XmlSqlUtils.getSQL("pir", "PIRA031_UPT0");
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind0 = new Object[] {
				JSPUtil.rns(vo.get("BAS_AMT")),//pk
				JSPUtil.rns(vo.get("DUTY_AMT")),//pk
				JSPUtil.rns(vo.get("LAW_AMT")),//pk
				JSPUtil.rns(vo.get("BNS_AMT")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD")).replaceAll("-", "")

		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql0, bind0);

	}

	/**
	 * ���ο���, �ǷẸ�� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT3(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT3");
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("HINU_AMT")),//pk
				JSPUtil.rns(vo.get("OLD_AMT")),//pk
				JSPUtil.rns(vo.get("NPEN_AMT")),//pk
				JSPUtil.rns(vo.get("HINS_AMT")),//pk
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}




	/**
	 * �޿����� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �޿����� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("CHN_YMD").replaceAll("-", ""),    // ��������
				vo.get("SEQ_NO")
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}