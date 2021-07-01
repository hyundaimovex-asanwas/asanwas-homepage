package hr.idt.a.idta020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.util.JSPUtil;

public class IDTA020DAO extends AbstractDAO {
	/**
	 * IDTA020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �����߱���Ȳ�� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA020_SHR(CBox p_box) throws CException {

		String STR_YMD_SHR = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String CEF_RSN_SHR  = JSPUtil.rns(p_box.get("CEF_RSN_SHR"));
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		String HIR_NM  = JSPUtil.rns(p_box.get("HIR_NM"));
		String RET_NM  = JSPUtil.rns(p_box.get("RET_NM"));
		String EXP_NM  = JSPUtil.rns(p_box.get("EXP_NM"));
		String CAR_NM  = JSPUtil.rns(p_box.get("CAR_NM"));

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA020_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {};

		/** ��ȸ ����(�������)�� ���� ó�� **/
		StringBuffer sb = new StringBuffer();
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
			sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
		} else if (!STR_YMD_SHR.equals("") && END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
		} else if (STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
		}

		// �뵵
		if( !CEF_RSN_SHR.equals("0")){
			sb.append("AND A.CEF_RSN = '"+CEF_RSN_SHR+"' \n");
		}

		if (!ENO_NO_SHR.equals("")) {
			sb.append("AND A.ENO_NO = '"+ENO_NO_SHR+"' \n");
		}

		int num = 0;
		String con = " AND( ";
		if( !HIR_NM.equals("") ){
			con += "A.CEF_SEC = '"+HIR_NM+"'";
			num++;
		}
		if( !RET_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+RET_NM+"'";
			num++;
		}
		if( !EXP_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+EXP_NM+"'";
			num++;
		}
		if( !CAR_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+CAR_NM+"'";
			num++;
		}
		con += ")";

		if( num > 0){
			sb.append(con+" \n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		this.selectProcessFirstRow(sql, bind, prop);

	}
}
