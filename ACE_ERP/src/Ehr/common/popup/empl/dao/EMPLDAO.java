package Ehr.common.popup.empl.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class EMPLDAO extends AbstractDAO {
	/** 
	 * EMPLDAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EMPLDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
	
	/**
	 * ��ȸ�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();
		
		//System.out.println("p_box=============="+p_box);
		
        // �������� ����
		if (p_box.get("GUBUN").equals("0")||p_box.get("GUBUN").equals("")) {

			sb.append("AND (RET_YMD IS NULL OR    RET_YMD >= SYSDATE) \n");

	    }
		// �����
		else if (p_box.get("GUBUN").equals("1")) {
			sb.append("AND RET_YMD IS NOT NULL");
		}
        //	����/����� ���о���
		else if (p_box.get("GUBUN").equals("2")) {
			sb.append("AND 1 = 1 \n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("ENO_NO")),
                JSPUtil.rns(p_box.getString("ENO_NO")),
                JSPUtil.rns(p_box.getString("DPT_CD"))
		};
		//System.out.println("sql"+sql);
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
}
