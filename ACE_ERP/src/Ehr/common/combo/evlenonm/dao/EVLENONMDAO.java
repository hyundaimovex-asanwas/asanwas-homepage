package common.combo.evlenonm.dao;

import java.sql.Connection;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import common.util.JSPUtil;


public class EVLENONMDAO extends AbstractDAO {
    /**
     * EVLENONMDAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public EVLENONMDAO(String p_dsId, TrBox p_tr) throws CException {

        /** SuperClass�� ������ ȣ�� **/
        super(p_dsId, p_tr);
	}

    /**
     * �����ڿ� ���� ���� ��ȸ (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void EVLENONM_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� �����ڿ� ���� ���� ��ȸ (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EVLENONM_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("SESSION_GUBUN"),
				p_box.get("txtEVL_YY_SHR"),
                p_box.get("txtEVL_FRQ_SHR"),
                p_box.get("txtENO_NO_SHR")
		};
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

}
