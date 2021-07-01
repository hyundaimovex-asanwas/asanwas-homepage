package Ehr.wel.n.weln040.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class WELN040DAO extends AbstractDAO {
	/**
	 * WELN010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public WELN040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ���� SELECT�� �����ϴ� DAO �޼ҵ�
     * @param p_box
     * @throws CException
     */
    public void WELN040_SHR(CBox p_box) throws CException {

        //System.out.println("p_box=>"+p_box);

        /** �ܺ� XML���� ���� ��ȸ SQL ���� **/
        String sql = XmlSqlUtils.getSQL("wel", "WELN040_SHR");


        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
        Object[] bind = new Object[] {
                p_box.get("CON_YMD_SHR").replaceAll("-", ""),                // ������
                p_box.get("ENO_NO_SHR"),                						// ������
        };

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

    }



}
