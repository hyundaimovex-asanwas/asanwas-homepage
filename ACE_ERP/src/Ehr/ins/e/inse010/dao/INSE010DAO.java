package Ehr.ins.e.inse010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class INSE010DAO extends AbstractDAO {
	/**
	 * INSE010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}



    /**
     *
     * @param cet_no
     * @return
     * @throws CException
     */
    public void INSE010_SHR(CBox p_box) throws CException {

        String sql = XmlSqlUtils.getSQL("ins", "INSE010_SHR");

        Object[] bind = new Object[] {

        };

		this.selectProcessFirstRow(sql, bind, prop);

    }




	/**
	 * ���������� �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int INSE010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//�λ縶���� ���̺� ����(T_CM_PERSON)
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("ins", "INSE010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("INSU_AMT")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return updateProcess(sql, bind);
	}

}
