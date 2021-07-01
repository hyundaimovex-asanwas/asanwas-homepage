package common.yearmonth.dao;

import java.sql.Connection;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import common.util.JSPUtil;


public class YEARMONTHDAO extends AbstractDAO {
    /**
     * YEARMONTHDAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public YEARMONTHDAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void YEARMONTH_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "YEARMONTH_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("GUBUN"),
                p_box.get("txtEVL_GBN_SHR")
		};
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

	public void YEARMONTH_SHR01(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���� ���Է±Ⱓ�� �ش��ϴ� �⵵,ȸ�� ���� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "YEARMONTH_SHR01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("GUBUN"),
                p_box.get("txtEVL_GBN_SHR")
		};
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}


}
