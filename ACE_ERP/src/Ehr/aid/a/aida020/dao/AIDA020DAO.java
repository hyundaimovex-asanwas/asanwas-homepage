package Ehr.aid.a.aida020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class AIDA020DAO extends AbstractDAO {
	/**
	 * AIDA020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ������� ����ó�� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA020_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA020_SHR");

		String REQ_YMD_STDT_SHR = JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "");
		String REQ_YMD_ENDT_SHR = JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "");

		/** ��ȸ ����(��������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		if (!REQ_YMD_STDT_SHR.equals("") && !REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD >= '"+REQ_YMD_STDT_SHR+"' \n");
			sb.append("AND REQ_YMD <= '"+REQ_YMD_ENDT_SHR+"' \n");
		} else if (!REQ_YMD_STDT_SHR.equals("") && REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD >= '"+REQ_YMD_STDT_SHR+"' \n");
		} else if (REQ_YMD_STDT_SHR.equals("") && !REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD <= '"+REQ_YMD_ENDT_SHR+"' \n");
		} 

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("AID_STS_SHR"))
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}
}
