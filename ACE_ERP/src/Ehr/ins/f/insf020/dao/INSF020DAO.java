package Ehr.ins.f.insf020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class INSF020DAO extends AbstractDAO {
	/**
	 * INSB020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSF020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ���ο��� �������� ����Ʈ�� ��ȸ�Ѵ�.
     * @param p_box
     * @throws CException
     */
    public void INSF020_SHR(CBox p_box) throws CException {
        String Query = XmlSqlUtils.getSQL("ins", "INSF020_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("SAV_CD2"))

        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
}
