package Ehr.cod.a.coda010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODA010DAO extends AbstractDAO {

	/**
	 * CODA010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �������� ������ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODA010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_SHR");
			
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, null, prop);
	}

	/**
	 * �������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODA010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUBUN")),//pk
				JSPUtil.rns(vo.get("GUBUN_NM")),
				JSPUtil.rns(vo.get("COMP_NM")),
				JSPUtil.rns(vo.get("COMP_ENM")),
				JSPUtil.rns(vo.get("PRESIDENT_NM")),
				JSPUtil.rns(vo.get("PRESIDENT_ENM")),
				JSPUtil.rns(vo.get("TAX_NO")).replaceAll("-", ""),// �������� ���� �ִ´�.
				JSPUtil.rns(vo.get("CORP_NO")).replaceAll("-", ""),// �������� ���� �ִ´�.
				JSPUtil.rns(vo.get("BUSI_COND")),
				JSPUtil.rns(vo.get("BUSI_ITEM")),
				JSPUtil.rns(vo.get("POST_NO")),
				JSPUtil.rns(vo.get("ADDRESS_HD")),
				JSPUtil.rns(vo.get("ADDRESS_DT")),
				JSPUtil.rns(vo.get("TEL_NO")),
				JSPUtil.rns(vo.get("FAX_NO")),
				JSPUtil.rns(vo.get("COMP_URL")),
				JSPUtil.rns(vo.get("HOMETAX_ID")),
				JSPUtil.rns3(vo.get("CORP_KIND")),
				JSPUtil.rns3(vo.get("CORP_GBN")),
				JSPUtil.rns3(vo.get("LOCATION_GBN")),
				JSPUtil.rns(vo.get("TAX_OFFICE")),
				JSPUtil.rns(vo.get("WARD_OFFICE")),
				JSPUtil.rns3(vo.get("CAPITAL_TOT")),
				JSPUtil.rns3(vo.get("EMPLOYEE_TOT")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("ACF_QUT")),
				JSPUtil.rns(vo.get("ACC_STDT")),
				JSPUtil.rns(vo.get("ACC_ENDT")),
				JSPUtil.rns3(vo.get("PAY_DAY")),
				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �������� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODA010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUBUN_NM")),
				JSPUtil.rns(vo.get("COMP_NM")),
				JSPUtil.rns(vo.get("COMP_ENM")),
				JSPUtil.rns(vo.get("PRESIDENT_NM")),
				JSPUtil.rns(vo.get("PRESIDENT_ENM")),
				JSPUtil.rns(vo.get("TAX_NO")).replaceAll("-", ""),// �������� ���� �ִ´�.
				JSPUtil.rns(vo.get("CORP_NO")).replaceAll("-", ""),// �������� ���� �ִ´�.
				JSPUtil.rns(vo.get("BUSI_COND")),
				JSPUtil.rns(vo.get("BUSI_ITEM")),
				JSPUtil.rns(vo.get("POST_NO")),
				JSPUtil.rns(vo.get("ADDRESS_HD")),
				JSPUtil.rns(vo.get("ADDRESS_DT")),
				JSPUtil.rns(vo.get("TEL_NO")),
				JSPUtil.rns(vo.get("FAX_NO")),
				JSPUtil.rns(vo.get("COMP_URL")),
				JSPUtil.rns(vo.get("HOMETAX_ID")),
				JSPUtil.rns3(vo.get("CORP_KIND")),
				JSPUtil.rns3(vo.get("CORP_GBN")),
				JSPUtil.rns3(vo.get("LOCATION_GBN")),
				JSPUtil.rns(vo.get("TAX_OFFICE")),
				JSPUtil.rns(vo.get("WARD_OFFICE")),
				JSPUtil.rns3(vo.get("CAPITAL_TOT")),
				JSPUtil.rns3(vo.get("EMPLOYEE_TOT")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("ACF_QUT")),
				JSPUtil.rns(vo.get("ACC_STDT")),
				JSPUtil.rns(vo.get("ACC_ENDT")),
				JSPUtil.rns3(vo.get("PAY_DAY")),
				JSPUtil.rns(p_box.get("vusrid")),//������
				JSPUtil.rns(vo.get("GUBUN"))//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

}
