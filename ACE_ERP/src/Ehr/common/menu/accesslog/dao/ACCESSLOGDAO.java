package common.menu.accesslog.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACCESSLOGDAO extends AbstractDAO {
    /**
     * ACQA040DAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public ACCESSLOGDAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_dsId, p_tr);
	}

    /**
     * ���α׷� ��� �α� ���� ���� DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public void ACCESSLOG_INS(CBox p_box ) throws CException {

		/** �ܺ� XML���� ���α׷� ��� �α� ���� (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESSLOG_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("SESS_ID"),
				p_box.get("PROG_ID"),
				p_box.get("SESSION_ENONO"),
				p_box.get("SESSION_ENONM"),
				p_box.get("SESSION_DPTCD"),
				p_box.get("SESSION_JOBCD"),
				p_box.get("IPADDRESS"),
				p_box.get("ACT_GBN")
		};


		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);

	}



}
