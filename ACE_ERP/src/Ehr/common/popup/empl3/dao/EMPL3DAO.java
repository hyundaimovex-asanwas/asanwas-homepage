package common.popup.empl3.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPL3DAO extends AbstractDAO {
	/** 
	 * EMPL3DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EMPL3DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}
	
	/**
	 * �򰡱��� ���� ������ ��ȸ�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL3_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL3_SHR");
		
		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();
		
        // �������� ����
		if (p_box.get("GUBUN").equals("0")) {
			sb.append("AND (RET_YMD IS NULL\n");
		    sb.append("OR    RET_YMD >= SYSDATE)\n");
	    }
		// �����
		else if (p_box.get("GUBUN").equals("1")) {
			sb.append("AND RET_YMD IS NOT NULL");
		}
        //	����/����� ���о���
		else if (p_box.get("GUBUN").equals("1")) {
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
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO")
		};
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
}
