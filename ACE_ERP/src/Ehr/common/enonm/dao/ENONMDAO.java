package Ehr.common.enonm.dao;

import Ehr.common.util.JSPUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ENONMDAO extends AbstractDAO {
	/**
	 * EDUG010DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ENONMDAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 *������ �Ǵ� �İ߻���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_01");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		/** �˻������� �������� ��� */
		if (p_box.get("GBN").equals("0")) {
			// ����/���� ���о���
			if (p_box.get("RET_CD").equals("0")) {
				sb.append("                   ACC_NO,\n");
                sb.append("                   TO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD, 'YYYY-MM-DD')       AS RAM_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD2, 'YYYY-MM-DD')       AS RAM_YMD2,\n");
				sb.append("                   TO_CHAR(RAM_YMD3, 'YYYY-MM-DD')       AS RAM_YMD3\n");
			    sb.append("FROM ASNHR.T_CM_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// �������� �����
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("                   ' ' AS ACC_NO,\n");
				sb.append("                   TO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD, 'YYYY-MM-DD')       AS RAM_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD2, 'YYYY-MM-DD')       AS RAM_YMD2,\n");
				sb.append("                   TO_CHAR(RAM_YMD3, 'YYYY-MM-DD')       AS RAM_YMD3\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR    RET_YMD >= SYSDATE)\n");
			}
		}
		/** �˻������� �İ߻���� ��� */
		else if (p_box.get("GBN").equals("2")) {
            // ����/���� ���о���
			if (p_box.get("RET_CD").equals("0")) {
				sb.append("                   TO_CHAR(HIR_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD2,\n");
				sb.append("                   NULL       AS RAM_YMD3\n");
			    sb.append("FROM ASNHR.T_ME_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// �������� �����
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("                   TO_CHAR(HIR_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD2,\n");
				sb.append("                   NULL       AS RAM_YMD3\n");
				sb.append("FROM ASNHR.T_ME_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR         RET_YMD >= SYSDATE)\n");
			}
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")              // ���
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��ü�����  SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_02");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

        // ����/���� ���о���
		if (p_box.get("RET_CD").equals("0")) {
		    sb.append("AND 1 = 1\n");
	    }
		// �������� �����
		else if (p_box.get("RET_CD").equals("1")) {
			sb.append("AND (A.RET_YMD IS NULL\n");
		    sb.append("OR    A.RET_YMD >= SYSDATE)\n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")              // ���
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 *������ �Ǵ� �İ߻���� ��� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_03");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		/** �˻������� �������� ��� */
		if (p_box.get("GBN").equals("0")) {
			// ����/���� ���о���
			if (p_box.get("RET_CD").equals("0")) {
				sb.append(", \nTO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// �������� �����
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append(", \nTO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR    RET_YMD >= SYSDATE)\n");
			}
		}
		/** �˻������� �İ߻���� ��� */
		else if (p_box.get("GBN").equals("2")) {
            // ����/���� ���о���
			if (p_box.get("RET_CD").equals("0")) {
			    sb.append("FROM ASNHR.T_ME_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// �������� �����
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("FROM ASNHR.T_ME_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR         RET_YMD >= SYSDATE)\n");
			}
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//System.out.println("p_box   =========================================== " + p_box);
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("ENO_NM")),
				//JSPUtil.rns(p_box.get("ENO_NM")),
				//p_box.get("ENO_NM")              // ����
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��ü��� ���  SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_04");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

        // ����/���� ���о���
		if (p_box.get("RET_CD").equals("0")) {
		    sb.append("AND 1 = 1\n");
	    }
		// �������� �����
		else if (p_box.get("RET_CD").equals("1")) {
			sb.append("AND (A.RET_YMD IS NULL OR A.RET_YMD >= SYSDATE) \n");
		    //sb.append("OR    A.RET_YMD >= SYSDATE)\n");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

        //System.out.println("p_box   =========================================== " + p_box);	
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				//JSPUtil.rns(p_box.get("ENO_NM")),
				p_box.getString("ENO_NM")              // ����
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}
