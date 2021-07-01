package Ehr.pir.a.pira025.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import common.sys.KISA_SHA256;

import Ehr.common.util.JSPUtil;

public class PIRA025DAO extends AbstractDAO {
	/**
	 * PIRA025DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA025DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �Ի��İ�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA025_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �Ի��İ�� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", ""),    // ��������
				vo.get("SEQ_NO"),                                 // SEQ ��ȣ
				vo.get("OCC_CD"),                                 // �����ڵ�
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("APP_CD"),                                 // �߷ɱ����ڵ�
				vo.get("HEAD_CD"),                               // �����ڵ�
				vo.get("DPT_CD"),                                 // �Ҽ��ڵ�
				vo.get("TEAM_CD"),                               // ���ڵ�
				vo.get("DUTY_CD"),                               // ��å�ڵ�
				vo.get("SRV_CD"),                                 // �����ڵ�
				vo.get("PART_CD"),                               // �ι��ڵ�
				vo.get("CHIEF_YN"),                               // �忩��
				vo.get("JOB_CD"),                                 // �����ڵ�
				vo.get("HOB_CD"),                                 //ȣ���ڵ�
				vo.get("JCD_CD"),                                 // ���������ڵ�
				vo.get("APP_YMD").replaceAll("-", ""),   // �߷�����
				vo.get("REMARK"),                                // �������
				vo.get("TAX_DPT"),                               // ȸ��μ�
				p_box.get("vusrid"),            // �Է���
				p_box.get("vusrid")             // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * �λ�߷ɻ��׿� ���� �������̺� �λ�߷ɳ��� �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_01(GauceValueObject vo, CBox p_box, String GBN) throws CException {

		String sql = null;
		Object[][] bind =  null;

		/** �ܺ� XML���� �λ�߷ɻ��׿� ���� �������̺� �λ�߷ɳ��� �ݿ��ϴ� SQL ���� **/
		if (GBN.equals("1")) {
		    sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_INS_T_CM_AHISTORY(?, ?, ?, ?) }";

		    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // ���
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // ��������
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ��ȣ
				    {"IN", "", p_box.get("vusrid"), ""}                  // �Է���
		    };

			//System.out.println("iENO_NO  := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO  := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}
		else if (GBN.equals("2")) {
			sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_UPT_T_CM_AHISTORY(?, ?, ?, ?,?) }";

		    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // ���
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // ��������
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ��ȣ
				    {"IN", "", vo.get("OLD_APP_CD"), ""},                             // OLD�߷ɱ���
				    {"IN", "", p_box.get("vusrid"), ""}                  // �Է���
		    };

			//System.out.println("iENO_NO     := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD    := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO     := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iOLD_APP_CD := "+"'"+JSPUtil.rns(vo.get("OLD_APP_CD"))+"';");
			//System.out.println("iIPT_MAN    := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}
		else if (GBN.equals("3")) {
		    sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_DEL_T_CM_AHISTORY(?, ?, ?, ?) }";

		    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // ���
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // ��������
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ��ȣ
				    {"IN", "", p_box.get("vusrid"), ""}                  // �Է���
		    };

			//System.out.println("iENO_NO  := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO  := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * �Ի��İ�� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),                                 // �����ڵ�
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("APP_CD"),                                 // �߷ɱ����ڵ�
				vo.get("HEAD_CD"),                               // �����ڵ�
				vo.get("DPT_CD"),                                 // �Ҽ��ڵ�
				vo.get("TEAM_CD"),                               // ���ڵ�
				vo.get("DUTY_CD"),                               // ��å�ڵ�
				vo.get("SRV_CD"),                                 // �����ڵ�
				vo.get("PART_CD"),                               // �ι��ڵ�
				vo.get("CHIEF_YN"),                               // �忩��
				vo.get("JOB_CD"),                                 // �����ڵ�
				vo.get("HOB_CD"),                                 //ȣ���ڵ�
				vo.get("JCD_CD"),                                 // ���������ڵ�
				vo.get("APP_YMD").replaceAll("-", ""),   // �߷�����
				vo.get("REMARK"),                                // �������
				vo.get("TAX_DPT"),                               // ȸ��μ�
				p_box.get("vusrid"),            // ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", ""),    // ��������
				vo.get("SEQ_NO")                                  // SEQ ��ȣ
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �Ի��İ�� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("STR_YMD").replaceAll("-", ""),    // ��������
				vo.get("SEQ_NO")                                  // SEQ ��ȣ
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}

	/**
	 * ���Ի翩�� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA025_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �����Ի��� �ݿ�
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_UPT_01(GauceValueObject vo1, GauceValueObject vo2, CBox p_box) throws CException {

		/** �ܺ� XML���� �Ի��İ�� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_UPT_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo2.get("HIR_YMD").replaceAll("-", ""),  // �����Ի���
				vo2.get("HIRG_YMD").replaceAll("-", ""), // �����׷��Ի���
				p_box.get("vusrid"),              // ������
				vo1.get("ENO_NO"),                       // ������
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
     * �λ������� ���� üũ
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet PIRA025_SHR_02(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� ���ε�� (��ȸ) SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),
				vo.get("ENO_NO"),
		};

		return this.selectProcess(sql, bind, this.prop);

	}

	/**
	 * �λ������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_02(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {

				p_box.get("vusrid"),   // �Է���
				p_box.get("vusrid"),   // ������
                vo.get("ENO_NO"),             // ���
                vo.get("ENO_NO"),             // ���
                vo.get("ENO_NO"),             // ���
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
	public void PIRA025_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �α��λ�� ������ �����ϰų� �����ϴ� SQL ���� **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                        // ȸ�����
				{"IN", "", vo.get("ENO_NO"), ""},                                  // ���
				{"IN", "", "", ""},                                                // �����ڵ�
				{"IN", "", "", ""},                                                // �μ��ڵ�
				{"IN", "", p_box.get("vusrid"), ""}                         // ���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}

	
	/**
	 * ���� ������ Payroll.Hiperson ���� �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_04(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �α��λ�� ������ �����ϰų� �����ϴ� SQL ���� **/
		String sql = "{ call ASNHR.PKG_XF_PAYROLL_INS.SF_INS_PAYROLL_HIPERSON(?,?,?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {

				{"IN", "", vo.get("ENO_NO"), ""},                                  // ���
				{"IN", "", vo.get("DPT_CD"), ""},                                  // �Ҽ��ڵ�
				{"IN", "", vo.get("JOB_CD"), ""},                                  // �����ڵ�

		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}	
	
	
	
	
	/**
	 * ���� �α��� ������ COMMON.GD0080, COMMON.MENU_AUTH ���� �ݿ��ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_05(GauceValueObject vo, CBox p_box) throws CException {

		
		
		byte pbData[]   = new byte[0];      //������Է� ��
		byte pbCipher[] = new byte[32];     //��ȣ��
		
		int Plaintext_length=0;  //�򹮱��� 
		String strEncryptPW="";  //��ȣ��
		StringBuffer sb = new StringBuffer();
		String strEncodePW = "";             //��ȣ���� ���ڵ� �� ����

		String pwd 	= "hda"+vo.get("ENO_NO")+"!"; //����Ʈ ��ȣ
		
		pbData =  pwd.getBytes();
		Plaintext_length = pwd.length();
		
		//pbData : ��
		//Plaintext_length : �򹮱���
		//pbCipher : ��ȣ��
		
	    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
	    
		 sb = new StringBuffer(); 
		 
		 for(int j = 0 ; j < pbCipher.length ; j++){
                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
          }
		 
		 //��ȣ�� 
		strEncryptPW = sb.toString();				

		
		/** �ܺ� XML���� �α��λ�� ������ �����ϰų� �����ϴ� SQL ���� **/
		String sql = "{ call ASNHR.PKG_XF_COMMON_INS.SF_INS_COMMON(?, ?) }";

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
		Object[][] bind = new Object[][] {

				{"IN", "", vo.get("ENO_NO"), ""},                                  // ���
				{"IN", "", strEncryptPW, ""},                                      // ���� ���
		};

		/** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
		this.executeProcedure(sql, bind, null);

	}		
	

	/**
	 * �λ������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_06(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �λ������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
                vo.get("ENO_NO"),             	// ���
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}
	
}
