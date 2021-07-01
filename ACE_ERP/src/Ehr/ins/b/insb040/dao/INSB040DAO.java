package Ehr.ins.b.insb040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class INSB040DAO extends AbstractDAO {
	/**
	 * INSB040DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSB040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * �ֹι�ȣ�� �˻��� ����ڰ� �ִ��� ���θ� �˻��Ѵ�.
     * @param cet_no
     * @return
     * @throws CException
     */
    public String INSB040_SHR(String cet_no) throws CException {
        String sql = XmlSqlUtils.getSQL("ins", "INSB040_SHR");

        Object[] bind = new Object[] {
                JSPUtil.rns(cet_no)
        };

        GauceValueObject vo = this.selectProcessGvo(sql, bind).get(0);
        return vo.getString("CHK");
    }

	/**
	 * ���ο��ݵ���� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int INSB040_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//�λ縶���� ���̺� ����(T_CM_PERSON)
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("ins", "INSB040_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("HINU_AMT")),				
				JSPUtil.rns(vo.get("OLD_AMT")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return updateProcess(sql, bind);
	}

}
