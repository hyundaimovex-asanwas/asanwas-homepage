package Ehr.edu.e.edue032.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE032DAO extends AbstractDAO {
	/**
	 * EDUE032DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE032DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}
	/**
	 * ��Ϲ�ȣ�� MaxPlusOne �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String EDUE032_SHR_MAX() throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "APPROVAL_REGNO_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");
		return reg_no;
	}
	/**
	 * �������� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUE_APPROVAL_INS(GauceValueObject vo, CBox p_box) throws CException {

		System.out.println("vo:::::::"+vo);
		
		System.out.println("p_box:::::::"+p_box);
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("edu", "APPROVAL_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				//JSPUtil.rns(p_box.get("SESSION_ENONO")),
				//JSPUtil.rns(p_box.get("SESSION_ENONO")),
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * (����) ��ܰ��¿�û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_00(CBox p_box) throws CException {

		/** �ܺ� XML���� ����� �ش� ���¸� ��û�� ��� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_00");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_ENONO"),          // �α��λ��
				p_box.get("EDU_CD")                         // ���������ڵ�
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (���) ��ܰ��¿�û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �ش� ���¸� ��û�� ������� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_01");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("EDU_CD"),                          // ���������ڵ�
				p_box.get("SEQ_NO")                          // SEQ��ȣ
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (����) ��ܰ��¿�û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ����� �ش� ���¸� ��û�� ��� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_02");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("EDU_CD")                         // ���������ڵ�
				
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (����) ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� ����� �ش� ���¸� ��û�� ��� ��ܰ��¿�û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_03");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_ENONO"),
				p_box.get("vusrid"),
				p_box.get("EDU_CD"),                         // ���������ڵ�
				p_box.get("SEQ_NO")
		};

		
		System.out.println("ENO_NO::::"+p_box.get("ENO_NO"));
        /** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * ��ܰ��¿�û��  INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE032_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		System.out.println("st2_1");

		/** �ܺ� XML���� ��ܰ��¿�û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_INS");
		
		System.out.println("st2_2");

//		ENO_NO, STR_YMD, OCC_CD, 
//		   END_YMD, EDU_CD, SEQ_NO, 
//		   EDU_GBN_CD, PLACE_CD, CPT_PNT, 
//		   EDU_NM, INT_NAM, DPT_CD, 
//		   JOB_CD, EDU_AMT
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                                    // ��û�ڻ��
				vo.get("EDU_STR_YMD").replaceAll("-",""),               // ������������
				p_box.get("ENO_NO"),                                    // ���
				
				vo.get("EDU_END_YMD").replaceAll("-",""),               // ������������
				vo.get("EDU_CD"),                                       // �����ڵ�
				vo.get("SEQ_NO"),                                       // ����
				vo.get("EDU_GBN_CD"),                                   // ����
				vo.get("PLACE_CD"),                                     // ����������
				vo.get("CPT_PNT"),                                      // ����������
				vo.get("EDU_NM"),                                       // �������
				vo.get("INT_NAM"),                                      // �������
				p_box.get("DPT_CD"),                                    // �Ҽ�
				p_box.get("JOB_CD"),                                    // ����
				p_box.get("EDU_AMT"),                                   // ����
				vo.get("REQ_NO"),                                       // �������
				//p_box.get("SESSION_ENONO"),                             // �Է���
				//p_box.get("SESSION_ENONO")                              // ������
				p_box.get("ENO_NO"),                                    // ���
				p_box.get("ENO_NO")                                     // ���
		};
		
		
		System.out.println("st2_3");
		
		System.out.println("sql::::"+sql);
		
		System.out.println("ENO_NO::::"+p_box.get("ENO_NO"));
		System.out.println("SESSION_ENONO::::"+p_box.get("SESSION_ENONO"));

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
		System.out.println("st2_END");
	}
	
	/**
	 * ��ܰ��¿�û�� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */ 
	public void EDUE032_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ��ܰ��¿�û�� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                    // ���
				vo.get("EDU_CD"),                    // ���������ڵ�
				vo.get("SEQ_NO")                     // ����
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
	public void EDUE032_APP(CBox p_box) throws CException {
	    String sql      = XmlSqlUtils.getSQL("edu", "EDUE032_APP");
        String ret_cd   = JSPUtil.rns(p_box.get("RET_CD"));
        String gun_cd   = JSPUtil.rns(p_box.get("GBN_CD"));
        String str_ymd  = JSPUtil.rns(p_box.get("STR_YMD"));
        String end_ymd  = JSPUtil.rns(p_box.get("END_YMD"));
        String dpt_cd   = JSPUtil.rns(p_box.get("DPT_CD"));

		StringBuffer sb = new StringBuffer();

        sb.append("AND TO_CHAR(HIR_YMD, 'YYYYMMDD') <= '"+end_ymd+"'");
        //�����ڸ�
        if(ret_cd.equals("1")) {
            sb.append("AND (RET_YMD IS NULL");
            sb.append(" OR  TO_CHAR(RET_YMD, 'YYYYMMDD') >= '"+str_ymd+"')\n");
        }
        //�����ڸ�
        else if(ret_cd.equals("2")) {
            sb.append("AND RET_YMD IS NOT NULL");
            sb.append("AND TO_CHAR(RET_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //�Ի��ڸ�
        else if(ret_cd.equals("3")) {
            sb.append("AND TO_CHAR(HIRD_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }


		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString(),
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);
		Object[] bind = new Object[] {
				dpt_cd,
				dpt_cd,
				dpt_cd,
				dpt_cd
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
}
