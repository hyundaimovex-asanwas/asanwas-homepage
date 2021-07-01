package Ehr.wel.n.weln030.dao;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class WELN030DAO extends AbstractDAO {
	/**
	 * WELN030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public WELN030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ���� SELECT�� �����ϴ� DAO �޼ҵ�
     * @param p_box
     * @throws CException
     */
    public void WELN030_SHR(CBox p_box) throws CException {

        /** �ܺ� XML���� ���� ��ȸ SQL ���� **/
        String sql = XmlSqlUtils.getSQL("wel", "WELN030_SHR");


        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������
        //        p_box.get("ENO_NO"),                // ���
        };

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

    }

	/**
	 * ������ �����ϴ� DAO�޼ҵ�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void WELN030_DEL(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	public void WELN030_DEL2(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_DEL2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int WELN030_SAV(GauceValueObject vo, CBox p_box) throws CException {

		//����ī����ε� ���̺� ����(dsT_CM_WELCARD)
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("SEQID")),
				JSPUtil.rns(vo.get("RESINO")),
				JSPUtil.rns(vo.get("ENO_NM")),
				JSPUtil.rns(vo.get("APPDT")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������
				JSPUtil.rns(vo.get("SALAMT")),
				JSPUtil.rns(vo.get("MEMBER")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return updateProcess(sql, bind);
	}


	/**
	 * ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int WELN030_SAV_01(GauceValueObject vo, CBox p_box) throws CException {


		//����ī����ε� ���̺� ����(dsT_CM_WELCARD)
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������

		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return updateProcess(sql, bind);
	}

	/**
	 * ������ �����ϴ� DAO�޼ҵ�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void WELN030_SAV_END(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV_END");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // ������
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}


}
