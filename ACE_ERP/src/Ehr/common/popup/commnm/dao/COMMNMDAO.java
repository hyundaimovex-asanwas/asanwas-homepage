package Ehr.common.popup.commnm.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class COMMNMDAO extends AbstractDAO {
	/**
	 * COMMNMDAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public COMMNMDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ���� ������ ��ȸ�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR");

		//System.out.println("p_box=================="+p_box);

		//System.out.println("COMM_CD_SHR=================="+p_box.getString("COMM_CD_SHR"));		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("CD_GBN"))
			   ,JSPUtil.rns(p_box.get("OCC_CD"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ���� ������ �����ڵ� gbn2_tag ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_03");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN")
			   ,JSPUtil.rns(p_box.get("OCC_CD"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
               ,JSPUtil.rns(p_box.getString("COMM_CD_SHR"))
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}
