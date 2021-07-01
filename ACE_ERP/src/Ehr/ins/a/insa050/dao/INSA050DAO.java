package Ehr.ins.a.insa050.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class INSA050DAO extends AbstractDAO {
	/**
	 * INSA050DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSA050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * �ֹι�ȣ�� �˻��� ����ڰ� �ִ��� ���θ� �˻��Ѵ�.
     * @param cet_no
     * @return
     * @throws CException
     */
    public String INSA050_SHR(String cet_no) throws CException {
        String sql = XmlSqlUtils.getSQL("ins", "INSA050_SHR");

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
	public int INSA050_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//�λ縶���� ���̺� ����(T_CM_PERSON)
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("ins", "INSA050_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("NPEN_AMT")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return updateProcess(sql, bind);
	}

}
