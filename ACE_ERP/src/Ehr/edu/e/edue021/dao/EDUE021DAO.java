package Ehr.edu.e.edue021.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE021DAO extends AbstractDAO {
	/**
	 * EDUE032DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE021DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * (����) ��ܰ��¿�û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_00(CBox p_box) throws CException {

		/** �ܺ� XML���� ����� �ش� ���¸� ��û�� ��� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_SHR_00");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_ENONO"),
				p_box.get("ORD_NO")                         // ���������ڵ�
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (���) ��ܰ��¿�û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �ش� ���¸� ��û�� ������� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_SHR_01");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")                          // SEQ��ȣ
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * (����) ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ����� �ش� ���¸� ��û�� ��� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_APP_TEMP_SHR");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
				p_box.get("SESSION_ENONO")
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * ��ܰ��¿�û��  INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE021_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		
        System.out.println("vo:::::::"+vo);
		
		System.out.println("p_box:::::::"+p_box);

		/** �ܺ� XML���� ��ܰ��¿�û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_INS");

//		ENO_NO, STR_YMD, OCC_CD, 
//		   END_YMD, EDU_CD, SEQ_NO, 
//		   EDU_GBN_CD, PLACE_CD, CPT_PNT, 
//		   EDU_NM, INT_NAM, DPT_CD, 
//		   JOB_CD, EDU_AMT
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                     // �����ڵ�
				vo.get("ENO_NO"),                                     // ��û�ڻ�� 
				p_box.get("DPT_CD"),                                  // �Ҽ�
				p_box.get("JOB_CD"),                                  // ����
				p_box.get("vusrid"),                                  // �Է���
				p_box.get("vusrid")                                   // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	/**
	 * �������� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUE021_APPROVAL_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_APP_TEMP_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	
	/**
	 * ��ܰ��¿�û�� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */ 
	public void EDUE021_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ��ܰ��¿�û�� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                     // ����
				vo.get("ENO_NO")                    // ���������ڵ�
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
