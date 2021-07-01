package Ehr.gun.e.gune015.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class GUNE015DAO extends AbstractDAO {

	/**
	 * GUNE011DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNE015DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ����ٹ�����  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNE015_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE015_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("ENO_NO"),
		};

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ����ٹ� ����������  ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNE015_SHR_01(CBox p_box) throws CException {

		//System.out.println("==================="+p_box);		
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE015_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				"O",
								
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK1", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * ����ٹ� ����������(���翩��) ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNE015_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE015_UPT_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),							//���翩��
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 	//������
				JSPUtil.rns(vo.get("REQ_NO")),						    //ǰ�ǹ�ȣ
				JSPUtil.rns(p_box.get("vusrid"))	   //���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * ����ٹ� ���� ����(���翩��) ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNE015_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE015_UPT_02");

		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),							//���翩��
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(vo.get("APP_STATUS")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 				//������ ���
				JSPUtil.rns(vo.get("REQ_NO")),						    //��û��ȣ
				//JSPUtil.rns(p_box.get("vusrid"))	   //���
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	
	

	/**
	 * ���� ��Ϲ�ȣ�� �����Ѱ�������(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet GUNE015_CNT(GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE015_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),				//ǰ�ǹ�ȣ
				"O",
				JSPUtil.rns(vo.get("REQ_NO")),				//ǰ�ǹ�ȣ
				"O",
				JSPUtil.rns(vo.get("REQ_NO")),				//ǰ�ǹ�ȣ
				"O",
				JSPUtil.rns(vo.get("REQ_NO")),				//ǰ�ǹ�ȣ
				"O",
				JSPUtil.rns(vo.get("REQ_NO")),				//ǰ�ǹ�ȣ
				"O"
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return selectProcess(sql, bind);
	}
}

