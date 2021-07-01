package Ehr.common.popup.education.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class EDUCATIONDAO extends AbstractDAO {

	/**
	 * EDUCATIONDAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUCATIONDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �����ڵ� ��ȸ
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("COMM_CD")),
				JSPUtil.rns(p_box.getString("COMM_CD"))
                //JSPUtil.rns(p_box.get("COMM_CD"))
                //,JSPUtil.rns(p_box.get("COMM_CD"))
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ���� ��ȸ
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR_01(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			   JSPUtil.rns(p_box.get("EDU_CD"))
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}
	/**
	 * �����ڵ� ��ȸ
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUCATION_SHR_C(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EDUCATION_SHR_C");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("EDU_CD")),
				JSPUtil.rns(p_box.getString("EDU_CD"))				
               //JSPUtil.rns(p_box.get("EDU_CD"))
               //,JSPUtil.rns(p_box.get("EDU_CD"))
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


}
