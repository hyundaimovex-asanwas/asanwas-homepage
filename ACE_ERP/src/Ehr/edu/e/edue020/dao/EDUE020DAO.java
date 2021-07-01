package Ehr.edu.e.edue020.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE020DAO extends AbstractDAO {
	/**
	 * EDUE020DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ����������û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE020_SHR_00(CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_SHR_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                         // �α��λ��
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ����������û�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE020_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_SHR_01");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		/** ���������� '�系/���/���ͳ�'�� ���
		if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("1")) {
			sb.append("AND 1 = 1");
		}
		/** ���������� '�系/���'�� ���
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '1'");
			sb.append("OR  EDU_GBN_CD = '2')");
		}
		/** ���������� '�系/���ͳ�'�� ���
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '1'");
			sb.append("OR  EDU_GBN_CD = '3')");
		}
		/** ���������� '�系'�� ���
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '1')");
		}
		/** ���������� '���/���ͳ�'�� ���
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '2'");
			sb.append("OR  EDU_GBN_CD = '3')");
		}
		/** ���������� '���'�� ���
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '2')");
		}
		/** ���������� '���ͳ�'�� ���
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '3')");
		} */


        if(!JSPUtil.rns(p_box.get("STR_YMD")).equals("")) {
            sb.append("AND A.EDU_STR_YMD >= '"+JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "")+"'");
        }
        if(!JSPUtil.rns(p_box.get("END_YMD")).equals("")) {
            sb.append("AND A.EDU_STR_YMD <= '"+JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "")+"'");
        }


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
            //    p_box.get("ENO_NO"),
            //    p_box.get("DPT_CD")
		};

        prop.add("SUM_AMT", ColumnProp.COLUMN_TYPE_DECIMAL , 1000, ColumnProp.CONSTRAINT_TB_NOTNULL);

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ����������û��  INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // ���
				vo.get("EDU_TXT"),                           // ����������
				vo.get("EDU_GBN_CD"),                        // ���������ڵ�
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // ������������
				vo.get("EDU_END_YMD").replaceAll("-",""),    // ������������
				vo.get("GOAL_TXT"),                          // ��������
				vo.get("EDU_GBN_TXT"),                       // �������
				vo.get("PLACE_TXT"),                         // �������
				vo.get("CONTENT_TXT"),                       // ��������
				vo.get("COST_AMT"),                          // �������
				vo.get("FIX_NO"),                            // �����ο�
				vo.get("INS_YN"),                            // ȯ�޿���
				vo.get("RTN_AMT"),                           // ȯ�޿����
				vo.get("STS_GBN"),                           // ó����Ȳ
				p_box.get("vusrid"),                         // �Է���
				p_box.get("vusrid"),                         // ������,		SITE_TAG,	 EFFECT_TAG,  CPT_TAG
				vo.get("OBJ_TAG"),                           // ���
				vo.get("SITE_TAG").replaceAll("http://",""),                       // �������Ʈ
				vo.get("EFFECT_TAG"),                        // ȿ��
				vo.get("CPT_TAG")                            // �������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	public void EDUE020_INS_OBJT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_INS_OBJT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                        // �����ڵ�
				vo.get("ENO_NO"),                                        // ����
				p_box.get("DPT_CD"),                                  // �Ҽ�
				p_box.get("JOB_CD"),                                  // ����
				p_box.get("vusrid"),                                 // �Է���
				p_box.get("vusrid")                                  // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * ����������û��  UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // ����������
				vo.get("CHASU_TXT"),                                  // ������
				vo.get("EDU_GBN_CD"),                                // ���������ڵ�
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // ������������
				vo.get("EDU_END_YMD").replaceAll("-",""),    // ������������
				vo.get("GOAL_TXT"),                                     // ��������
				vo.get("EDU_GBN_TXT"),                              // �������
				vo.get("PLACE_TXT"),                                   // �������
				vo.get("CONTENT_TXT"),                              // ��������
				vo.get("COST_AMT"),                                    // �������
				vo.get("FIX_NO"),                                          // �����ο�
				vo.get("INS_YN"),                                         // ȯ�޿���
				vo.get("RTN_AMT"),                                     // ȯ�޿����
				p_box.get("vusrid"),                         // ������
				vo.get("OBJ_TAG"),                           // ���
				vo.get("SITE_TAG"),                          // �������Ʈ
				vo.get("EFFECT_TAG"),                        // ȿ��
				vo.get("CPT_TAG"),                            // �������
				vo.get("ORD_NO"),                              // �Ϸù�ȣ
				vo.get("ENO_NO")                              // ���

		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	/**
	 * ����������û�� ��û ���º���.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_UPT_00(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_UPT_00");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�������) **/
		Object[] bind = new Object[] {
				vo.get("STS_GBN"),                                         // ȯ�޿���
				p_box.get("vusrid"),                                    // ������
				vo.get("ORD_NO")                                       // �Ϸù�ȣ
		};

		/** UPDATE �޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ����������û�� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ����������û�� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // �Ϸù�ȣ
				vo.get("ENO_NO")                                        // ���
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
	/**
     * ����/���� ����, ������û���
     * @param p_box
     * @throws CException
     */
    public CBox EDUE020_PROC(CBox p_box) throws CException {

        /** �޿� �۾��α� ����  **/
        String sql = "{ call PKG_XF_EDUE020.SF_CREATE_EDU_COURSE(?, ?, ?, ?) }";

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� (���Ǵ��) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",             JSPUtil.rns(p_box.get("ORD_NO")),           ""                                  },
                {"IN",      "",             JSPUtil.rns(p_box.get("vusrid")),    ""                                  },

                {"IN/OUT",  "TEMP_S1",      "",                                         String.valueOf(OracleTypes.VARCHAR) },
                {"IN/OUT",  "TEMP_S2",      "",                                         String.valueOf(OracleTypes.VARCHAR) }
        };

        /** EXECUTEPROCEDURE �޼ҵ� ȣ��  **/
        CBox result = (CBox)this.executeProcedure(sql, bind, null);
        Log.debug.println(result);
        return result;
    }
}
