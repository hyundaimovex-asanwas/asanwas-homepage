package common.popup.chgpwd.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.StringUtil;
import com.shift.gef.support.vo.GauceValueObject;
import common.util.JSPUtil;
import common.util.EncryptUtil;

public class CHGPWDDAO extends AbstractDAO {
    /**
     * CHGPWDDAO ������
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CHGPWDDAO(String p_conn, TrBox p_tr) throws CException {

			/** SuperClass�� ������ ȣ�� **/
			super(p_conn, p_tr);
	}

    /**
     * ������й�ȣ (��ȸ) DAO �޼���
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet CHGPWD_SHR(CBox p_box ) throws CException {

		/** �ܺ� XML���� ������й�ȣ (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "CHGPWD_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("SESSION_GUBUN"),
				p_box.get("txtENO_NO")
		};
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ  **/
		
		return this.selectProcess(sql, bind, this.prop);

	}

    /**
     * ����� ��й�ȣ ����  (����) DAO �޼���
     * @param vo            GauceValueObject
     * @param p_box CBox
     * @throws CException
     */
	public void CHGPWD_UPT(CBox p_box, GauceValueObject vo ) throws CException {

		/** �ܺ� XML���� ����� ��й�ȣ ����  (����) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "CHGPWD_UPT");

		/** ���� ���� �� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				
				//StringUtil.encrypt(vo.get("PWD_NO")),//�űԺ�й�ȣ

				EncryptUtil.SHA256Encrypt(vo.get("PWD_NO")),		//�űԺ�й�ȣ 2014/07/09 �ߵ �Ҷ������� �̵���
				
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//����������
                JSPUtil.rns(p_box.get("SESSION_GUBUN")),//ȸ�����
                JSPUtil.rns(vo.get("ENO_NO"))//�����ȣ
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

}
