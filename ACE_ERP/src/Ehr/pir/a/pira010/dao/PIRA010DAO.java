package Ehr.pir.a.pira010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class PIRA010DAO extends AbstractDAO {
	/**
	 * PIRA010DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA010DAO(String p_dsId, TrBox p_tr) throws CException {


		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ��������ó�� ���� ��� �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 */
	public void PIRA010_SHR_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}	
	
	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ INSERT�� �����ϴ� DAO �޼ҵ�
	 */
	public void PIRA010_INS_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"I"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ UPDATE�� �����ϴ� DAO �޼ҵ�
	 */
	public void PIRA010_UPT_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"U"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ PRINT�� �����ϴ� DAO �޼ҵ�
	 */
	public void PIRA010_PRT_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"P"
		};
		
		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	

	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                      // �������
				p_box.get("ENO_NO")                       // ��������
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT2(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT3(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT3");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT4(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT4");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT5(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT5");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT6(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT6");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT7(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT7");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT8(CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT8");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // �������

		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	
	/**
	 * �λ���ǥ INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				"01",  											// ȸ�����
				vo.get("ENO_NO"),                      // ���
				vo.get("OCC_CD"),                      // ����
				vo.get("ENO_NM"),                      // ����
				vo.get("NAM_ENG"),                    // ��������
				vo.get("NAM_CHI"),                      // �ѹ�����
				vo.get("MF_TAG"),                       // ����
				vo.get("BIR_YMD"),                      // �������
				vo.get("BIR_TAG"),                      // ��±���
				vo.get("CET_NO"),                       // �ֹι�ȣ
				vo.get("HEAD_CD"),                     // ����
				vo.get("DPT_CD"),                      // �Ҽ�(����/�������� ��ȸ)
				vo.get("REG_CD"),                       // ��������
				vo.get("DPT_CD"),                       // �Ҽ�
				vo.get("JOB_CD"),                       // ����
				vo.get("JPR_YMD"),                     // ������
				vo.get("DUTY_CD"),                     // ��å
				vo.get("TEAM_CD"),                     // ��
				vo.get("HOB_CD"),                       // ȣ��
				vo.get("HBA_YMD"),                     // �±���
				vo.get("HIR_YMD"),                      // �Ի���
				vo.get("HIRG_YMD"),                    // �׷��Ի���
				vo.get("HIR_YMD"),                      // �Ի���(�����ݱ�����)
				vo.get("ENO_NO"),                      // �󼱻��(�ű��϶��� ��������� �ִ´�)
				p_box.get("vusrid"),   // �Է���
				p_box.get("vusrid")    // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * �α��λ�� ������ �λ縶���� ������ �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �α��λ�� ������ �����ϰų� �����ϴ� SQL ���� **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                       	 					// ȸ�����
				{"IN", "", p_box.get("ENO_NO"), ""},                    // ���
				{"IN", "", p_box.get("HEAD_CD"), ""},                  // �����ڵ�
				{"IN", "", p_box.get("DPT_CD"), ""},                     // �μ��ڵ�
				{"IN", "", p_box.get("vusrid"), ""}                         // ���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * ���Ի�� ���� �λ縶���Ϳ� �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ä��������� �����ȣ/�ֹι�ȣ�� �о�鿩 �λ縶���� �����͸� �ϰ� �����ϴ� SQL ���� **/
		String sql = "{ call PKG_XF_PIRA010_INS.SF_INS_T_CM_PERSON(?, ?, ?, ?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", "", p_box.get("SESSION_GUBUN"), ""},                        // ȸ�����
				{"IN", "", p_box.get("ENO_NO"), ""},                                      // ���
				{"IN", "", p_box.get("REG_NO"), ""},                                      // �����ȣ
				{"IN", "", p_box.get("CET_NO"), ""},                                      // �ֹι�ȣ
				{"IN", "", p_box.get("vusrid"), ""}                         // ���
		};
		
		//System.out.println("IGUBUN   := "+"'"+JSPUtil.rns(p_box.get("SESSION_GUBUN"))+"';");
		//System.out.println("IENO_NO  := "+"'"+JSPUtil.rns(p_box.get("ENO_NO"))+"';");
		//System.out.println("IREG_NO := "+"'"+JSPUtil.rns(p_box.get("REG_NO"))+"';");
		//System.out.println("ICET_NO  := "+"'"+JSPUtil.rns(p_box.get("CET_NO"))+"';");
		//System.out.println("IIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * �λ���ǥ UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_UPT");

		//System.out.println(p_box);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),                      // ����
				vo.get("ENO_NM"),                      // ����
				vo.get("NAM_ENG"),                    // ��������
				vo.get("NAM_CHI"),                      // �ѹ�����
				vo.get("MF_TAG"),                       // ����
				vo.get("BIR_YMD"),                      // �������
				vo.get("BIR_TAG"),                      // ��±���
				vo.get("CET_NO"),                       // �ֹι�ȣ
				vo.get("HEAD_CD"),                     // ����
				vo.get("DPT_CD"),                      // �Ҽ�(����/�������� ��ȸ)
				vo.get("REG_CD"),                       // ��������
				vo.get("DPT_CD"),                       // �Ҽ�
				vo.get("JOB_CD"),                       // ����
				vo.get("JPR_YMD"),                     // ������
				vo.get("DUTY_CD"),                     // ��å
				vo.get("TEAM_CD"),                     // ��
				vo.get("HOB_CD"),                       // ȣ��
				vo.get("TAX_DPT"),                       // ȸ��Ҽ�				
				vo.get("RETP_YMD"),                     // ��ุ����
				vo.get("HIR_YMD"),                      // �Ի���
				vo.get("HIRG_YMD"),                    // �׷��Ի���
				p_box.get("vusrid"),     					// ������
				vo.get("ENO_NO")                          // ���
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �λ���ǥ �ӽ����̺� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ���ǥ ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_INS_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),
				vo.get("ENO_NO"),
				"1",//������
				vo.get("ENO_NM"),
				vo.get("NAM_ENG"),
				vo.get("NAM_CHI"),
				vo.get("MF_TAG"),
				vo.get("BIR_YMD"),
				vo.get("BIR_TAG"),
				vo.get("CET_NO"),
				vo.get("HIR_YMD"),
				vo.get("HIRG_YMD"),//�������� ���
				vo.get("JPR_YMD"),//�������� ���
				vo.get("HBA_YMD"),//�������� ���
				vo.get("RETP_YMD"),//��ุ���� 2020.11.11 ������ ���̿� �߰�			
				"",//�İ����� ���
				p_box.get("vusrid"),   // �Է���
				p_box.get("vusrid")    // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

}
